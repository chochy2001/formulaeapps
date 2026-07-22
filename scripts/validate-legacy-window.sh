#!/usr/bin/env bash
# Validate JWT_LEGACY_VERIFY_START/CUTOFF as a strict UTC pair with bounded window.
set -euo pipefail

start="${1:-}"
cutoff="${2:-}"
max_window_ms="${STAGING_LEGACY_MAX_MS:-7200000}"

if [[ -z "$start" && -z "$cutoff" ]]; then
  exit 0
fi

if [[ -z "$start" || -z "$cutoff" ]]; then
  echo 'legacy window: start and cutoff must both be set or both omitted' >&2
  exit 1
fi

script_dir="$(cd "$(dirname "$0")" && pwd)"
python_bin="${PYTHON3_BIN:-python3}"
if ! command -v "$python_bin" >/dev/null 2>&1; then
  python_bin="python"
fi
if ! command -v "$python_bin" >/dev/null 2>&1; then
  echo 'legacy window: Python 3 is required' >&2
  exit 127
fi

"$python_bin" - "$start" "$cutoff" "$max_window_ms" "$script_dir" <<'PY'
import sys
from pathlib import Path

sys.path.insert(0, sys.argv[4])
from staging_lib import validate_legacy_window

start_raw, cutoff_raw, max_window_raw = sys.argv[1:4]
try:
    max_window_ms = int(max_window_raw)
except ValueError as exc:
    raise SystemExit('legacy window: max window must be an integer number of milliseconds') from exc

try:
    validate_legacy_window(start_raw, cutoff_raw, max_window_ms=max_window_ms)
except ValueError as exc:
    print(f'legacy window: {exc}', file=sys.stderr)
    sys.exit(1)
PY
