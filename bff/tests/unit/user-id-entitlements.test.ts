import { describe, test, expect, beforeEach, afterEach } from 'bun:test';
import { isUserAccountAuthEnabled } from '../../src/lib/feature-flags';
import {
  grantMobileEntitlement,
  listEntitlementsForSubject,
  listEntitlementsForUserId,
  resetEntitlementsStoreForTests,
} from '../../src/services/entitlements-store';

describe('feature-flags — ENABLE_USER_ACCOUNT_AUTH', () => {
  const prev = process.env['ENABLE_USER_ACCOUNT_AUTH'];

  afterEach(() => {
    if (prev === undefined) {
      delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    } else {
      process.env['ENABLE_USER_ACCOUNT_AUTH'] = prev;
    }
  });

  test('defaults off', () => {
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    expect(isUserAccountAuthEnabled()).toBe(false);
  });

  test('true only when exactly "true"', () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    expect(isUserAccountAuthEnabled()).toBe(true);
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = '1';
    expect(isUserAccountAuthEnabled()).toBe(false);
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'false';
    expect(isUserAccountAuthEnabled()).toBe(false);
  });
});

describe('entitlements-store user_id column (flag default off)', () => {
  const prevFlag = process.env['ENABLE_USER_ACCOUNT_AUTH'];

  beforeEach(() => {
    process.env['ENTITLEMENTS_DB_PATH'] = ':memory:';
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    resetEntitlementsStoreForTests();
  });

  afterEach(() => {
    if (prevFlag === undefined) {
      delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    } else {
      process.env['ENABLE_USER_ACCOUNT_AUTH'] = prevFlag;
    }
  });

  test('grant ignores user_id while flag is off (column stays NULL)', () => {
    const row = grantMobileEntitlement({
      subject: 'sub-device-1',
      payment_source: 'app_store',
      product_id: 'pro',
      raw_receipt_ref: 'tx-1',
      user_id: '550e8400-e29b-41d4-a716-446655440000',
    });
    expect(row.user_id).toBeNull();
    expect(listEntitlementsForSubject('sub-device-1')[0]?.user_id).toBeNull();
    expect(listEntitlementsForUserId('550e8400-e29b-41d4-a716-446655440000')).toHaveLength(0);
  });

  test('flag on: grant persists user_id and listEntitlementsForUserId works', () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    const userId = '550e8400-e29b-41d4-a716-446655440000';
    const row = grantMobileEntitlement({
      subject: 'sub-bound',
      payment_source: 'play_store',
      product_id: 'pro',
      raw_receipt_ref: 'tok-1',
      user_id: userId,
    });
    expect(row.user_id).toBe(userId);
    const byUser = listEntitlementsForUserId(userId);
    expect(byUser).toHaveLength(1);
    expect(byUser[0]?.subject).toBe('sub-bound');
  });

});
