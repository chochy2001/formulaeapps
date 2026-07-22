#!/usr/bin/env bash
# Serialize the first Objective-C SDK/header probe before Dart native-assets
# launches several clang processes concurrently on a persistent macOS runner.
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  exit 0
fi

package_config="${1:-.dart_tool/package_config.json}"
if [[ ! -f "$package_config" ]]; then
  echo "Missing Dart package config: $package_config" >&2
  exit 1
fi

python_bin="${PYTHON3_BIN:-python3}"
if ! command -v "$python_bin" >/dev/null 2>&1; then
  python_bin="python"
fi
if ! command -v "$python_bin" >/dev/null 2>&1; then
  echo "Python 3 is required to resolve the objective_c package" >&2
  exit 127
fi

objective_c_root="$("$python_bin" - "$package_config" <<'PY'
import json
import sys
from pathlib import Path
from urllib.parse import unquote, urljoin, urlparse

config_path = Path(sys.argv[1]).resolve()
payload = json.loads(config_path.read_text(encoding="utf-8"))
package = next(
    (item for item in payload.get("packages", []) if item.get("name") == "objective_c"),
    None,
)
if package is None:
    raise SystemExit("objective_c is missing from the Dart package config")

base_uri = config_path.parent.as_uri().rstrip("/") + "/"
root_uri = urlparse(urljoin(base_uri, str(package["rootUri"])))
if root_uri.scheme != "file":
    raise SystemExit("objective_c rootUri must resolve to a local file path")
print(Path(unquote(root_uri.path)).resolve())
PY
)"

sdk="$(xcrun --sdk macosx --show-sdk-path)"
carbon_header="$sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/CarbonCore.framework/Headers/UnicodeUtilities.h"
generated_source="$objective_c_root/src/objective_c_bindings_generated.m"
test -f "$carbon_header"
test -f "$generated_source"

case "$(uname -m)" in
  arm64) target="arm64-apple-darwin" ;;
  x86_64) target="x86_64-apple-darwin" ;;
  *)
    echo "Unsupported macOS architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

xcrun clang \
  -isysroot "$sdk" \
  -target "$target" \
  -mmacos-version-min=13 \
  -x objective-c \
  -fobjc-arc \
  -fsyntax-only \
  -I "$objective_c_root/src" \
  "$generated_source"
echo "Prewarmed objective_c headers with $(xcrun clang --version | head -n 1)"
