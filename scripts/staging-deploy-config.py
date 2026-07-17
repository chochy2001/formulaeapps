#!/usr/bin/env python3
"""Emit JSON deploy config for staging-deploy-remote.sh (no secret values)."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 5:
        raise SystemExit('usage: staging-deploy-config.py <candidate_sha> <app_path> <legacy_start> <legacy_cutoff>')
    script = Path(__file__).resolve().parent / 'staging-transport.py'
    payload = subprocess.check_output(
        [sys.executable, str(script), 'deploy', sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]],
        text=True,
    )
    sys.stdout.write(payload)


if __name__ == '__main__':
    main()
