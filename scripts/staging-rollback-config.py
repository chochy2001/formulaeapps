#!/usr/bin/env python3
"""Emit JSON rollback config for staging-rollback-remote.sh."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit('usage: staging-rollback-config.py <app_path>')
    script = Path(__file__).resolve().parent / 'staging-transport.py'
    payload = subprocess.check_output(
        [sys.executable, str(script), 'rollback', sys.argv[1]],
        text=True,
    )
    sys.stdout.write(payload)


if __name__ == '__main__':
    main()
