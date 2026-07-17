#!/usr/bin/env python3
"""Remote staging sync guard/finalize entrypoint (stdin JSON, no argv secrets)."""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from staging_lib import (  # noqa: E402
    DEFAULT_STAGING_ROOT,
    finalize_synced_release,
    resolve_allowed_root,
    validate_sync_guards,
)


def main() -> int:
    config = json.loads(sys.stdin.read())
    action = config.get('action')
    if action == 'guard':
        root = resolve_allowed_root(config['app_path'], DEFAULT_STAGING_ROOT)
        payload = validate_sync_guards(
            root,
            config['candidate_sha'],
            expected_digest=config.get('expected_digest'),
        )
        print(json.dumps(payload, separators=(',', ':')))
        return 0
    if action == 'finalize':
        root = resolve_allowed_root(config['app_path'], DEFAULT_STAGING_ROOT)
        finalize_synced_release(root, config['candidate_sha'], config['expected_digest'])
        print(f"FINALIZED_SHA={config['candidate_sha']}")
        return 0
    print(f'expected guard or finalize action, got {action!r}', file=sys.stderr)
    return 2


if __name__ == '__main__':
    raise SystemExit(main())
