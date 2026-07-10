#!/usr/bin/env python3
"""Emit JSON deploy config for staging-deploy-remote.sh (no secret values)."""
from __future__ import annotations

import json
import sys


def main() -> None:
    if len(sys.argv) != 5:
        raise SystemExit('usage: staging-deploy-config.py <candidate_sha> <app_path> <legacy_start> <legacy_cutoff>')
    print(
        json.dumps(
            {
                'candidate_sha': sys.argv[1],
                'app_path': sys.argv[2],
                'legacy_verify_start': sys.argv[3],
                'legacy_verify_cutoff': sys.argv[4],
            },
            separators=(',', ':'),
        )
    )


if __name__ == '__main__':
    main()
