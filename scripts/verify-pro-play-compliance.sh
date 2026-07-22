#!/usr/bin/env bash
# verify-pro-play-compliance.sh — Fail closed if Formulae Pro Android store gates drift.
#
# Checks (no network, no Flutter build):
#   1. pro/android/app/build.gradle compileSdkVersion + targetSdkVersion == 36
#   2. pubspec / lock pin in_app_purchase_android to ≥0.5 (Billing Library 8+)
#   3. Gradle resolution floor for com.android.billingclient is present
#   4. No windowOptOutEdgeToEdgeEnforcement opt-out in Android themes
#
# Exit codes:
#   0 — compliance OK
#   1 — compliance regression
#   2 — environment / missing files

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
GRADLE="$ROOT/pro/android/app/build.gradle"
PUBSPEC="$ROOT/pro/pubspec.yaml"
LOCK="$ROOT/pro/pubspec.lock"
STYLES_DIR="$ROOT/pro/android/app/src/main/res"
errors=0

fail() {
  echo "ERROR: $*" >&2
  errors=$((errors + 1))
}

[[ -f "$GRADLE" ]] || { echo "ERROR: missing $GRADLE" >&2; exit 2; }
[[ -f "$PUBSPEC" ]] || { echo "ERROR: missing $PUBSPEC" >&2; exit 2; }
[[ -f "$LOCK" ]] || { echo "ERROR: missing $LOCK" >&2; exit 2; }

compile_sdk="$(rg -oN 'compileSdkVersion\s+(\d+)' -r '$1' "$GRADLE" | head -1 || true)"
target_sdk="$(rg -oN 'targetSdkVersion\s+(\d+)' -r '$1' "$GRADLE" | head -1 || true)"

if [[ "$compile_sdk" != "36" ]]; then
  fail "compileSdkVersion must be 36 (found: ${compile_sdk:-missing})"
fi
if [[ "$target_sdk" != "36" ]]; then
  fail "targetSdkVersion must be 36 (found: ${target_sdk:-missing})"
fi

if ! rg -q 'in_app_purchase_android:\s*\^0\.5' "$PUBSPEC"; then
  fail "pro/pubspec.yaml must pin in_app_purchase_android: ^0.5.0 (Billing Library 8+)"
fi

if ! rg -q 'in_app_purchase:\s*\^3\.3' "$PUBSPEC"; then
  fail "pro/pubspec.yaml must pin in_app_purchase: ^3.3.0 or newer"
fi

android_lock_ver="$(
  python3 - "$LOCK" <<'PY'
import re, sys
text = open(sys.argv[1], encoding="utf-8").read()
m = re.search(
    r'  in_app_purchase_android:\n(?:    .*\n)*?    version: "([^"]+)"',
    text,
)
print(m.group(1) if m else "")
PY
)"

if [[ -z "$android_lock_ver" ]]; then
  fail "pro/pubspec.lock missing in_app_purchase_android version"
else
  lock_ok="$(
    python3 - <<PY
ver = "${android_lock_ver}".split("+", 1)[0]
parts = [int(p) for p in ver.split(".") if p.isdigit()]
# Require ≥ 0.5.0 (Billing Library 8 line).
ok = len(parts) >= 2 and (parts[0], parts[1]) >= (0, 5)
print("yes" if ok else "no")
PY
  )"
  if [[ "$lock_ok" != "yes" ]]; then
    fail "in_app_purchase_android lock version must be ≥0.5.0 (found: $android_lock_ver)"
  fi
fi

if ! rg -q 'com\.android\.billingclient' "$GRADLE"; then
  fail "android/app/build.gradle must keep a Billing Library 8+ resolution floor"
fi

if rg -q 'windowOptOutEdgeToEdgeEnforcement' "$STYLES_DIR" --glob '*.xml'; then
  fail "Android themes must not opt out of edge-to-edge (ignored/disabled on API 36)"
fi

if [[ "$errors" -gt 0 ]]; then
  echo "verify-pro-play-compliance: FAILED ($errors issue(s))" >&2
  exit 1
fi

echo "verify-pro-play-compliance: OK"
echo "  compileSdk=$compile_sdk targetSdk=$target_sdk"
echo "  in_app_purchase_android=$android_lock_ver (Billing Library 8+ via plugin 0.5+)"
exit 0
