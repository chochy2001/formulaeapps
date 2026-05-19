#!/usr/bin/env bash
# infra-validate.sh — Multi-app infrastructure verification (Principle IX gate).
#
# Thin wrapper invoking the TypeScript implementation at bff/scripts/infra-validate.ts
# (uses Bun's built-in fetch + workspace yaml package). macOS bash 3.2 lacks
# associative arrays needed for the router-collision map, so the parser is TS.
#
# Per specs/002-formulae-fe-be-sync/tasks.md T120 + data-model.md § E13.
#
# Usage:
#   scripts/infra-validate.sh            # production mode (DNS + HTTPS + TLS + CORS)
#   scripts/infra-validate.sh --local    # local mode (compose lint + Traefik scan + local CORS)
#
# Exit: 0 PASS, 1 FAIL, 2 setup error.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ ! -d "$ROOT/bff/node_modules" ]; then
  echo "ERROR: bff/node_modules missing. Run 'cd bff && bun install' first." >&2
  exit 2
fi

cd "$ROOT/bff"
exec bun run scripts/infra-validate.ts "$@"
