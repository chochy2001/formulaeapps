import { describe, test, expect, beforeEach } from 'bun:test';
import {
  grantMobileEntitlement,
  listEntitlementsForSubject,
  paymentSourceFromPlatform,
  resetEntitlementsStoreForTests,
} from '../../src/services/entitlements-store';

describe('entitlements-store (bun:sqlite)', () => {
  beforeEach(() => {
    process.env['ENTITLEMENTS_DB_PATH'] = ':memory:';
    resetEntitlementsStoreForTests();
  });

  test('paymentSourceFromPlatform maps apple→app_store and google→play_store', () => {
    expect(paymentSourceFromPlatform('apple')).toBe('app_store');
    expect(paymentSourceFromPlatform('google')).toBe('play_store');
  });

  test('grant persists scope=mobile only and list returns it', () => {
    const row = grantMobileEntitlement({
      subject: 'sub-device-1',
      payment_source: 'app_store',
      product_id: 'com.capdesis.formulae.pro_monthly',
      raw_receipt_ref: 'tx-100',
    });
    expect(row.scope).toBe('mobile');
    expect(row.payment_source).toBe('app_store');

    const listed = listEntitlementsForSubject('sub-device-1');
    expect(listed).toHaveLength(1);
    expect(listed[0]?.product_id).toBe('com.capdesis.formulae.pro_monthly');
    expect(listed[0]?.scope).toBe('mobile');
  });

  test('idempotent upsert on same subject+source+product+receipt', () => {
    grantMobileEntitlement({
      subject: 'sub-a',
      payment_source: 'play_store',
      product_id: 'pro',
      raw_receipt_ref: 'tok-1',
    });
    grantMobileEntitlement({
      subject: 'sub-a',
      payment_source: 'play_store',
      product_id: 'pro',
      raw_receipt_ref: 'tok-1',
    });
    expect(listEntitlementsForSubject('sub-a')).toHaveLength(1);
  });

  test('subjects are isolated', () => {
    grantMobileEntitlement({
      subject: 'sub-a',
      payment_source: 'app_store',
      product_id: 'pro',
      raw_receipt_ref: 'tx-a',
    });
    grantMobileEntitlement({
      subject: 'sub-b',
      payment_source: 'app_store',
      product_id: 'pro',
      raw_receipt_ref: 'tx-b',
    });
    expect(listEntitlementsForSubject('sub-a')).toHaveLength(1);
    expect(listEntitlementsForSubject('sub-b')).toHaveLength(1);
    expect(listEntitlementsForSubject('sub-c')).toHaveLength(0);
  });

  test('never writes polar/web scope from grant path', () => {
    const row = grantMobileEntitlement({
      subject: 'sub-scope',
      payment_source: 'app_store',
      product_id: 'pro',
      raw_receipt_ref: 'tx-scope',
    });
    expect(row.scope).toBe('mobile');
    expect(row.scope).not.toBe('web');
    expect(JSON.stringify(row)).not.toContain('polar');
  });
});
