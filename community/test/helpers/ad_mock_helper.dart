import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Stubs Google Mobile Ads method channel so Community screens that create
/// BannerAd in initState can pump under flutter_test.
void mockGoogleMobileAds() {
  TestWidgetsFlutterBinding.ensureInitialized().defaultBinaryMessenger
      .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/google_mobile_ads'),
        (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'MobileAds#initialize':
            case 'initialize':
            case 'loadAd':
            case 'disposeAd':
            case 'loadInterstitialAd':
            case 'showInterstitialAd':
            case 'loadRewardedAd':
            case 'showRewardedAd':
            case 'loadAppOpenAd':
            case 'showAppOpenAd':
            case 'loadNativeAd':
            case 'disposeNativeAd':
            case 'setAppVolume':
            case 'setAppMuted':
            case 'updateRequestConfiguration':
            case '_init':
              return <String, dynamic>{};
            case 'getAdSize':
              return <String, dynamic>{'width': 320.0, 'height': 50.0};
            case 'getVersionString':
              return '5.3.1';
            case 'getRequestConfiguration':
              return <String, dynamic>{};
            case 'getAdProviders':
              return <dynamic>[];
            default:
              return null;
          }
        },
      );
}
