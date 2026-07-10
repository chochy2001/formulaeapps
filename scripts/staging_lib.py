#!/usr/bin/env python3
"""Immutable staging deploy/rollback helpers (testable, no secret logging)."""
from __future__ import annotations

import json
import os
import re
import stat
import subprocess
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Callable, Protocol

DEFAULT_STAGING_ROOT = '/opt/staging/apps/formulaeapps'
HOST_ROLE_MARKER = Path('/etc/capdesis-role')
EXPECTED_HOST_ROLE = 'staging'
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


def verify_host_role(marker_path: Path = HOST_ROLE_MARKER, expected: str = EXPECTED_HOST_ROLE) -> None:
    if not marker_path.is_file():
        raise RuntimeError(f'missing host role marker: {marker_path}')
    role = marker_path.read_text().strip()
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


def capture_baseline(root: Path, runner: Runner) -> dict[str, str]:
    active = current_release_dir(root)
    prior_sha = deployed_sha_for_release(active) if active else ''
    prior_release = ''
    if active:
        try:
            prior_release = str(active.relative_to(root))
        except ValueError:
            prior_release = str(active)
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
    return {
        'prior_sha': prior_sha,
        'prior_release': prior_release,
        'prior_image': prior_image,
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


def record_deploy_state(root: Path, baseline: dict[str, str], candidate_sha: str, candidate_release: Path) -> None:
    payload = {
        **baseline,
        'candidate_sha': normalize_sha(candidate_sha),
        'candidate_release': str(candidate_release.relative_to(root)),
    }
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
    sleep_fn: Callable[[float], None] = time.sleep,
    now_fn: Callable[[], float] = time.time,
) -> None:
    runner = runner or SubprocessRunner()
    sha = normalize_sha(candidate_sha)
    validate_legacy_window(legacy_start, legacy_cutoff, max_window_ms=STAGING_MAX_WINDOW_MS)
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
        )
    except Exception:
        if baseline.get('prior_release') and baseline.get('prior_sha'):
            rollback_to_prior(root, runner=runner)
        raise


def rollback_to_prior(
    root: Path,
    *,
    runner: Runner | None = None,
) -> None:
    runner = runner or SubprocessRunner()
    path = state_path(root)
    if not path.is_file():
        raise RuntimeError('rollback refused: no deploy state recorded outside release tree')
    state = read_json(path)
    prior_release = state.get('prior_release', '')
    prior_sha = state.get('prior_sha', '')
    prior_image = state.get('prior_image', '')
    if not prior_release or not prior_sha:
        raise RuntimeError('rollback refused: baseline prior release/SHA missing from state')

    release = (root / prior_release).resolve()
    if not release.is_dir():
        raise RuntimeError(f'rollback refused: prior release directory missing: {release}')

    signing_line = None
    env_file = release / '.env'
    if env_file.is_file():
        for line in env_file.read_text().splitlines():
            if line.startswith('JWT_SIGNING_SECRET='):
                signing_line = line
                break
    persistent = persistent_env_path(root)
    if signing_line and persistent.is_file():
        lines = [line for line in persistent.read_text().splitlines() if not line.startswith('JWT_SIGNING_SECRET=')]
        lines.append(signing_line)
        text = '\n'.join(lines) + '\n'
        persistent.write_text(text)
        chmod_sensitive(persistent)

    materialize_from_persistent = persistent.read_text() if persistent.is_file() else ''
    if materialize_from_persistent:
        env_file.write_text(materialize_from_persistent)
        chmod_sensitive(env_file)

    switch_current_release(root, release)
    (release / 'DEPLOYED_SHA').write_text(prior_sha + '\n')
    chmod_sensitive(release / 'DEPLOYED_SHA')

    if prior_image:
        tag = docker_image_tag(prior_sha)
        runner.run(['docker', 'tag', prior_image, tag], cwd=release)
        compose_up(release, prior_sha, runner, no_build=True)
    else:
        compose_up(release, prior_sha, runner)
