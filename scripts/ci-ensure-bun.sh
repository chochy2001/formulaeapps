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
export BUN_INSTALL="${BUN_INSTALL:-${HOME}/.bun}"
bun_bin="${BUN_INSTALL}/bin/bun"
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

case "$(uname -m)" in
  x86_64 | amd64) arch=x64 ;;
  aarch64 | arm64) arch=aarch64 ;;
  *)
    echo "::error::Unsupported arch $(uname -m) for Bun preload"
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
archive="$tmp_dir/bun-linux-${arch}.zip"
curl -fsSL \
  "https://github.com/oven-sh/bun/releases/download/bun-v${expected_version}/bun-linux-${arch}.zip" \
  -o "$archive"

# Optional checksum lock for the known x64 release used by Formulae CI.
if [ "$expected_version" = "1.3.14" ] && [ "$arch" = "x64" ] && command -v sha256sum >/dev/null; then
  echo '951ee2aee855f08595aeec6225226a298d3fea83a3dcd6465c09cbccdf7e848f  '"$archive" \
    | sha256sum -c -
fi

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
