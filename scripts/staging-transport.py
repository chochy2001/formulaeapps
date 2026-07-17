#!/usr/bin/env python3
"""Emit JSON transport payloads for staging deploy/rollback (no secret values)."""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from staging_lib import (
    APPROVED_STAGING_BFF_BASE_URL,
    DEFAULT_STAGING_ROOT,
    compute_candidate_digest,
    finalize_synced_release,
    normalize_sha,
    resolve_allowed_root,
    validate_legacy_window,
    validate_legacy_window_dispatch_remaining,
    validate_readiness_base_url,
    validate_staging_job_window,
    STAGING_MAX_WINDOW_MS,
)


def _read_stdin_json() -> dict:
    raw = sys.stdin.read()
    if not raw.strip():
        return {}
    return json.loads(raw)


def cmd_deploy(argv: list[str]) -> None:
    if len(argv) not in {5, 6, 7, 8}:
        raise SystemExit(
            'usage: staging-transport.py deploy <candidate_sha> <app_path> <legacy_start> <legacy_cutoff> '
            '[bootstrap] [readiness_base_url] [control_sha]'
        )
    candidate_sha = normalize_sha(argv[1])
    app_path = str(resolve_allowed_root(argv[2], DEFAULT_STAGING_ROOT))
    legacy_start = argv[3]
    legacy_cutoff = argv[4]
    bootstrap = False
    readiness_base_url = None
    control_sha = None
    extras = argv[5:]
    if extras and extras[0] == 'bootstrap':
        bootstrap = True
        extras = extras[1:]
    if extras and extras[0].startswith('https://'):
        readiness_base_url = validate_readiness_base_url(extras[0])
        extras = extras[1:]
    if extras:
        control_sha = normalize_sha(extras[0])
    validate_legacy_window(legacy_start, legacy_cutoff, max_window_ms=STAGING_MAX_WINDOW_MS)
    validate_staging_job_window(legacy_start, legacy_cutoff)
    validate_legacy_window_dispatch_remaining(legacy_start, legacy_cutoff)
    payload = {
        'action': 'deploy',
        'candidate_sha': candidate_sha,
        'app_path': app_path,
        'legacy_verify_start': legacy_start,
        'legacy_verify_cutoff': legacy_cutoff,
        'bootstrap': bootstrap,
    }
    if readiness_base_url:
        payload['readiness_base_url'] = readiness_base_url
    if control_sha:
        payload['control_sha'] = control_sha
    print(json.dumps(payload, separators=(',', ':')))


def cmd_guard(argv: list[str]) -> None:
    if len(argv) not in {3, 4}:
        raise SystemExit('usage: staging-transport.py guard <candidate_sha> <app_path> [digest]')
    candidate_sha = normalize_sha(argv[1])
    app_path = str(resolve_allowed_root(argv[2], DEFAULT_STAGING_ROOT))
    payload: dict[str, str] = {
        'action': 'guard',
        'candidate_sha': candidate_sha,
        'app_path': app_path,
    }
    if len(argv) == 4:
        digest = argv[3].strip().lower()
        if not re.fullmatch(r'[0-9a-f]{64}', digest):
            raise SystemExit('digest must be a 64-character lowercase hex SHA-256')
        payload['expected_digest'] = digest
    print(json.dumps(payload, separators=(',', ':')))


def cmd_finalize(argv: list[str]) -> None:
    if len(argv) != 4:
        raise SystemExit('usage: staging-transport.py finalize <candidate_sha> <app_path> <digest>')
    candidate_sha = normalize_sha(argv[1])
    app_path = str(resolve_allowed_root(argv[2], DEFAULT_STAGING_ROOT))
    digest = argv[3].strip().lower()
    if not re.fullmatch(r'[0-9a-f]{64}', digest):
        raise SystemExit('digest must be a 64-character lowercase hex SHA-256')
    print(
        json.dumps(
            {
                'action': 'finalize',
                'candidate_sha': candidate_sha,
                'app_path': app_path,
                'expected_digest': digest,
            },
            separators=(',', ':'),
        )
    )


def cmd_digest(argv: list[str]) -> None:
    if len(argv) != 2:
        raise SystemExit('usage: staging-transport.py digest <candidate_tree_path>')
    root = Path(argv[1]).resolve()
    if not root.is_dir():
        raise SystemExit('candidate tree path must be a directory')
    digest = compute_candidate_digest(root)
    print(json.dumps({'action': 'digest', 'digest': digest}, separators=(',', ':')))
def cmd_rollback(argv: list[str]) -> None:
    if len(argv) not in {2, 3}:
        raise SystemExit('usage: staging-transport.py rollback <app_path> [expected_candidate_sha]')
    app_path = str(resolve_allowed_root(argv[1], DEFAULT_STAGING_ROOT))
    payload = {'action': 'rollback', 'app_path': app_path}
    if len(argv) == 3:
        payload['expected_candidate_sha'] = normalize_sha(argv[2])
    print(json.dumps(payload, separators=(',', ':')))


def cmd_sync(argv: list[str]) -> None:
    if len(argv) != 3:
        raise SystemExit('usage: staging-transport.py sync <candidate_sha> <app_path>')
    candidate_sha = normalize_sha(argv[1])
    app_path = str(resolve_allowed_root(argv[2], DEFAULT_STAGING_ROOT))
    print(
        json.dumps(
            {
                'action': 'sync',
                'candidate_sha': candidate_sha,
                'app_path': app_path,
                'release_path': f'{app_path}/releases/{candidate_sha}',
                'temp_sync_path': f'{app_path}/releases/.sync-{candidate_sha}',
                'approved_base_url': APPROVED_STAGING_BFF_BASE_URL,
            },
            separators=(',', ':'),
        )
    )


def main() -> None:
    if len(sys.argv) < 2:
        raise SystemExit('usage: staging-transport.py <deploy|rollback|sync> ...')
    action = sys.argv[1]
    if action == 'deploy':
        cmd_deploy(sys.argv[1:])
    elif action == 'rollback':
        cmd_rollback(sys.argv[1:])
    elif action == 'sync':
        cmd_sync(sys.argv[1:])
    elif action == 'guard':
        cmd_guard(sys.argv[1:])
    elif action == 'finalize':
        cmd_finalize(sys.argv[1:])
    elif action == 'digest':
        cmd_digest(sys.argv[1:])
    else:
        raise SystemExit(f'unknown action: {action}')


if __name__ == '__main__':
    main()
