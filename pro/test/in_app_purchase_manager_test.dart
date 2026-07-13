import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/entitlement_channel.dart';
import 'package:formulae/chat_gpt/entitlement_service.dart';
import 'package:formulae/chat_gpt/in_app_purchase_manager.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';
import 'package:formulaeapps_bff_client/src/serializers.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

import 'helpers/fake_iap_platform.dart';

class _StubEntitlementClient extends FormulaeappsBffClient {
  _StubEntitlementClient(this.payload)
      : super(
          basePathOverride: 'http://test-bff',
          dio: Dio(BaseOptions(baseUrl: 'http://test-bff')),
        );

  final EntitlementResponse? payload;

  @override
  EntitlementApi getEntitlementApi() => _StubEntitlementApi(this);
}

class _StubEntitlementApi extends EntitlementApi {
  _StubEntitlementApi(this._parent) : super(_parent.dio, standardSerializers);

  final _StubEntitlementClient _parent;

  @override
  Future<Response<EntitlementResponse>> entitlementGet({
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (_parent.payload == null) {
      throw DioException(
        requestOptions: RequestOptions(path: '/entitlement'),
        type: DioExceptionType.connectionError,
      );
    }
    return Response<EntitlementResponse>(
      data: _parent.payload,
      requestOptions: RequestOptions(path: '/entitlement'),
      statusCode: 200,
    );
  }
}

EntitlementService _entitlementStub(EntitlementResponse? payload) {
  return EntitlementService(
    tokenProvider: () async => 'token',
    clientFactory: (_) => _StubEntitlementClient(payload),
  );
}

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

  test('buyProduct skips entitlement guard when BFF flag is off', () async {
    // Default manager has flag off — even a "owned" stub must not be consulted.
    final guarded = InAppPurchaseManager(
      platform: platform,
      listenToPurchases: false,
      platformOverride: 'ios',
      bffIapValidationEnabled: false,
      entitlementService: _entitlementStub(
        EntitlementResponse(
          (b) => b
            ..scope = EntitlementResponseScopeEnum.mobile
            ..sources = ListBuilder<EntitlementSource>([
              EntitlementSource(
                (s) => s
                  ..paymentSource =
                      EntitlementSourcePaymentSourceEnum.appStore
                  ..productId = 'chat_mensual_2023_01'
                  ..grantedAt = DateTime.utc(2026, 7, 13),
              ),
            ]),
        ),
      ),
    );

    await guarded.buyProduct(fakeProduct('chat_mensual_2023_01'));

    expect(platform.buyCalls, 1);
    expect(guarded.lastPurchaseBlockReason, isNull);
    guarded.dispose();
  });

  test('buyProduct blocks already-owned when BFF flag is on', () async {
    final guarded = InAppPurchaseManager(
      platform: platform,
      listenToPurchases: false,
      platformOverride: 'ios',
      bffIapValidationEnabled: true,
      entitlementService: _entitlementStub(
        EntitlementResponse(
          (b) => b
            ..scope = EntitlementResponseScopeEnum.mobile
            ..sources = ListBuilder<EntitlementSource>([
              EntitlementSource(
                (s) => s
                  ..paymentSource =
                      EntitlementSourcePaymentSourceEnum.appStore
                  ..productId = 'chat_mensual_2023_01'
                  ..grantedAt = DateTime.utc(2026, 7, 13),
              ),
            ]),
        ),
      ),
    );

    await guarded.buyProduct(fakeProduct('chat_mensual_2023_01'));

    expect(platform.buyCalls, 0);
    expect(
      guarded.lastPurchaseBlockReason,
      MobileIapPurchaseDecision.blockAlreadyOwned,
    );
    guarded.dispose();
  });

  test('buyProduct fail-closed blocks when entitlement fetch fails', () async {
    final guarded = InAppPurchaseManager(
      platform: platform,
      listenToPurchases: false,
      platformOverride: 'ios',
      bffIapValidationEnabled: true,
      entitlementService: _entitlementStub(null),
    );

    await guarded.buyProduct(fakeProduct('chat_mensual_2023_01'));

    expect(platform.buyCalls, 0);
    expect(
      guarded.lastPurchaseBlockReason,
      MobileIapPurchaseDecision.blockCheckFailed,
    );
    guarded.dispose();
  });

  test('buyProduct allows when flag on and entitlement empty', () async {
    final guarded = InAppPurchaseManager(
      platform: platform,
      listenToPurchases: false,
      platformOverride: 'ios',
      bffIapValidationEnabled: true,
      entitlementService: _entitlementStub(
        EntitlementResponse(
          (b) => b
            ..scope = EntitlementResponseScopeEnum.mobile
            ..sources = ListBuilder<EntitlementSource>(),
        ),
      ),
    );

    await guarded.buyProduct(fakeProduct('chat_mensual_2023_01'));

    expect(platform.buyCalls, 1);
    expect(guarded.lastPurchaseBlockReason, isNull);
    guarded.dispose();
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
