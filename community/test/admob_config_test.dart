import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/ads/admob_config.dart';

void main() {
  test('release ads require explicit, non-test production unit IDs', () {
    const validProductionLikeId = 'ca-app-pub-1234567890123456/1234567890';
    const googleTestId = 'ca-app-pub-3940256099942544/2934735716';

    expect(
      AdMobConfig.shouldEnableAds(
        releaseMode: true,
        releaseAdsExplicitlyEnabled: false,
        productionAdUnitIds: <String>[validProductionLikeId],
      ),
      isFalse,
    );
    expect(
      AdMobConfig.shouldEnableAds(
        releaseMode: true,
        releaseAdsExplicitlyEnabled: true,
        productionAdUnitIds: <String>[googleTestId],
      ),
      isFalse,
    );
    expect(
      AdMobConfig.shouldEnableAds(
        releaseMode: true,
        releaseAdsExplicitlyEnabled: true,
        productionAdUnitIds: <String>[validProductionLikeId],
      ),
      isTrue,
    );
  });

  test('non-release builds keep the test-ad path available', () {
    expect(
      AdMobConfig.shouldEnableAds(
        releaseMode: false,
        releaseAdsExplicitlyEnabled: false,
        productionAdUnitIds: const <String>[],
      ),
      isTrue,
    );
  });

  test('official Google test unit IDs are never accepted as production IDs',
      () {
    expect(
      AdMobConfig.isValidProductionAdUnitId(
        'ca-app-pub-3940256099942544/2934735716',
      ),
      isFalse,
    );
    expect(
      AdMobConfig.isValidProductionAdUnitId(
        'ca-app-pub-1234567890123456/1234567890',
      ),
      isTrue,
    );
    expect(AdMobConfig.isValidProductionAdUnitId('not-an-ad-unit'), isFalse);
  });
}
