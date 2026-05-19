#!/usr/bin/env bash
# route-coverage.sh — thin wrapper invoking the TypeScript implementation.
#
# Real logic lives at bff/scripts/route-coverage.ts (uses the `yaml` package
# already installed in bff/node_modules). macOS ships bash 3.2 which lacks
# associative arrays, so the parser is in TS/Bun.
#
# Per specs/002-formulae-fe-be-sync/tasks.md T113 + data-model.md § E12 + Principle VI.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Verify bff/node_modules is populated (route-coverage.ts imports `yaml`)
if [ ! -d "$ROOT/bff/node_modules" ]; then
  echo "ERROR: bff/node_modules missing. Run 'cd bff && bun install' first." >&2
  exit 2
fi

cd "$ROOT/bff"
exec bun run scripts/route-coverage.ts "$@"
