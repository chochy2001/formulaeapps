#!/usr/bin/env bash
# Ensure Bun is on PATH for self-hosted product CI.
#
# Prefer a warm host install. If missing/wrong, download the official zip and
# extract with python3 (no `unzip` binary — WSL runners may lack it).
#
# Usage: bash scripts/ci-ensure-bun.sh [version] [--verify-only]
set -euo pipefail

expected_version="${1:-1.3.14}"
mode="${2:-install}"
case "$mode" in
  install | --verify-only) ;;
  *) echo "::error::Unknown mode: $mode"; exit 2 ;;
esac
if [[ "$(uname -s)" == MINGW* || "$(uname -s)" == MSYS* || "$(uname -s)" == CYGWIN* ]]; then
  if [[ -z "${BUN_INSTALL:-}" ]]; then
    command -v cygpath >/dev/null || {
      echo "::error::cygpath is required to activate preloaded Bun on Windows"
      exit 1
    }
    BUN_INSTALL="$(cygpath -u "${USERPROFILE:?USERPROFILE is required on Windows}")/.bun"
  fi
  bun_bin="${BUN_INSTALL}/bin/bun.exe"
else
  BUN_INSTALL="${BUN_INSTALL:-${HOME}/.bun}"
  bun_bin="${BUN_INSTALL}/bin/bun"
fi
export BUN_INSTALL
export PATH="${BUN_INSTALL}/bin:${PATH}"

if [ -x "$bun_bin" ] && [ "$("$bun_bin" --version)" = "$expected_version" ]; then
  echo "Using Bun $expected_version at $bun_bin"
  if [ -n "${GITHUB_PATH:-}" ]; then
    echo "${BUN_INSTALL}/bin" >>"$GITHUB_PATH"
  fi
  exit 0
fi

if command -v bun >/dev/null 2>&1 && [ "$(bun --version)" = "$expected_version" ]; then
  echo "Using PATH Bun $expected_version ($(command -v bun))"
  exit 0
fi

if [ "$mode" = "--verify-only" ]; then
  echo "::error::Bun $expected_version is not preloaded. Run the preload-jwt-pool maintenance lane before product CI."
  exit 1
fi

case "$(uname -s)/$(uname -m)" in
  Linux/x86_64 | Linux/amd64)
    platform=linux-x64
    release_sha256=951ee2aee855f08595aeec6225226a298d3fea83a3dcd6465c09cbccdf7e848f
    ;;
  Linux/aarch64 | Linux/arm64)
    platform=linux-aarch64
    release_sha256=a27ffb63a8310375836e0d6f668ae17fa8d8d18b88c37c821c65331973a19a3b
    ;;
  Darwin/arm64)
    platform=darwin-aarch64
    release_sha256=d8b96221828ad6f97ac7ac0ab7e95872341af763001e8803e8267652c2652620
    ;;
  *)
    echo "::error::Unsupported platform $(uname -s)/$(uname -m) for Bun preload"
    exit 1
    ;;
esac

for command_name in curl python3 install; do
  command -v "$command_name" >/dev/null || {
    echo "::error::$command_name is required to install Bun"
    exit 1
  }
done

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
archive="$tmp_dir/bun-${platform}.zip"
curl -fsSL \
  "https://github.com/oven-sh/bun/releases/download/bun-v${expected_version}/bun-${platform}.zip" \
  -o "$archive"

# Refuse unknown versions instead of downloading an unverified archive in a
# maintenance job. Digests come from the upstream GitHub release API.
if [ "$expected_version" != "1.3.14" ]; then
  echo "::error::No checksum lock recorded for Bun $expected_version"
  exit 1
fi
python3 - "$archive" "$release_sha256" <<'PY'
import hashlib
from pathlib import Path
import sys

archive = Path(sys.argv[1])
expected = sys.argv[2]
actual = hashlib.sha256(archive.read_bytes()).hexdigest()
if actual != expected:
    raise SystemExit(f"checksum mismatch for {archive.name}: {actual} != {expected}")
PY

python3 -m zipfile -e "$archive" "$tmp_dir/extracted"
# Zip members are often non-executable until chmod; test -f not -x.
source_bin="$(find "$tmp_dir/extracted" -type f -name bun | head -n 1)"
[ -n "$source_bin" ] && [ -f "$source_bin" ] || {
  echo "::error::Bun binary not found in archive"
  find "$tmp_dir/extracted" -print >&2 || true
  exit 1
}
chmod +x "$source_bin"
mkdir -p "$(dirname "$bun_bin")"
install -m 0755 "$source_bin" "$bun_bin"
actual="$("$bun_bin" --version)"
[ "$actual" = "$expected_version" ] || {
  echo "::error::Bun version drift after install: $actual (want $expected_version)"
  exit 1
}
if [ -n "${GITHUB_PATH:-}" ]; then
  echo "${BUN_INSTALL}/bin" >>"$GITHUB_PATH"
fi
echo "Installed Bun $actual at $bun_bin"
