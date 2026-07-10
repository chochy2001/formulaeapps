#!/usr/bin/env python3
"""Emit JSON transport payloads for staging deploy/rollback (no secret values)."""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from staging_lib import (
    DEFAULT_STAGING_ROOT,
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
    if len(argv) not in {5, 6, 7}:
        raise SystemExit(
            'usage: staging-transport.py deploy <candidate_sha> <app_path> <legacy_start> <legacy_cutoff> [bootstrap] [readiness_base_url]'
        )
    candidate_sha = normalize_sha(argv[1])
    app_path = str(resolve_allowed_root(argv[2], DEFAULT_STAGING_ROOT))
    legacy_start = argv[3]
    legacy_cutoff = argv[4]
    bootstrap = False
    readiness_base_url = None
    if len(argv) >= 6 and argv[5] == 'bootstrap':
        bootstrap = True
        if len(argv) == 7:
            readiness_base_url = validate_readiness_base_url(argv[6])
    elif len(argv) == 6:
        readiness_base_url = validate_readiness_base_url(argv[5])
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
    print(json.dumps(payload, separators=(',', ':')))


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
    else:
        raise SystemExit(f'unknown action: {action}')


if __name__ == '__main__':
    main()
