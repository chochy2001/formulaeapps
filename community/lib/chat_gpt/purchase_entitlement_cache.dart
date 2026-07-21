/// Pure helpers for the client-side subscription entitlement cache.
///
/// The chat paywall caches a `hasValidPurchase` flag in SharedPreferences so it
/// can keep working offline and on quick app launches. To stop a lapsed or
/// refunded subscription from unlocking premium chat (and burning OpenRouter
/// spend through the BFF) forever, the cached `true` is only trusted for a
/// bounded time-to-live before a fresh store re-validation is forced.
library;

/// How long a cached `true` entitlement is trusted before forcing a fresh
/// store re-validation.
const Duration kEntitlementCacheTtl = Duration(hours: 24);

/// Returns `true` only when a cached entitlement may be trusted without going
/// back to the store.
///
/// [cachedValid] is the persisted `hasValidPurchase` flag, [checkedAtMs] is the
/// epoch-millisecond timestamp of the last successful validation (null when it
/// was never recorded), and [now] is the reference time (injectable for tests).
///
/// A cached entitlement is fresh only if it is `true`, has a recorded
/// validation timestamp, and that timestamp is within [ttl]. A future-dated
/// timestamp (e.g. a clock that moved backwards) is treated as not fresh so we
/// re-validate rather than trust an unbounded window.
bool isCachedEntitlementFresh({
  required bool cachedValid,
  required int? checkedAtMs,
  required DateTime now,
  Duration ttl = kEntitlementCacheTtl,
}) {
  if (!cachedValid || checkedAtMs == null) {
    return false;
  }
  final checkedAt = DateTime.fromMillisecondsSinceEpoch(checkedAtMs);
  final age = now.difference(checkedAt);
  if (age.isNegative) {
    return false;
  }
  return age < ttl;
}
