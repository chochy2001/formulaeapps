#!/usr/bin/env python3
"""Redacted staging .env presence and format checks. Never prints secret values."""
from __future__ import annotations

import os
import re
import sys
from pathlib import Path


def load_env(path: Path) -> dict[str, str]:
    env: dict[str, str] = {}
    for line in path.read_text().splitlines():
        if not line.strip() or line.strip().startswith('#') or '=' not in line:
            continue
        key, value = line.split('=', 1)
        env[key.strip()] = value.strip()
    return env


def main() -> int:
    env_path = Path(os.environ.get('STAGING_ENV_FILE', '.env'))
    if not env_path.is_file():
        print('MISSING:STAGING_ENV_FILE')
        return 1

    required = [
        'BFF_ENV',
        'JWT_SIGNING_SECRET',
        'JWT_SHARED_SECRET',
        'JWT_LEGACY_VERIFY_ENABLED',
        'JWT_LEGACY_VERIFY_START',
        'JWT_LEGACY_VERIFY_CUTOFF',
        'OPENROUTER_API_KEY',
    ]
    env = load_env(env_path)
    for name in required:
        if name not in env or env[name] == '':
            print(f'MISSING:{name}')
            return 1

    if env['BFF_ENV'] != 'staging':
        print('INVALID:BFF_ENV')
        return 1

    sign = env['JWT_SIGNING_SECRET']
    shared = env['JWT_SHARED_SECRET']
    if not re.fullmatch(r'[0-9a-fA-F]{64}', sign):
        print('INVALID:JWT_SIGNING_SECRET_FORMAT')
        return 1
    if sign == shared:
        print('INVALID:JWT_SIGNING_SECRET_EQUALS_SHARED')
        return 1

    if env['JWT_LEGACY_VERIFY_ENABLED'].lower() == 'true':
        start = env['JWT_LEGACY_VERIFY_START']
        cutoff = env['JWT_LEGACY_VERIFY_CUTOFF']
        if not start or not cutoff:
            print('INVALID:LEGACY_WINDOW')
            return 1

    print('PRESENT:JWT_SIGNING_SECRET')
    print('FORMAT_OK:JWT_SIGNING_SECRET')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
