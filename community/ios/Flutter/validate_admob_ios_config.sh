#!/bin/sh

set -eu

# Debug and Profile use the official Google test app ID. A Release archive must
# receive a real app ID from an ignored xcconfig or CI build setting instead.
if [ "${CONFIGURATION:-}" != "Release" ]; then
  exit 0
fi

app_id="${ADMOB_IOS_APP_ID:-}"
test_app_id='ca-app-pub-3940256099942544~1458002511'

if [ -z "$app_id" ] || [ "$app_id" = "$test_app_id" ]; then
  echo 'error: Release AdMob requires a non-test ADMOB_IOS_APP_ID from Flutter/AdMob.xcconfig or CI.' >&2
  exit 1
fi

if ! printf '%s\n' "$app_id" | grep -Eq '^ca-app-pub-[0-9]{16}~[0-9]{10}$'; then
  echo 'error: ADMOB_IOS_APP_ID must match ca-app-pub-<16 digits>~<10 digits>.' >&2
  exit 1
fi
