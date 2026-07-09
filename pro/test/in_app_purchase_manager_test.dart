import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/in_app_purchase_manager.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

import 'helpers/fake_iap_platform.dart';

void main() {
  late FakeInAppPurchasePlatform platform;
  late InAppPurchaseManager manager;

  setUp(() {
    platform = FakeInAppPurchasePlatform();
    manager = InAppPurchaseManager(
      platform: platform,
      listenToPurchases: true,
      platformOverride: 'ios',
    );
  });

  tearDown(() async {
    manager.dispose();
    await platform.close();
  });

  test('platformProductIds returns Pro iOS catalog', () {
    expect(
      manager.platformProductIds(),
      {
        'chat_anual_2023_01',
        'chat_mensual_2023_01',
        'chat_semanal_2023_01',
      },
    );
  });

  test('platformProductIds returns Pro Android catalog', () {
    final androidManager = InAppPurchaseManager(
      platform: platform,
      listenToPurchases: false,
      platformOverride: 'android',
    );
    expect(
      androidManager.platformProductIds(),
      {
        'chat_anual_2023',
        'android_chat_mensual_2023',
        'chat_semanal_2023',
      },
    );
    androidManager.dispose();
  });

  test('handlePurchaseUpdates completes purchased pending items', () {
    final purchase = fakePurchase(
      productId: 'chat_mensual_2023_01',
      status: PurchaseStatus.purchased,
      pendingCompletePurchase: true,
    );

    var notified = 0;
    manager.addListener(() => notified++);

    manager.handlePurchaseUpdates([purchase]);

    expect(manager.hasValidPurchase, isTrue);
    expect(platform.completedPurchases, [purchase]);
    expect(notified, 1);
  });

  test('handlePurchaseUpdates ignores cancelled purchases', () {
    manager.handlePurchaseUpdates([
      fakePurchase(
        productId: 'chat_mensual_2023_01',
        status: PurchaseStatus.canceled,
      ),
    ]);

    expect(manager.hasValidPurchase, isFalse);
    expect(platform.completedPurchases, isEmpty);
  });

  test('getProducts loads catalog when store returns all ids', () async {
    platform.products = [
      fakeProduct('chat_anual_2023_01'),
      fakeProduct('chat_mensual_2023_01'),
      fakeProduct('chat_semanal_2023_01'),
    ];

    await manager.getProducts();

    expect(manager.products, hasLength(3));
    expect(
      platform.lastQueriedIds,
      {
        'chat_anual_2023_01',
        'chat_mensual_2023_01',
        'chat_semanal_2023_01',
      },
    );
  });

  test('buyProduct no-ops when store is unavailable', () async {
    platform.available = false;

    await manager.buyProduct(fakeProduct('chat_mensual_2023_01'));

    expect(platform.buyCalls, 0);
  });

  test('buyProduct forwards to store when available', () async {
    await manager.buyProduct(fakeProduct('chat_mensual_2023_01'));

    expect(platform.buyCalls, 1);
  });

  test('checkValidPurchase completes true on restored entitlement', () async {
    final future = manager.checkValidPurchase();
    await Future<void>.delayed(Duration.zero);
    platform.emit([
      fakePurchase(
        productId: 'chat_mensual_2023_01',
        status: PurchaseStatus.restored,
      ),
    ]);

    expect(await future, isTrue);
    expect(platform.restoreCalls, 1);
  });
}
