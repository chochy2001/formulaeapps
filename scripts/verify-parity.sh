#!/usr/bin/env bash
# verify-parity.sh — Detect drift between Zod schemas, OpenAPI YAML, and generated Dart types
#
# Per specs/002-formulae-fe-be-sync/tasks.md T106 + Spec §FR-009 + Principle VII.
#
# Algorithm:
#   1. Re-run `bun run build:openapi` in bff/ → regenerates contracts/bff.openapi.yaml.
#   2. Re-run scripts/generate-bff-types.sh → regenerates pro/packages/formulaeapps_bff_client/ + community/packages/formulaeapps_bff_client/.
#   3. `git diff --exit-code` on the regenerated paths.
#      - Exit 0: no drift; the committed contract and generated Dart match the Zod source.
#      - Exit non-zero: drift detected; the diff is the proof. The PR author must either
#        commit the regenerated outputs OR revert the Zod schema change.
#
# Required Java >= 11 (openapi-generator) and bun >= 1.3. Both checked indirectly.
#
# Exit codes:
#   0  — parity OK
#   1  — drift detected (printed diff above)
#   2  — environment / setup error (printed reason above)

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cd "$ROOT"

# 1. Refresh contract from current Zod schemas
if ! ( cd bff && bun run build:openapi ); then
  echo "ERROR: 'bun run build:openapi' failed in bff/" >&2
  exit 2
fi

# 2. Regenerate FE types from refreshed contract
if ! bash "$ROOT/scripts/generate-bff-types.sh"; then
  echo "ERROR: 'scripts/generate-bff-types.sh' failed" >&2
  exit 2
fi

# 3. Diff against tracked state
PATHS=(
  "contracts"
  "pro/packages/formulaeapps_bff_client"
  "community/packages/formulaeapps_bff_client"
)

# Surface any drift (both staged and unstaged)
if git diff --exit-code -- "${PATHS[@]}" >/dev/null 2>&1; then
  echo ""
  echo "✓ parity OK — Zod schemas, contracts/bff.openapi.yaml, and generated Dart match"
  exit 0
fi

echo ""
echo "✗ parity FAIL — drift detected. Either commit the regenerated outputs"
echo "  or revert the change that caused drift. Drift summary:"
echo ""
git diff --stat -- "${PATHS[@]}" >&2
exit 1
