#!/usr/bin/env bash
# Reconcile the pinned, non-language tools used by JWT preflight.
#
# Product CI calls this script with --verify-only and never downloads. The
# trusted maintenance lane calls it without that flag to populate a persistent
# per-runner bin directory without sudo.
#
# Usage: bash scripts/ci-ensure-jwt-tools.sh [--verify-only]
set -euo pipefail

mode="${1:-install}"
case "$mode" in
  install | --verify-only) ;;
  *) echo "::error::Unknown mode: $mode"; exit 2 ;;
esac

readonly RIPGREP_VERSION="14.1.1"
readonly GITLEAKS_VERSION="8.30.1"
readonly SHELLCHECK_VERSION="0.10.0"
readonly RIPGREP_SHA256="4cf9f2741e6c465ffdb7c26f38056a59e2a2544b51f7cc128ef28337eeae4d8e"
readonly GITLEAKS_SHA256="551f6fc83ea457d62a0d98237cbad105af8d557003051f41f3e7ca7b3f2470eb"
readonly SHELLCHECK_SHA256="6c881ab0698e4e6ea235245f22832860544f17ba386442fe7e9d629f8cbedf87"

bin_dir="${CI_PRELOAD_BIN_DIR:-${HOME}/.local/bin}"
export PATH="${bin_dir}:${PATH}"

publish_path() {
  if [ -n "${GITHUB_PATH:-}" ]; then
    echo "$bin_dir" >>"$GITHUB_PATH"
  fi
}

tool_version() {
  case "$1" in
    rg) rg --version 2>/dev/null | sed -n '1s/^ripgrep \([0-9][0-9.]*\).*/\1/p' ;;
    gitleaks) gitleaks version 2>/dev/null | sed -n 's/.*\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\).*/\1/p' | head -n 1 ;;
    shellcheck) shellcheck --version 2>/dev/null | sed -n 's/^version: //p' ;;
  esac
}

expected_version() {
  case "$1" in
    rg) echo "$RIPGREP_VERSION" ;;
    gitleaks) echo "$GITLEAKS_VERSION" ;;
    shellcheck) echo "$SHELLCHECK_VERSION" ;;
  esac
}

tools_are_exact() {
  local tool actual expected
  for tool in rg gitleaks shellcheck; do
    expected="$(expected_version "$tool")"
    actual="$(tool_version "$tool" || true)"
    if [ "$actual" != "$expected" ]; then
      echo "CI tool drift: $tool=${actual:-missing}, expected=$expected" >&2
      return 1
    fi
    echo "Using $tool $actual ($(command -v "$tool"))"
  done
}

if tools_are_exact; then
  publish_path
  exit 0
fi

if [ "$mode" = "--verify-only" ]; then
  echo "::error::JWT tools are not preloaded. Run CI mode preload-wsl-bun before product CI." >&2
  exit 1
fi

if [ "$(uname -s)" != "Linux" ] || [ "$(uname -m)" != "x86_64" ]; then
  echo "::error::JWT tool preload currently supports Linux x86_64 only" >&2
  exit 1
fi
for command_name in curl python3; do
  command -v "$command_name" >/dev/null || {
    echo "::error::$command_name is required to preload JWT tools" >&2
    exit 1
  }
done

tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "${tmp_dir:?}"' EXIT INT TERM

download_and_install() {
  local tool="$1"
  local url="$2"
  local expected_sha="$3"
  local member_suffix="$4"
  local archive="$tmp_dir/${tool}.archive"

  curl -fsSL "$url" -o "$archive"
  python3 - "$archive" "$expected_sha" "$member_suffix" "$bin_dir/$tool" <<'PY'
import hashlib
import os
from pathlib import Path
import sys
import tarfile

archive = Path(sys.argv[1])
expected = sys.argv[2]
member_suffix = sys.argv[3]
destination = Path(sys.argv[4])

actual = hashlib.sha256(archive.read_bytes()).hexdigest()
if actual != expected:
    raise SystemExit(f"checksum mismatch for {archive.name}: {actual} != {expected}")

with tarfile.open(archive, mode="r:*") as bundle:
    matches = [
        item for item in bundle.getmembers()
        if item.isfile() and (item.name == member_suffix or item.name.endswith("/" + member_suffix))
    ]
    if len(matches) != 1:
        raise SystemExit(f"expected one {member_suffix} in {archive.name}, found {len(matches)}")
    source = bundle.extractfile(matches[0])
    if source is None:
        raise SystemExit(f"unable to extract {matches[0].name}")
    payload = source.read()

destination.parent.mkdir(parents=True, exist_ok=True)
temporary = destination.with_suffix(".tmp")
temporary.write_bytes(payload)
os.chmod(temporary, 0o755)
temporary.replace(destination)
PY
}

download_and_install \
  rg \
  "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz" \
  "$RIPGREP_SHA256" \
  rg
download_and_install \
  gitleaks \
  "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz" \
  "$GITLEAKS_SHA256" \
  gitleaks
download_and_install \
  shellcheck \
  "https://github.com/koalaman/shellcheck/releases/download/v${SHELLCHECK_VERSION}/shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.xz" \
  "$SHELLCHECK_SHA256" \
  shellcheck

tools_are_exact
publish_path
echo "Installed checksum-locked JWT tools in $bin_dir"
