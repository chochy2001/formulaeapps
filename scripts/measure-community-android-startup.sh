#!/usr/bin/env bash

# Measure the time until Community's language-neutral home ScrollView appears
# on an already-connected Android device/emulator. This deliberately measures
# first interactive UI instead of `am start -W`, whose "fully drawn" callback
# can include third-party ad/image work after the menu is usable.

set -euo pipefail

SDK_ROOT="${ANDROID_SDK_ROOT:-$HOME/Library/Android/sdk}"
ADB="${ADB:-$SDK_ROOT/platform-tools/adb}"
SERIAL="${ANDROID_SERIAL:-emulator-5554}"
RUNS="${RUNS:-5}"
PACKAGE="${PACKAGE:-capdesis.formulae}"
ACTIVITY="${ACTIVITY:-$PACKAGE/.MainActivity}"
POLL_SECONDS="${POLL_SECONDS:-15}"

if [ ! -x "$ADB" ]; then
  echo "ERROR: adb not found at $ADB. Set ADB or ANDROID_SDK_ROOT." >&2
  exit 2
fi

if ! "$ADB" -s "$SERIAL" get-state 2>/dev/null | grep -qx 'device'; then
  echo "ERROR: Android device '$SERIAL' is not ready." >&2
  exit 2
fi

if ! [[ "$RUNS" =~ ^[1-9][0-9]*$ ]]; then
  echo "ERROR: RUNS must be a positive integer." >&2
  exit 2
fi

now_millis() {
  perl -MTime::HiRes=time -e 'printf "%.0f\n", time() * 1000'
}

is_home_interactive() {
  if ! "$ADB" -s "$SERIAL" shell uiautomator dump \
    /sdcard/formulae-startup.xml >/dev/null 2>&1; then
    return 1
  fi
  "$ADB" -s "$SERIAL" shell \
    "grep -q 'android.widget.ScrollView' /sdcard/formulae-startup.xml"
}

ready_times=()
failed_runs=0

for run in $(seq 1 "$RUNS"); do
  "$ADB" -s "$SERIAL" shell am force-stop "$PACKAGE"
  sleep 0.2

  started_at="$(now_millis)"
  "$ADB" -s "$SERIAL" shell am start -n "$ACTIVITY" >/dev/null

  ready_at=''
  deadline=$((started_at + POLL_SECONDS * 1000))
  while [ "$(now_millis)" -lt "$deadline" ]; do
    if is_home_interactive; then
      ready_at="$(now_millis)"
      break
    fi
    sleep 0.25
  done

  if [ -z "$ready_at" ]; then
    failed_runs=$((failed_runs + 1))
    printf 'run=%s first_interactive_ms=TIMEOUT\n' "$run"
    continue
  fi

  elapsed=$((ready_at - started_at))
  ready_times+=("$elapsed")
  printf 'run=%s first_interactive_ms=%s\n' "$run" "$elapsed"
done

if [ "${#ready_times[@]}" -eq 0 ]; then
  echo 'ERROR: Community home did not become interactive in any run.' >&2
  exit 1
fi

sorted=($(printf '%s\n' "${ready_times[@]}" | sort -n))
count="${#sorted[@]}"
median_index=$(((count - 1) / 2))
p95_index=$(((95 * count + 99) / 100 - 1))
if [ "$p95_index" -ge "$count" ]; then
  p95_index=$((count - 1))
fi

printf 'summary runs=%s successful=%s failed=%s median_ms=%s p95_ms=%s device=%s\n' \
  "$RUNS" "$count" "$failed_runs" "${sorted[$median_index]}" \
  "${sorted[$p95_index]}" "$SERIAL"
