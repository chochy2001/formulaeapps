#!/usr/bin/env python3
"""Emit JSON rollback config for staging-rollback-remote.sh."""
from __future__ import annotations

import json
import sys


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit('usage: staging-rollback-config.py <app_path>')
    print(json.dumps({'app_path': sys.argv[1]}, separators=(',', ':')))


if __name__ == '__main__':
    main()
