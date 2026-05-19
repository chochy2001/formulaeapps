#!/usr/bin/env bash
# generate-bff-types.sh — Run OpenAPI codegen for Pro and Community
#
# Per specs/002-formulae-fe-be-sync/research.md § R2 and tasks.md T102.
# Reads contracts/bff.openapi.yaml (generated from BFF Zod schemas) and emits
# a self-contained Dart package into each app at
# pro/packages/formulaeapps_bff_client/ and community/packages/formulaeapps_bff_client/.
# Each app's pubspec.yaml references it via a path-dep so the generated
# `package:formulaeapps_bff_client/...` imports resolve.
#
# Generator: openapi-generator-cli v7.x, target dart-dio.
# Java required (>= 11). Bunx fetches the npm wrapper on first run and caches.
#
# Output policy: the FULL generator output (pubspec.yaml, README.md,
# analysis_options.yaml, lib/) is copied as a real Dart package. The package
# name is `formulaeapps_bff_client`; transitive deps (dio, built_value,
# built_collection, one_of, one_of_serializer) are resolved by `flutter pub
# get` in the consuming app.
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
  local dest="$ROOT/$app/packages/formulaeapps_bff_client"
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

  # Wipe destination + copy FULL package output (pubspec.yaml, lib/, README, analysis_options.yaml)
  # so the consuming app can reference it via `path: packages/formulaeapps_bff_client`.
  rm -rf "$dest"
  mkdir -p "$dest"
  if [ -d "$tmp/lib" ]; then
    # Copy pubspec.yaml, README.md, analysis_options.yaml, lib/
    for entry in pubspec.yaml README.md analysis_options.yaml lib; do
      if [ -e "$tmp/$entry" ]; then
        cp -R "$tmp/$entry" "$dest/"
      fi
    done
  else
    echo "ERROR: generator did not produce lib/ for $app (check $tmp)" >&2
    exit 1
  fi

  rm -rf "$tmp"
  trap - EXIT INT TERM

  # dart-dio uses built_value: each model emits an abstract class with
  # `part 'model.g.dart';`. Without the .g.dart companions, the consuming
  # app's `flutter analyze` reports 460+ undefined-class errors. Run
  # build_runner inside the generated package to materialize them.
  if command -v flutter >/dev/null 2>&1; then
    echo "→ Running build_runner inside $dest to emit .g.dart files"
    ( cd "$dest" && flutter pub get >/dev/null 2>&1 && dart run build_runner build >/dev/null 2>&1 ) || {
      echo "WARN: build_runner failed for $app — generated .g.dart files may be stale" >&2
    }
  else
    echo "WARN: flutter not on PATH — skipping build_runner; run it manually under $dest" >&2
  fi
}

for app in pro community; do
  generate_for_app "$app"
done

echo "✓ Generated FE types for: pro, community"
echo "  Source contract: $CONTRACT"
echo "  Outputs: pro/packages/formulaeapps_bff_client/, community/packages/formulaeapps_bff_client/"
