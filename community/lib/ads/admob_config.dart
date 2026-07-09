import 'dart:io' show Platform;

import 'package:formulae/constantes/constantes_codigo.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobConfig {
  const AdMobConfig._();

  /// When false, screens skip BannerAd / InterstitialAd load in initState.
  /// Tests set this to false so Community route pumps do not hit the plugin.
  static bool adsEnabled = true;

  static String get bannerAdUnitId =>
      Platform.isAndroid ? kBannerAdAndroidPrueba : kBannerAdIOSPrueba;

  static String get interstitialAdUnitId =>
      Platform.isAndroid ? kIntersticialAndroidPrueba : kIntersticialIOSPrueba;

  static String get appOpenAdUnitId => Platform.isAndroid
      ? kCargaAppAnuncioAndroidPrueba
      : kCargaAppAnuncioIOSPrueba;

  static const defaultRequest = AdRequest(
    nonPersonalizedAds: true,
  );
}
