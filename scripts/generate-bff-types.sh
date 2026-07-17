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
  trap 'rm -rf -- "${tmp:?}"' EXIT INT TERM

  echo "→ Generating $app types into $dest"

  # dart-dio: null-safe Dart 3 with dio HTTP client
  bunx "$GENERATOR_PACKAGE" generate \
    --input-spec "$CONTRACT" \
    --generator-name dart-dio \
    --output "$tmp" \
    --additional-properties=pubName=formulaeapps_bff_client,pubLibrary=formulaeapps_bff_client.api,pubAuthor=CAPDESIS,pubVersion=1.0.0,nullSafe=true,nullableFields=true \
    --global-property=apiTests=false,modelTests=false,apiDocs=false,modelDocs=false

  # Refresh only the generator-owned outputs (pubspec.yaml, README.md,
  # analysis_options.yaml, lib/) so the consuming app can reference the package
  # via `path: packages/formulaeapps_bff_client`.
  #
  # Hand-authored files committed inside the package are NOT generator output
  # and MUST survive regeneration. In particular test/ holds the contract
  # serialization tests that `dart test` runs in CI. A blanket `rm -rf "$dest"`
  # used to delete them, so verify-parity.sh reported them as deleted drift and
  # failed the parity gate. Remove each generated entry individually and leave
  # everything else (test/, and any future hand-authored files) untouched.
  if [ ! -d "$tmp/lib" ]; then
    echo "ERROR: generator did not produce lib/ for $app (check $tmp)" >&2
    exit 1
  fi
  mkdir -p "$dest"
  for entry in pubspec.yaml README.md analysis_options.yaml lib; do
    # Drop any stale copy first so a generated entry that disappears upstream
    # does not linger, then copy the freshly generated one.
    rm -rf "${dest:?}/$entry"
    if [ -e "$tmp/$entry" ]; then
      cp -R "$tmp/$entry" "$dest/"
    fi
  done

  # `apiDocs=false,modelDocs=false` intentionally keeps the generated package
  # small, but the stock dart-dio README still links to doc/*.md files that do
  # not exist. Replace those sections with the canonical OpenAPI contract so
  # consumers never receive dead links. Keep this transformation here rather
  # than hand-editing generated READMEs, because every parity run regenerates
  # them from scratch.
  if [ -f "$dest/README.md" ]; then
    perl -0pi -e 's{## Documentation for API Endpoints\n.*?## Documentation For Models\n.*?## Documentation For Authorization}{## API contract\n\nThe canonical API surface is generated in\n[`contracts/bff.openapi.yaml`](../../../contracts/bff.openapi.yaml). API and model\nMarkdown files are intentionally not generated with this package; use the\ncontract and generated Dart source as references.\n\n## Documentation For Authorization}s' "$dest/README.md"

    # The stock example leaves an invalid Dart assignment. Auth requests need a
    # real per-install identifier and HMAC proof, so point consumers to the
    # owning app service instead of publishing a non-compilable placeholder.
    perl -0pi -e 's{## Getting Started\n.*?## API contract}{## Getting started\n\nImport this package from the owning app. Authentication requests require a real\nper-install client ID and HMAC client proof; use the app `AuthService` rather\nthan hardcoding example values. The canonical contract and generated APIs below\nare the reference for integrations.\n\n## API contract}s' "$dest/README.md"

    if grep -Fq '](doc/' "$dest/README.md" || grep -Fq 'authTokenRequest = ;' "$dest/README.md"; then
      echo "ERROR: generated README for $app still contains disabled doc links or an invalid example." >&2
      exit 1
    fi
  fi

  rm -rf -- "${tmp:?}"
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

    # dart-dio 7.14.0 adds response-schema imports (for example
    # ErrorEnvelope) even though its generated request methods surface
    # non-2xx responses as DioException and never deserialize those schemas.
    # Its built_value API template also imports JsonObject unconditionally.
    # Normalize the generated API surface through Dart's analyzer-backed fix
    # so both clients remain warning-free after every regeneration without
    # weakening the OpenAPI error contract or hand-editing generated files.
    echo "→ Removing unused imports from generated $app API files"
    ( cd "$dest" && dart fix --apply --code=unused_import lib/src/api >/dev/null )
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
