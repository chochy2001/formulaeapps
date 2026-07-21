import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/in_app_purchase_manager.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_iap_platform.dart';

void main() {
  late FakeInAppPurchasePlatform platform;
  late InAppPurchaseManager manager;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
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

  test('platformProductIds returns Community iOS catalog', () {
    expect(manager.platformProductIds(), {
      'chat_anual_2023_community',
      'chat_mensual_2023_community',
      'chat_semanal_2023_community',
    });
  });

  test('platformProductIds returns Community Android catalog', () {
    final androidManager = InAppPurchaseManager(
      platform: platform,
      listenToPurchases: false,
      platformOverride: 'android',
    );
    expect(androidManager.platformProductIds(), {
      'chat_anual_2023_community',
      'android_chat_mensual_2023_community',
      'chat_semanal_2023_community',
    });
    androidManager.dispose();
  });

  test('handlePurchaseUpdates completes purchased pending items', () {
    final purchase = fakePurchase(
      productId: 'chat_mensual_2023_community',
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
        productId: 'chat_mensual_2023_community',
        status: PurchaseStatus.canceled,
      ),
    ]);

    expect(manager.hasValidPurchase, isFalse);
    expect(platform.completedPurchases, isEmpty);
  });

  test('handlePurchaseUpdates swallows error status without completing', () {
    manager.handlePurchaseUpdates([
      fakePurchase(
        productId: 'chat_mensual_2023_community',
        status: PurchaseStatus.error,
        error: IAPError(source: 'test', code: 'billing', message: 'failed'),
      ),
    ]);

    expect(manager.hasValidPurchase, isFalse);
    expect(platform.completedPurchases, isEmpty);
  });

  test('getProducts loads catalog when store returns all ids', () async {
    platform.products = [
      fakeProduct('chat_anual_2023_community'),
      fakeProduct('chat_mensual_2023_community'),
      fakeProduct('chat_semanal_2023_community'),
    ];

    await manager.getProducts();

    expect(manager.products, hasLength(3));
    expect(platform.lastQueriedIds, {
      'chat_anual_2023_community',
      'chat_mensual_2023_community',
      'chat_semanal_2023_community',
    });
  });

  test('getProducts keeps empty catalog when any id is missing', () async {
    platform.products = [fakeProduct('chat_anual_2023_community')];
    platform.notFoundIds = {'chat_mensual_2023_community'};

    await manager.getProducts();

    expect(manager.products, isEmpty);
  });

  test('buyProduct no-ops when store is unavailable', () async {
    platform.available = false;

    await manager.buyProduct(fakeProduct('chat_mensual_2023_community'));

    expect(platform.buyCalls, 0);
  });

  test('buyProduct forwards to store when available', () async {
    await manager.buyProduct(fakeProduct('chat_mensual_2023_community'));

    expect(platform.buyCalls, 1);
  });

  test('buyProduct swallows store exceptions', () async {
    platform.buyThrows = true;

    await manager.buyProduct(fakeProduct('chat_mensual_2023_community'));

    expect(platform.buyCalls, 1);
  });

  test('checkValidPurchase completes true on restored entitlement', () async {
    final future = manager.checkValidPurchase();
    await Future<void>.delayed(Duration.zero);
    platform.emit([
      fakePurchase(
        productId: 'chat_mensual_2023_community',
        status: PurchaseStatus.restored,
      ),
    ]);

    expect(await future, isTrue);
    expect(platform.restoreCalls, 1);
  });
}
