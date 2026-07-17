#!/usr/bin/env python3
"""Remote staging deploy entrypoint (stdin JSON, no argv secrets)."""
from __future__ import annotations

import json
import os
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from staging_lib import (  # noqa: E402
    DEFAULT_STAGING_ROOT,
    deploy_candidate,
    resolve_allowed_root,
    verify_host_role,
)


def main() -> int:
    config = json.loads(sys.stdin.read())
    if config.get('action') != 'deploy':
        print('expected deploy action', file=sys.stderr)
        return 2
    root = resolve_allowed_root(config['app_path'], DEFAULT_STAGING_ROOT)
    verify_host_role()
    os.chdir(root)
    deploy_candidate(
        root,
        config['candidate_sha'],
        config['legacy_verify_start'],
        config['legacy_verify_cutoff'],
        bootstrap=bool(config.get('bootstrap')),
        readiness_base_url=config.get('readiness_base_url') or None,
        control_sha=config.get('control_sha'),
    )
    print(f"DEPLOYED_SHA={config['candidate_sha']}")
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
