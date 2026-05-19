import { describe, test, expect } from 'bun:test';
import { AppleIapStubValidator, AppleIapRealValidator } from '../../src/services/apple-iap';

describe('apple-iap stub validator', () => {
  const stub = new AppleIapStubValidator();

  test('returns valid=false with sandbox env when called', async () => {
    const result = await stub.validate({
      platform: 'apple',
      product_id: 'com.example.test',
      transaction_id: '12345',
      receipt_data: 'base64==',
      subscription: true,
    });
    expect(result.valid).toBe(false);
    expect(result.environment).toBe('sandbox');
    expect(result.product_id).toBe('com.example.test');
    expect(result.transaction_id).toBe('12345');
    expect(result.provider_reason).toContain('not configured');
  });

  test('rejects google platform request', async () => {
    await expect(
      stub.validate({
        platform: 'google',
        product_id: 'x',
        transaction_id: 'y',
        receipt_data: 'z',
        subscription: false,
      }),
    ).rejects.toMatchObject({ kind: 'bad_request' });
  });

  test('does not leak raw receipt data in response', async () => {
    const result = await stub.validate({
      platform: 'apple',
      product_id: 'p',
      transaction_id: 't',
      receipt_data: 'SECRET_RECEIPT_BODY_VERY_LONG',
      subscription: false,
    });
    expect(JSON.stringify(result)).not.toContain('SECRET_RECEIPT_BODY_VERY_LONG');
  });
});

describe('apple-iap real validator', () => {
  test('throws explicit not-ready until live integration testing lands', async () => {
    const real = new AppleIapRealValidator({
      privateKey: '-----BEGIN PRIVATE KEY-----\nFAKE\n-----END PRIVATE KEY-----',
      issuerId: 'iss',
      keyId: 'kid',
      bundleId: 'com.capdesis.formulae',
    });
    await expect(
      real.validate({
        platform: 'apple',
        product_id: 'x',
        transaction_id: 'y',
        receipt_data: 'z',
        subscription: false,
      }),
    ).rejects.toMatchObject({ code: 'E_APPLE_IAP_NOT_READY' });
  });
});
