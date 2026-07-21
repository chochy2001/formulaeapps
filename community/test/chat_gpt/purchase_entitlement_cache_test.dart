import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/purchase_entitlement_cache.dart';

void main() {
  group('isCachedEntitlementFresh', () {
    final now = DateTime(2026, 6, 10, 12, 0, 0);

    int msAgo(Duration d) => now.subtract(d).millisecondsSinceEpoch;

    test('returns false when there is no cached entitlement', () {
      expect(
        isCachedEntitlementFresh(
          cachedValid: false,
          checkedAtMs: msAgo(const Duration(minutes: 1)),
          now: now,
        ),
        isFalse,
      );
    });

    test('returns false when cached true but no timestamp was recorded', () {
      expect(
        isCachedEntitlementFresh(
          cachedValid: true,
          checkedAtMs: null,
          now: now,
        ),
        isFalse,
      );
    });

    test('returns true for a recently validated entitlement', () {
      expect(
        isCachedEntitlementFresh(
          cachedValid: true,
          checkedAtMs: msAgo(const Duration(hours: 1)),
          now: now,
        ),
        isTrue,
      );
    });

    test('returns true just inside the TTL window', () {
      expect(
        isCachedEntitlementFresh(
          cachedValid: true,
          checkedAtMs: msAgo(kEntitlementCacheTtl - const Duration(minutes: 1)),
          now: now,
        ),
        isTrue,
      );
    });

    test('forces re-validation once the TTL has elapsed (money-path)', () {
      // A lapsed/refunded subscriber whose cache is older than the TTL must NOT
      // be trusted: otherwise premium chat stays unlocked and keeps spending
      // OpenRouter budget through the BFF with no matching revenue.
      expect(
        isCachedEntitlementFresh(
          cachedValid: true,
          checkedAtMs: msAgo(kEntitlementCacheTtl + const Duration(minutes: 1)),
          now: now,
        ),
        isFalse,
      );
    });

    test('returns false exactly at the TTL boundary', () {
      expect(
        isCachedEntitlementFresh(
          cachedValid: true,
          checkedAtMs: msAgo(kEntitlementCacheTtl),
          now: now,
        ),
        isFalse,
      );
    });

    test(
      'treats a future-dated timestamp as stale (clock moved backwards)',
      () {
        expect(
          isCachedEntitlementFresh(
            cachedValid: true,
            checkedAtMs: now
                .add(const Duration(hours: 1))
                .millisecondsSinceEpoch,
            now: now,
          ),
          isFalse,
        );
      },
    );

    test('honours a custom TTL', () {
      expect(
        isCachedEntitlementFresh(
          cachedValid: true,
          checkedAtMs: msAgo(const Duration(minutes: 10)),
          now: now,
          ttl: const Duration(minutes: 5),
        ),
        isFalse,
      );
    });
  });
}
