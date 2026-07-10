#!/usr/bin/env bash
# Rsync candidate tree into an immutable release directory (never --delete on active root).
set -euo pipefail

payload="$(python3 "$(dirname "$0")/staging-transport.py" sync "$1" "$2")"
temp_path="$(python3 -c 'import json,sys; print(json.loads(sys.argv[1])["temp_sync_path"])' "$payload")"
ssh_target="$3"
shift 3

rsync -az \
  --exclude='.git/' \
  --exclude='.env' \
  --exclude='.env.*' \
  --exclude='.staging-state/' \
  --exclude='current' \
  --exclude='releases/' \
  --exclude='pro/' \
  --exclude='community/' \
  --exclude='landing/' \
  -e "$*" \
  ./ "${ssh_target}:${temp_path}/"
