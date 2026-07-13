import 'package:formulaeapps_bff_client/formulaeapps_bff_client.dart';

/// Channel-scoped entitlement helpers for fleet §10 Polar↔IAP (mobile path).
///
/// Formulae Pro is mobile-IAP-only today. Polar/`web` scope is never returned
/// from `GET /entitlement` and must never unlock (or block) this path as if it
/// were a mobile grant. See `docs/ENTITLEMENT_CHANNEL_SYNC.md`.

/// Outcome of evaluating a mobile IAP purchase attempt (pre-charge).
enum MobileIapPurchaseDecision {
  /// User may proceed to the store charge sheet.
  allow,

  /// Subject already has an active mobile entitlement — anti double-pay.
  blockAlreadyOwned,

  /// Flag on but entitlement status could not be confirmed — fail-closed.
  blockCheckFailed,
}

bool hasActiveMobileSources(Iterable<EntitlementSource> sources) {
  return sources.any(
    (s) =>
        s.paymentSource == EntitlementSourcePaymentSourceEnum.appStore ||
        s.paymentSource == EntitlementSourcePaymentSourceEnum.playStore,
  );
}

/// Evaluates whether the paywall may start a store purchase.
///
/// Fail-closed: missing or failed entitlement fetch → [blockCheckFailed].
MobileIapPurchaseDecision evaluateMobileIapPurchase({
  required EntitlementResponse? entitlement,
  required bool fetchFailed,
}) {
  if (fetchFailed || entitlement == null) {
    return MobileIapPurchaseDecision.blockCheckFailed;
  }
  if (hasActiveMobileSources(entitlement.sources)) {
    return MobileIapPurchaseDecision.blockAlreadyOwned;
  }
  return MobileIapPurchaseDecision.allow;
}
