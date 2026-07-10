#!/usr/bin/env python3
"""Immutable staging deploy/rollback helpers (testable, no secret logging)."""
from __future__ import annotations

import hashlib
import json
import os
import re
import shutil
import stat
import subprocess
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Callable, Protocol

from urllib.parse import urlparse

DEFAULT_STAGING_ROOT = '/opt/staging/apps/formulaeapps'
APPROVED_STAGING_BFF_BASE_URL = 'https://staging.api.formulaeapps.com'
HOST_ROLE_MARKER = Path('/etc/capdesis-role')
EXPECTED_HOST_ROLE = 'staging'
SYNC_TMP_PREFIX = '.sync-'
RSYNC_EXCLUDE_TOP_LEVEL = frozenset(
    {'.git', '.env', '.staging-state', 'current', 'releases', 'pro', 'community', 'landing'}
)
STATE_DIR_NAME = '.staging-state'
STATE_FILE_NAME = 'deploy-state.json'
RELEASES_DIR_NAME = 'releases'
CURRENT_LINK_NAME = 'current'
PERSISTENT_ENV_NAME = '.env.staging'
COMPOSE_FILE = 'docker-compose.staging.yml'
COMPOSE_PROJECT = 'formulaeapps-staging'
SERVICE_NAME = 'bff'
SHA_RE = re.compile(r'^[0-9a-f]{40}$')
PROD_MAX_WINDOW_MS = 7_200_000
STAGING_MAX_WINDOW_MS = 1_200_000  # 20 minutes — fits 45m deploy job budget
READINESS_TIMEOUT_SEC = 300
READINESS_INTERVAL_SEC = 5


class CommandError(RuntimeError):
    pass


class Runner(Protocol):
    def run(
        self,
        args: list[str],
        *,
        cwd: Path | None = None,
        check: bool = True,
        capture: bool = False,
        env: dict[str, str] | None = None,
    ) -> subprocess.CompletedProcess[str]: ...


@dataclass(frozen=True)
class SubprocessRunner:
    def run(
        self,
        args: list[str],
        *,
        cwd: Path | None = None,
        check: bool = True,
        capture: bool = False,
        env: dict[str, str] | None = None,
    ) -> subprocess.CompletedProcess[str]:
        return subprocess.run(
            args,
            cwd=str(cwd) if cwd else None,
            check=check,
            capture_output=capture,
            text=True,
            env=env,
        )


def normalize_sha(value: str) -> str:
    sha = value.strip().lower()
    if not SHA_RE.fullmatch(sha):
        raise ValueError('candidate_sha must be a 40-character lowercase hex SHA')
    return sha


def parse_utc_z(value: str) -> datetime:
    if not value.endswith('Z'):
        raise ValueError('timestamps must use UTC Z suffix')
    body = value[:-1]
    utc = timezone.utc
    if '.' in body:
        base, frac = body.split('.', 1)
        if not frac.isdigit():
            raise ValueError('fractional seconds must be numeric')
        dt = datetime.strptime(base, '%Y-%m-%dT%H:%M:%S').replace(tzinfo=utc)
        micros = int(frac.ljust(6, '0')[:6])
        return dt.replace(microsecond=micros)
    return datetime.strptime(body, '%Y-%m-%dT%H:%M:%S').replace(tzinfo=utc)


def validate_legacy_window(start: str, cutoff: str, *, max_window_ms: int = PROD_MAX_WINDOW_MS) -> None:
    if not start or not cutoff:
        raise ValueError('legacy window start and cutoff are both required')
    start_dt = parse_utc_z(start)
    cutoff_dt = parse_utc_z(cutoff)
    delta_ms = int((cutoff_dt - start_dt).total_seconds() * 1000)
    if delta_ms <= 0:
        raise ValueError('legacy window cutoff must be strictly after start')
    if delta_ms > max_window_ms:
        raise ValueError(f'legacy window exceeds allowed maximum ({max_window_ms} ms)')


def validate_staging_job_window(start: str, cutoff: str, *, job_timeout_minutes: int = 45) -> None:
    validate_legacy_window(start, cutoff, max_window_ms=STAGING_MAX_WINDOW_MS)
    start_dt = parse_utc_z(start)
    cutoff_dt = parse_utc_z(cutoff)
    window_sec = (cutoff_dt - start_dt).total_seconds()
    budget_sec = job_timeout_minutes * 60
    if window_sec > budget_sec - 600:
        raise ValueError('staging legacy window must fit within deploy job timeout budget')


def validate_legacy_window_dispatch_remaining(
    start: str,
    cutoff: str,
    *,
    min_remaining_sec: int = 900,
    now_fn: Callable[[], datetime] | None = None,
) -> None:
    now = now_fn() if now_fn else datetime.now(timezone.utc)
    start_dt = parse_utc_z(start)
    cutoff_dt = parse_utc_z(cutoff)
    if start_dt > now:
        raise ValueError('legacy window start must not be in the future at dispatch')
    remaining = (cutoff_dt - now).total_seconds()
    if remaining < min_remaining_sec:
        raise ValueError('legacy window must leave enough remaining time for deploy and smokes')


def resolve_allowed_root(app_path: str, allowed_root: str = DEFAULT_STAGING_ROOT) -> Path:
    if not app_path or app_path.strip() in {'', '/'}:
        raise ValueError('app_path must be a non-empty path under the staging root')
    candidate = Path(app_path)
    if candidate.is_symlink():
        raise ValueError('app_path must not be a symlink')
    resolved = candidate.resolve(strict=False)
    root = Path(allowed_root).resolve(strict=False)
    try:
        resolved.relative_to(root)
    except ValueError as exc:
        raise ValueError('app_path must stay under the allowed staging root') from exc
    if resolved != root and not str(resolved).startswith(str(root) + os.sep):
        raise ValueError('app_path must stay under the allowed staging root')
    return resolved


def verify_host_role(marker_path: Path | None = None, expected: str = EXPECTED_HOST_ROLE) -> None:
    marker = marker_path if marker_path is not None else HOST_ROLE_MARKER
    if not marker.is_file():
        raise RuntimeError(f'missing host role marker: {marker}')
    role = marker.read_text().strip()
    if role != expected:
        raise RuntimeError(f'host role marker must be exactly {expected!r}, got {role!r}')


def state_dir(root: Path) -> Path:
    return root / STATE_DIR_NAME


def state_path(root: Path) -> Path:
    return state_dir(root) / STATE_FILE_NAME


def releases_dir(root: Path) -> Path:
    return root / RELEASES_DIR_NAME


def release_path(root: Path, sha: str) -> Path:
    normalized = normalize_sha(sha)
    path = releases_dir(root) / normalized
    if path.is_symlink():
        raise ValueError('release path must not be a symlink')
    return path


def current_link(root: Path) -> Path:
    return root / CURRENT_LINK_NAME


def persistent_env_path(root: Path) -> Path:
    return root / PERSISTENT_ENV_NAME


def chmod_sensitive(path: Path) -> None:
    if path.exists():
        path.chmod(stat.S_IRUSR | stat.S_IWUSR)


def ensure_private_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)
    path.chmod(stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)


def write_private_json(path: Path, payload: dict) -> None:
    ensure_private_dir(path.parent)
    path.write_text(json.dumps(payload, separators=(',', ':'), sort_keys=True) + '\n')
    chmod_sensitive(path)


def read_json(path: Path) -> dict:
    return json.loads(path.read_text())


def current_release_dir(root: Path) -> Path | None:
    link = current_link(root)
    if not link.is_symlink():
        return None
    target = Path(os.readlink(link))
    if not target.is_absolute():
        target = (root / target).resolve(strict=False)
    return target


def deployed_sha_for_release(release: Path) -> str:
    marker = release / 'DEPLOYED_SHA'
    if marker.is_file():
        return marker.read_text().strip()
    return ''


def validate_readiness_base_url(value: str) -> str:
    parsed = urlparse(value.strip())
    if parsed.scheme != 'https' or not parsed.netloc:
        raise ValueError('readiness base URL must be an https URL with a host')
    if parsed.username or parsed.password or parsed.params or parsed.query or parsed.fragment:
        raise ValueError('readiness base URL must not include credentials or fragments')
    if re.search(r'[;&|`$<>]', parsed.netloc):
        raise ValueError('readiness base URL host contains forbidden characters')
    normalized = f'{parsed.scheme}://{parsed.netloc}'
    if normalized != APPROVED_STAGING_BFF_BASE_URL:
        raise ValueError(f'readiness base URL must be exactly {APPROVED_STAGING_BFF_BASE_URL}')
    return APPROVED_STAGING_BFF_BASE_URL


def validate_deploy_queue_window(
    start: str,
    cutoff: str,
    *,
    now_fn: Callable[[], datetime] | None = None,
) -> None:
    """Revalidate legacy window at deploy job start (covers queue wait)."""
    now = now_fn() if now_fn else datetime.now(timezone.utc)
    cutoff_dt = parse_utc_z(cutoff)
    if now >= cutoff_dt:
        raise ValueError('legacy window expired during queue wait')
    validate_legacy_window_dispatch_remaining(start, cutoff, now_fn=lambda: now)


def _is_excluded_candidate_rel(rel: Path) -> bool:
    if rel.parts and rel.parts[0] in RSYNC_EXCLUDE_TOP_LEVEL:
        return True
    if rel.name in {'.env', 'DEPLOYED_SHA'} or rel.name.startswith('.env.'):
        return True
    return False


def compute_candidate_digest(root: Path) -> str:
    entries: list[str] = []
    for path in sorted(root.rglob('*')):
        if not path.is_file():
            continue
        rel = path.relative_to(root)
        if _is_excluded_candidate_rel(rel):
            continue
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        entries.append(f'{rel}:{digest}')
    return hashlib.sha256('\n'.join(entries).encode()).hexdigest()


def sync_temp_path(root: Path, sha: str) -> Path:
    return releases_dir(root) / f'{SYNC_TMP_PREFIX}{normalize_sha(sha)}'


def validate_sync_guards(
    root: Path,
    sha: str,
    *,
    expected_digest: str | None = None,
) -> dict[str, str]:
    verify_host_role()
    resolved = resolve_allowed_root(str(root), DEFAULT_STAGING_ROOT)
    if resolved.is_symlink():
        raise ValueError('app_path must not be a symlink')
    normalized = normalize_sha(sha)
    final = release_path(resolved, normalized)
    temp = sync_temp_path(resolved, normalized)
    if temp.is_symlink():
        raise ValueError('temp sync path must not be a symlink')
    skip_sync = 'false'
    if final.is_dir():
        if expected_digest and compute_candidate_digest(final) == expected_digest:
            skip_sync = 'true'
        else:
            raise RuntimeError(f'release already exists with different content: {final}')
    elif final.exists():
        raise RuntimeError(f'release path already exists: {final}')
    return {
        'app_path': str(resolved),
        'candidate_sha': normalized,
        'release_path': str(final),
        'temp_sync_path': str(temp),
        'release_exists': str(final.is_dir()).lower(),
        'skip_sync': skip_sync,
    }


def finalize_synced_release(root: Path, sha: str, expected_digest: str) -> None:
    resolved = resolve_allowed_root(str(root), DEFAULT_STAGING_ROOT)
    normalized = normalize_sha(sha)
    temp = sync_temp_path(resolved, normalized)
    final = release_path(resolved, normalized)

    if not temp.is_dir():
        raise RuntimeError(f'sync temp directory is missing: {temp}')

    actual_digest = compute_candidate_digest(temp)
    if actual_digest != expected_digest:
        raise RuntimeError('sync manifest digest does not match expected value')

    if final.is_dir():
        existing_digest = compute_candidate_digest(final)
        if existing_digest == actual_digest:
            shutil.rmtree(temp)
            return
        raise RuntimeError(f'release already exists with different content: {final}')

    if final.exists():
        raise RuntimeError(f'release path already exists: {final}')

    temp.rename(final)


def capture_baseline(root: Path, runner: Runner) -> dict[str, str]:
    active = current_release_dir(root)
    prior_sha = deployed_sha_for_release(active) if active else ''
    prior_release = ''
    prior_env = ''
    if active:
        try:
            prior_release = str(active.relative_to(root))
        except ValueError:
            prior_release = str(active)
        env_file = active / '.env'
        if env_file.is_file():
            prior_env = env_file.read_text()
    prior_image = ''
    if active and (active / COMPOSE_FILE).is_file():
        result = runner.run(
            ['docker', 'compose', '-f', COMPOSE_FILE, '-p', COMPOSE_PROJECT, 'images', '-q', SERVICE_NAME],
            cwd=active,
            check=False,
            capture=True,
        )
        if result.returncode == 0 and result.stdout.strip():
            prior_image = result.stdout.strip().splitlines()[-1]
    tagged = docker_image_tag(prior_sha) if prior_sha else ''
    if not prior_image and prior_sha:
        inspect = runner.run(['docker', 'image', 'inspect', tagged], check=False, capture=True)
        if inspect.returncode == 0 and inspect.stdout.strip():
            prior_image = tagged
    return {
        'prior_sha': prior_sha,
        'prior_release': prior_release,
        'prior_image': prior_image,
        'prior_env': prior_env,
    }


def require_baseline(baseline: dict[str, str], *, bootstrap: bool = False) -> None:
    if bootstrap:
        return
    if not baseline.get('prior_sha') or not baseline.get('prior_release'):
        raise RuntimeError(
            'refusing first deploy without an existing baseline; use explicit bootstrap mode when approved'
        )


def overlay_legacy_window(env_text: str, legacy_start: str, legacy_cutoff: str) -> str:
    lines: list[str] = []
    present = set()
    for line in env_text.splitlines():
        if line.startswith('JWT_LEGACY_VERIFY_ENABLED='):
            lines.append('JWT_LEGACY_VERIFY_ENABLED=true')
            present.add('JWT_LEGACY_VERIFY_ENABLED')
        elif line.startswith('JWT_LEGACY_VERIFY_START='):
            lines.append(f'JWT_LEGACY_VERIFY_START={legacy_start}')
            present.add('JWT_LEGACY_VERIFY_START')
        elif line.startswith('JWT_LEGACY_VERIFY_CUTOFF='):
            lines.append(f'JWT_LEGACY_VERIFY_CUTOFF={legacy_cutoff}')
            present.add('JWT_LEGACY_VERIFY_CUTOFF')
        else:
            lines.append(line)
    text = '\n'.join(lines)
    if text and not text.endswith('\n'):
        text += '\n'
    for key, value in (
        ('JWT_LEGACY_VERIFY_ENABLED', 'true'),
        ('JWT_LEGACY_VERIFY_START', legacy_start),
        ('JWT_LEGACY_VERIFY_CUTOFF', legacy_cutoff),
    ):
        if key not in present:
            text += f'{key}={value}\n'
    return text


def materialize_release_env(root: Path, release: Path, legacy_start: str, legacy_cutoff: str) -> None:
    source = persistent_env_path(root)
    if not source.is_file():
        raise RuntimeError('missing persistent .env.staging outside release tree')
    env_text = overlay_legacy_window(source.read_text(), legacy_start, legacy_cutoff)
    target = release / '.env'
    target.write_text(env_text)
    chmod_sensitive(target)


def docker_image_tag(sha: str) -> str:
    return f'formulaeapps-staging-bff:{normalize_sha(sha)}'


def build_release(release: Path, sha: str, runner: Runner) -> str:
    env = os.environ.copy()
    env['CANDIDATE_SHA'] = normalize_sha(sha)
    runner.run(
        ['docker', 'compose', '-f', COMPOSE_FILE, '-p', COMPOSE_PROJECT, 'build', SERVICE_NAME],
        cwd=release,
        env=env,
    )
    tag = docker_image_tag(sha)
    built = runner.run(
        ['docker', 'compose', '-f', COMPOSE_FILE, '-p', COMPOSE_PROJECT, 'images', '-q', SERVICE_NAME],
        cwd=release,
        capture=True,
    ).stdout.strip().splitlines()[-1]
    runner.run(['docker', 'tag', built, tag], cwd=release)
    return tag


def compose_up(release: Path, sha: str, runner: Runner, *, no_build: bool = False) -> None:
    args = ['docker', 'compose', '-f', COMPOSE_FILE, '-p', COMPOSE_PROJECT, 'up', '-d', '--no-deps', SERVICE_NAME]
    if no_build:
        args.insert(-1, '--no-build')
    env = os.environ.copy()
    env['CANDIDATE_SHA'] = normalize_sha(sha)
    runner.run(args, cwd=release, env=env)


def wait_for_readiness(
    base_url: str,
    *,
    timeout_sec: int = READINESS_TIMEOUT_SEC,
    interval_sec: int = READINESS_INTERVAL_SEC,
    sleep_fn: Callable[[float], None] = time.sleep,
    now_fn: Callable[[], float] = time.time,
) -> None:
    import urllib.error
    import urllib.request

    deadline = now_fn() + timeout_sec
    url = base_url.rstrip('/') + '/health'
    last_error = 'unknown'
    while now_fn() < deadline:
        try:
            with urllib.request.urlopen(url, timeout=10) as response:
                if response.status == 200:
                    return
                last_error = f'HTTP {response.status}'
        except urllib.error.HTTPError as exc:
            last_error = f'HTTP {exc.code}'
        except Exception as exc:  # noqa: BLE001 - surface last readiness error
            last_error = str(exc)
        sleep_fn(interval_sec)
    raise TimeoutError(f'readiness polling failed for {url}: {last_error}')


def switch_current_release(root: Path, release: Path) -> None:
    root_resolved = root.resolve()
    release_resolved = release.resolve()
    rel_target = release_resolved.relative_to(root_resolved)
    tmp = root_resolved / f'.{CURRENT_LINK_NAME}.tmp'
    if tmp.exists() or tmp.is_symlink():
        tmp.unlink()
    tmp.symlink_to(rel_target)
    tmp.replace(current_link(root_resolved))


def record_deploy_state(
    root: Path,
    baseline: dict[str, str],
    candidate_sha: str,
    candidate_release: Path,
    *,
    control_sha: str | None = None,
) -> None:
    payload = {
        **baseline,
        'candidate_sha': normalize_sha(candidate_sha),
        'candidate_release': str(candidate_release.relative_to(root)),
    }
    if control_sha:
        payload['control_sha'] = normalize_sha(control_sha)
    write_private_json(state_path(root), payload)


def deploy_candidate(
    root: Path,
    candidate_sha: str,
    legacy_start: str,
    legacy_cutoff: str,
    *,
    runner: Runner | None = None,
    bootstrap: bool = False,
    readiness_base_url: str | None = None,
    control_sha: str | None = None,
    sleep_fn: Callable[[float], None] = time.sleep,
    now_fn: Callable[[], float] = time.time,
) -> None:
    runner = runner or SubprocessRunner()
    sha = normalize_sha(candidate_sha)
    validate_legacy_window(legacy_start, legacy_cutoff, max_window_ms=STAGING_MAX_WINDOW_MS)
    if readiness_base_url:
        readiness_base_url = validate_readiness_base_url(readiness_base_url)
    release = release_path(root, sha)
    if not release.is_dir():
        raise RuntimeError(f'candidate release directory is missing: {release}')

    baseline = capture_baseline(root, runner)
    require_baseline(baseline, bootstrap=bootstrap)
    write_private_json(
        state_path(root),
        {**baseline, 'candidate_sha': sha, 'candidate_release': str(release.relative_to(root))},
    )

    try:
        materialize_release_env(root, release, legacy_start, legacy_cutoff)
        build_release(release, sha, runner)
        compose_up(release, sha, runner)
        if readiness_base_url:
            wait_for_readiness(readiness_base_url, sleep_fn=sleep_fn, now_fn=now_fn)

        (release / 'DEPLOYED_SHA').write_text(sha + '\n')
        chmod_sensitive(release / 'DEPLOYED_SHA')
        switch_current_release(root, release)
        record_deploy_state(
            root,
            baseline,
            sha,
            release,
            control_sha=control_sha,
        )
    except Exception:
        if baseline.get('prior_release') and baseline.get('prior_sha'):
            rollback_to_prior(root, runner=runner, expected_candidate_sha=sha)
        raise


def _resolve_prior_image(prior_sha: str, prior_image: str, runner: Runner) -> str:
    if prior_image:
        return prior_image
    tagged = docker_image_tag(prior_sha)
    inspect = runner.run(['docker', 'image', 'inspect', tagged], check=False, capture=True)
    if inspect.returncode == 0:
        return tagged
    raise RuntimeError('rollback refused: prior container image is missing')


def rollback_to_prior(
    root: Path,
    *,
    runner: Runner | None = None,
    expected_candidate_sha: str | None = None,
) -> None:
    runner = runner or SubprocessRunner()
    path = state_path(root)
    if not path.is_file():
        raise RuntimeError('rollback refused: no deploy state recorded outside release tree')
    state = read_json(path)
    if expected_candidate_sha:
        expected = normalize_sha(expected_candidate_sha)
        state_candidate = state.get('candidate_sha', '')
        if state_candidate != expected:
            raise RuntimeError('rollback refused: deploy state does not match this workflow candidate')
    prior_release = state.get('prior_release', '')
    prior_sha = state.get('prior_sha', '')
    prior_image = state.get('prior_image', '')
    prior_env = state.get('prior_env', '')
    if not prior_release or not prior_sha:
        raise RuntimeError('rollback refused: baseline prior release/SHA missing from state')

    release = (root / prior_release).resolve()
    if not release.is_dir():
        raise RuntimeError(f'rollback refused: prior release directory missing: {release}')

    env_file = release / '.env'
    if prior_env:
        env_file.write_text(prior_env)
        chmod_sensitive(env_file)

    switch_current_release(root, release)
    (release / 'DEPLOYED_SHA').write_text(prior_sha + '\n')
    chmod_sensitive(release / 'DEPLOYED_SHA')

    image_ref = _resolve_prior_image(prior_sha, prior_image, runner)
    tag = docker_image_tag(prior_sha)
    if image_ref != tag:
        runner.run(['docker', 'tag', image_ref, tag], cwd=release)
    compose_up(release, prior_sha, runner, no_build=True)
