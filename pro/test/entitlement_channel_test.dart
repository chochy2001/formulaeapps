import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/entitlement_channel.dart';
import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';

void main() {
  group('evaluateMobileIapPurchase', () {
    test('allows when entitlement has no mobile sources', () {
      final entitlement = EntitlementResponse(
        (b) => b
          ..scope = EntitlementResponseScopeEnum.mobile
          ..sources = ListBuilder<EntitlementSource>(),
      );

      expect(
        evaluateMobileIapPurchase(
          entitlement: entitlement,
          fetchFailed: false,
        ),
        MobileIapPurchaseDecision.allow,
      );
    });

    test('blocks already owned when app_store source present', () {
      final entitlement = EntitlementResponse(
        (b) => b
          ..scope = EntitlementResponseScopeEnum.mobile
          ..sources = ListBuilder<EntitlementSource>([
            EntitlementSource(
              (s) => s
                ..paymentSource = EntitlementSourcePaymentSourceEnum.appStore
                ..productId = 'chat_mensual_2023_01'
                ..grantedAt = DateTime.utc(2026, 7, 13),
            ),
          ]),
      );

      expect(
        evaluateMobileIapPurchase(
          entitlement: entitlement,
          fetchFailed: false,
        ),
        MobileIapPurchaseDecision.blockAlreadyOwned,
      );
    });

    test('fail-closed blocks when fetch failed or null', () {
      expect(
        evaluateMobileIapPurchase(entitlement: null, fetchFailed: true),
        MobileIapPurchaseDecision.blockCheckFailed,
      );
      expect(
        evaluateMobileIapPurchase(entitlement: null, fetchFailed: false),
        MobileIapPurchaseDecision.blockCheckFailed,
      );
    });
  });

  group('hasActiveMobileSources', () {
    test('true for play_store', () {
      final sources = [
        EntitlementSource(
          (s) => s
            ..paymentSource = EntitlementSourcePaymentSourceEnum.playStore
            ..productId = 'android_chat_mensual_2023'
            ..grantedAt = DateTime.utc(2026, 7, 13),
        ),
      ];
      expect(hasActiveMobileSources(sources), isTrue);
    });

    test('false for empty', () {
      expect(hasActiveMobileSources(const []), isFalse);
    });
  });
}
