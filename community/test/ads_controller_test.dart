import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/ads/admob_config.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    AdMobConfig.adsEnabled = true;
  });

  test('start is a no-op when ads are disabled', () {
    AdMobConfig.adsEnabled = false;
    final ads = FormulaeAdsController();
    ads.start(onBannerReady: () => fail('should not load banner'));
    expect(ads.banner, isNotNull);
    ads.dispose();
  });

  test('showInterstitialIfReady is safe with no loaded ad', () async {
    AdMobConfig.adsEnabled = false;
    final ads = FormulaeAdsController();
    await ads.showInterstitialIfReady();
    ads.dispose();
  });

  test('dispose is idempotent when ads never started', () {
    AdMobConfig.adsEnabled = false;
    final ads = FormulaeAdsController();
    ads.dispose();
    ads.dispose();
  });
}
