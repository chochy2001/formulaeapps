import { describe, test, expect, beforeEach } from 'bun:test';
import {
  grantMobileEntitlement,
  assertStorePaymentSource,
  resetEntitlementsStoreForTests,
} from '../../src/services/entitlements-store';
import {
  evaluateMobileIapPurchase,
  hasActiveMobileEntitlement,
  readMobileEntitlement,
} from '../../src/services/entitlement-check';

describe('entitlement-check (fail-closed)', () => {
  beforeEach(() => {
    process.env['ENTITLEMENTS_DB_PATH'] = ':memory:';
    resetEntitlementsStoreForTests();
  });

  test('empty subject is not entitled', () => {
    expect(hasActiveMobileEntitlement('')).toBe(false);
    expect(hasActiveMobileEntitlement('   ')).toBe(false);
    expect(evaluateMobileIapPurchase('')).toBe('allow');
  });

  test('unknown subject is not entitled (fail-closed empty)', () => {
    expect(hasActiveMobileEntitlement('no-such-sub')).toBe(false);
    const view = readMobileEntitlement('no-such-sub');
    expect(view.scope).toBe('mobile');
    expect(view.entitled).toBe(false);
    expect(view.sources).toEqual([]);
  });

  test('granted mobile row → entitled + blockAlreadyOwned', () => {
    grantMobileEntitlement({
      subject: 'sub-owned',
      payment_source: 'app_store',
      product_id: 'com.capdesis.formulae.pro_monthly',
      raw_receipt_ref: 'tx-1',
    });
    expect(hasActiveMobileEntitlement('sub-owned')).toBe(true);
    expect(evaluateMobileIapPurchase('sub-owned')).toBe('blockAlreadyOwned');
    const view = readMobileEntitlement('sub-owned');
    expect(view.scope).toBe('mobile');
    expect(view.sources).toHaveLength(1);
    expect(view.sources[0]?.payment_source).toBe('app_store');
  });
});

describe('assertStorePaymentSource — IAP ≠ Polar/web', () => {
  test('accepts app_store and play_store', () => {
    expect(() => assertStorePaymentSource('app_store')).not.toThrow();
    expect(() => assertStorePaymentSource('play_store')).not.toThrow();
  });

  test('rejects polar and web (contract: IAP grant ≠ web unlock)', () => {
    expect(() => assertStorePaymentSource('polar')).toThrow(/never polar\/web/);
    expect(() => assertStorePaymentSource('web')).toThrow(/never polar\/web/);
  });

  test('grantMobileEntitlement rejects polar payment_source at runtime', () => {
    process.env['ENTITLEMENTS_DB_PATH'] = ':memory:';
    resetEntitlementsStoreForTests();
    expect(() =>
      grantMobileEntitlement({
        subject: 'sub-polar',
        // Bypass TS to simulate a bad caller / future polar wiring mistake.
        payment_source: 'polar' as 'app_store',
        product_id: 'polar.pro',
        raw_receipt_ref: 'pol_1',
      }),
    ).toThrow(/never polar\/web/);
  });
});
