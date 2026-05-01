#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-lib}"

while IFS= read -r file; do
  perl -0pi -e "s/static final AdRequest request = AdRequest\\(\\s*keywords: <String>\\['foo', 'bar'\\],\\s*contentUrl: 'http:\\/\\/foo\\.com\\/bar\\.html',\\s*nonPersonalizedAds: true,\\s*\\);/static final AdRequest request = AdMobConfig.defaultRequest;/g" "$file"
  perl -0pi -e "s/request: AdRequest\\(\\),/request: AdMobConfig.defaultRequest,/g" "$file"
  perl -0pi -e "s/Platform\\.isAndroid\\s*\\?\\s*kBannerAdAndroidPrueba\\s*:\\s*kBannerAdIOSPrueba/AdMobConfig.bannerAdUnitId/g" "$file"
  perl -0pi -e "s/Platform\\.isAndroid\\s*\\?\\s*kIntersticialAndroidPrueba\\s*:\\s*kIntersticialIOSPrueba/AdMobConfig.interstitialAdUnitId/g" "$file"
  perl -0pi -e "s/Platform\\.isAndroid\\s*\\?\\s*kCargaAppAnuncioAndroidPrueba\\s*:\\s*kCargaAppAnuncioIOSPrueba/AdMobConfig.appOpenAdUnitId/g" "$file"
done < <(rg -l 'AdRequest|kBannerAd|kIntersticial|kCargaAppAnuncio|contentUrl' "$ROOT" -g '*.dart' |
  grep -v '/ads/admob_config.dart$' || true)

dart format "$ROOT"
rg -n "contentUrl: 'http://foo.com/bar.html'|Platform\\.isAndroid\\s*\\?\\s*k(BannerAd|Intersticial|CargaAppAnuncio)" "$ROOT" -g '*.dart' || true
