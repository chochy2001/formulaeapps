import 'dart:io' show Platform;

import 'package:formulae/constantes/constantes_codigo.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobConfig {
  const AdMobConfig._();

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
