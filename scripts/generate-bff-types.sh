#!/usr/bin/env bash
# generate-bff-types.sh — Run OpenAPI codegen for Pro and Community
#
# Per specs/002-formulae-fe-be-sync/research.md § R2 and tasks.md T102.
# Reads contracts/bff.openapi.yaml (generated from BFF Zod schemas) and emits
# Dart client + model files into pro/lib/generated/bff/ and
# community/lib/generated/bff/.
#
# Generator: openapi-generator-cli v7.x, target dart-dio.
# Java required (>= 11). Bunx fetches the npm wrapper on first run and caches.
#
# Output policy: only the generator's lib/ portion is copied into each app
# (the rest — pubspec, README, .gitignore — is discarded). pro/community
# already have their own Flutter pubspec.yaml.
#
# Verified manually via specs/002-formulae-fe-be-sync/audit/codegen-pipeline-verified.md.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$ROOT/contracts/bff.openapi.yaml"
# The npm wrapper version (2.x stream) is separate from the underlying JAR
# version (7.x stream). We pin the wrapper to a known-good release; the
# wrapper's `version-manager` separately controls the JAR.
GENERATOR_WRAPPER_VERSION="2.13.4"
GENERATOR_JAR_VERSION="7.10.0"
GENERATOR_PACKAGE="@openapitools/openapi-generator-cli@$GENERATOR_WRAPPER_VERSION"

if [ ! -f "$CONTRACT" ]; then
  echo "ERROR: $CONTRACT missing. Run 'cd bff && bun run build:openapi' first." >&2
  exit 1
fi

# Check java is available (required by openapi-generator)
if ! command -v java >/dev/null 2>&1; then
  echo "ERROR: java is required by openapi-generator-cli. Install JDK >= 11." >&2
  exit 1
fi

generate_for_app() {
  local app="$1"
  local dest="$ROOT/$app/lib/generated/bff"
  local tmp
  tmp=$(mktemp -d)
  trap "rm -rf '$tmp'" EXIT INT TERM

  echo "→ Generating $app types into $dest"

  # dart-dio: null-safe Dart 3 with dio HTTP client
  bunx "$GENERATOR_PACKAGE" generate \
    --input-spec "$CONTRACT" \
    --generator-name dart-dio \
    --output "$tmp" \
    --additional-properties=pubName=formulaeapps_bff_client,pubLibrary=formulaeapps_bff_client.api,pubAuthor=CAPDESIS,pubVersion=1.0.0,nullSafe=true,nullableFields=true \
    --global-property=apiTests=false,modelTests=false,apiDocs=false,modelDocs=false

  # Wipe destination + copy only generator's lib/ contents (skip pubspec, README, etc.)
  rm -rf "$dest"
  mkdir -p "$dest"
  if [ -d "$tmp/lib" ]; then
    cp -R "$tmp/lib/." "$dest/"
  else
    echo "ERROR: generator did not produce lib/ for $app (check $tmp)" >&2
    exit 1
  fi

  rm -rf "$tmp"
  trap - EXIT INT TERM
}

for app in pro community; do
  generate_for_app "$app"
done

echo "✓ Generated FE types for: pro, community"
echo "  Source contract: $CONTRACT"
echo "  Outputs: pro/lib/generated/bff/, community/lib/generated/bff/"
