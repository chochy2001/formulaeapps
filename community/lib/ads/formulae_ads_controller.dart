import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob_config.dart';

/// Shared banner + interstitial lifecycle for Community formula screens.
///
/// Keeps AdMob plugin calls out of every screen's `initState` so unit/widget
/// tests can disable ads via [AdMobConfig.adsEnabled] without leaving
/// thousands of duplicated uncovered lines in the denominator.
class FormulaeAdsController {
  FormulaeAdsController();

  static const int maxFailedLoadAttempts = 3;

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  Widget _bannerWidget = _placeholder();

  Widget get banner => _bannerWidget;

  void start({VoidCallback? onBannerReady}) {
    if (!AdMobConfig.adsEnabled) {
      return;
    }
    _createInterstitialAd();
    late final BannerAd createdBanner;
    createdBanner = BannerAd(
      adUnitId: AdMobConfig.bannerAdUnitId,
      size: AdSize.banner,
      request: AdMobConfig.defaultRequest,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _bannerWidget = Container(
            alignment: Alignment.center,
            width: createdBanner.size.width.toDouble(),
            height: createdBanner.size.height.toDouble(),
            child: AdWidget(ad: createdBanner),
          );
          onBannerReady?.call();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd = createdBanner;
    createdBanner.load();
  }

  void _createInterstitialAd() {
    if (!AdMobConfig.adsEnabled) {
      return;
    }
    InterstitialAd.load(
      adUnitId: AdMobConfig.interstitialAdUnitId,
      request: AdMobConfig.defaultRequest,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd?.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  Future<void> showInterstitialIfReady() async {
    final ad = _interstitialAd;
    if (ad == null) {
      return;
    }
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _interstitialAd = null;
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _interstitialAd = null;
        _createInterstitialAd();
      },
    );
    await ad.show();
  }

  void dispose() {
    _interstitialAd?.dispose();
    _bannerAd?.dispose();
  }

  static Widget _placeholder() {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: AdSize.banner.width.toDouble(),
        height: AdSize.banner.height.toDouble(),
      ),
    );
  }
}
