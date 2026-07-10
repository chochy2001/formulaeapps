#!/usr/bin/env python3
"""Remote staging rollback entrypoint (stdin JSON)."""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from staging_lib import (  # noqa: E402
    DEFAULT_STAGING_ROOT,
    resolve_allowed_root,
    rollback_to_prior,
    verify_host_role,
)


def main() -> int:
    config = json.loads(sys.stdin.read())
    if config.get('action') != 'rollback':
        print('expected rollback action', file=sys.stderr)
        return 2
    root = resolve_allowed_root(config['app_path'], DEFAULT_STAGING_ROOT)
    verify_host_role()
    rollback_to_prior(root)
    print('rollback: staging BFF restored')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
