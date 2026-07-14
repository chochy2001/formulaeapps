#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

JWT_SHARED_SECRET="${JWT_SHARED_SECRET:-}"
FORMULAE_BFF_BASE_URL="${FORMULAE_BFF_BASE_URL:-https://api.formulaeapps.com}"
FORMULAE_BFF_CHAT_URL="${FORMULAE_BFF_CHAT_URL:-https://api.formulaeapps.com/openai/chat}"

if [[ -z "$JWT_SHARED_SECRET" || -z "$FORMULAE_BFF_BASE_URL" || -z "$FORMULAE_BFF_CHAT_URL" ]]; then
  echo "ERROR: JWT_SHARED_SECRET, FORMULAE_BFF_BASE_URL, and FORMULAE_BFF_CHAT_URL are required to build FormulaePro Web." >&2
  exit 1
fi

flutter clean
flutter pub get
flutter build web --release -t lib/main_pro.dart \
  --dart-define=FLAVOR=pro \
  --dart-define=JWT_SHARED_SECRET="$JWT_SHARED_SECRET" \
  --dart-define=FORMULAE_BFF_BASE_URL="$FORMULAE_BFF_BASE_URL" \
  --dart-define=FORMULAE_BFF_CHAT_URL="$FORMULAE_BFF_CHAT_URL" \
  "$@"

if grep -R -E "google_mobile_ads|MobileAds|AdMobConfig|ca-app-pub-" build/web >/dev/null; then
  echo "ERROR: AdMob symbols found in Pro web build." >&2
  exit 1
fi
