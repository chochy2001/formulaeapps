#!/usr/bin/env bash
# Validate JWT_LEGACY_VERIFY_START/CUTOFF as a strict UTC pair with window (0, 2h].
set -euo pipefail

start="${1:-}"
cutoff="${2:-}"

if [[ -z "$start" && -z "$cutoff" ]]; then
  exit 0
fi

if [[ -z "$start" || -z "$cutoff" ]]; then
  echo 'legacy window: start and cutoff must both be set or both omitted' >&2
  exit 1
fi

python3 - "$start" "$cutoff" <<'PY'
import sys
from datetime import datetime, timezone

start_raw, cutoff_raw = sys.argv[1:3]
utc = timezone.utc

def parse_strict(value: str) -> datetime:
    if not value.endswith('Z'):
        raise ValueError('timestamps must use UTC Z suffix')
    body = value[:-1]
    if '.' in body:
        base, frac = body.split('.', 1)
        if not frac.isdigit():
            raise ValueError('fractional seconds must be numeric')
        dt = datetime.strptime(base, '%Y-%m-%dT%H:%M:%S').replace(tzinfo=utc)
        micros = int(frac.ljust(6, '0')[:6])
        return dt.replace(microsecond=micros)
    return datetime.strptime(body, '%Y-%m-%dT%H:%M:%S').replace(tzinfo=utc)

try:
    start = parse_strict(start_raw)
    cutoff = parse_strict(cutoff_raw)
except ValueError as exc:
    print(f'legacy window: invalid UTC timestamp: {exc}', file=sys.stderr)
    sys.exit(1)

delta_ms = int((cutoff - start).total_seconds() * 1000)
if delta_ms <= 0 or delta_ms > 7_200_000:
    print('legacy window: cutoff must be strictly after start and within 2 hours', file=sys.stderr)
    sys.exit(1)
PY
