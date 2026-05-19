import { describe, test, expect } from 'bun:test';
import { GoogleIapStubValidator, GoogleIapRealValidator } from '../../src/services/google-iap';

describe('google-iap stub validator', () => {
  const stub = new GoogleIapStubValidator();

  test('returns valid=false with sandbox env when called', async () => {
    const result = await stub.validate({
      platform: 'google',
      product_id: 'com.example.test',
      transaction_id: 'tx',
      receipt_data: 'purchase-token',
      subscription: true,
    });
    expect(result.valid).toBe(false);
    expect(result.environment).toBe('sandbox');
    expect(result.product_id).toBe('com.example.test');
    expect(result.provider_reason).toContain('not configured');
  });

  test('rejects apple platform request', async () => {
    await expect(
      stub.validate({
        platform: 'apple',
        product_id: 'x',
        transaction_id: 'y',
        receipt_data: 'z',
        subscription: false,
      }),
    ).rejects.toMatchObject({ kind: 'bad_request' });
  });
});

describe('google-iap real validator', () => {
  test('throws explicit not-ready until live integration testing lands', async () => {
    const real = new GoogleIapRealValidator({
      serviceAccountJson: '{"type":"service_account"}',
      packageName: 'com.capdesis.formulae',
    });
    await expect(
      real.validate({
        platform: 'google',
        product_id: 'x',
        transaction_id: 'y',
        receipt_data: 'z',
        subscription: false,
      }),
    ).rejects.toMatchObject({ code: 'E_GOOGLE_IAP_NOT_READY' });
  });
});
