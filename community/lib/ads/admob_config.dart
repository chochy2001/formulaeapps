import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kReleaseMode, visibleForTesting;
import 'package:formulae/constantes/constantes_codigo.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobConfig {
  const AdMobConfig._();

  static const _googleTestPublisherPrefix = 'ca-app-pub-3940256099942544/';
  static const _releaseAdsExplicitlyEnabled = bool.fromEnvironment(
    'ADMOB_ENABLED',
    defaultValue: false,
  );
  static final _adUnitIdPattern = RegExp(r'^ca-app-pub-\d{16}/\d{10}$');

  /// Ads are opt-in for release builds. This keeps an unprovisioned release
  /// from attempting native SDK initialization with a missing application ID
  /// or from silently loading Google's test inventory.
  ///
  /// Tests set this to false so Community route pumps do not hit the plugin.
  static bool adsEnabled = shouldEnableAds(
    releaseMode: kReleaseMode,
    releaseAdsExplicitlyEnabled: _releaseAdsExplicitlyEnabled,
    productionAdUnitIds: _productionAdUnitIdsForCurrentPlatform,
  );

  static List<String> get _productionAdUnitIdsForCurrentPlatform =>
      Platform.isAndroid
          ? <String>[
              kBannerAdAndroidProduccion,
              kIntersticialAndroidProduccion,
              kCargaAppAnuncioAndroidProduccion,
            ]
          : <String>[
              kBannerAdIOSProduccion,
              kIntersticialIOSProduccion,
              kCargaAppAnuncioIOSProduccion,
            ];

  static bool get hasProductionAdUnitIds =>
      _productionAdUnitIdsForCurrentPlatform.every(isValidProductionAdUnitId);

  @visibleForTesting
  static bool shouldEnableAds({
    required bool releaseMode,
    required bool releaseAdsExplicitlyEnabled,
    required Iterable<String> productionAdUnitIds,
  }) {
    if (!releaseMode) {
      return true;
    }

    return releaseAdsExplicitlyEnabled &&
        productionAdUnitIds.every(isValidProductionAdUnitId);
  }

  @visibleForTesting
  static bool isValidProductionAdUnitId(String adUnitId) {
    final normalized = adUnitId.trim();
    return _adUnitIdPattern.hasMatch(normalized) &&
        !normalized.startsWith(_googleTestPublisherPrefix);
  }

  static String get bannerAdUnitId => Platform.isAndroid
      ? _adUnitIdForBuildMode(
          production: kBannerAdAndroidProduccion,
          test: kBannerAdAndroidPrueba,
        )
      : _adUnitIdForBuildMode(
          production: kBannerAdIOSProduccion,
          test: kBannerAdIOSPrueba,
        );

  static String get interstitialAdUnitId => Platform.isAndroid
      ? _adUnitIdForBuildMode(
          production: kIntersticialAndroidProduccion,
          test: kIntersticialAndroidPrueba,
        )
      : _adUnitIdForBuildMode(
          production: kIntersticialIOSProduccion,
          test: kIntersticialIOSPrueba,
        );

  static String get appOpenAdUnitId => Platform.isAndroid
      ? _adUnitIdForBuildMode(
          production: kCargaAppAnuncioAndroidProduccion,
          test: kCargaAppAnuncioAndroidPrueba,
        )
      : _adUnitIdForBuildMode(
          production: kCargaAppAnuncioIOSProduccion,
          test: kCargaAppAnuncioIOSPrueba,
        );

  static String _adUnitIdForBuildMode({
    required String production,
    required String test,
  }) {
    return kReleaseMode ? production : test;
  }

  static const defaultRequest = AdRequest(
    nonPersonalizedAds: true,
  );
}
