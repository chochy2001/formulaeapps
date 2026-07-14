import { describe, expect, test } from 'bun:test';
import { BffError } from '../../src/middleware/error';
import { persistValidatedMobileIap } from '../../src/services/iap-entitlement-persistence';

const validatedPurchase = {
  subject: 'device-subject',
  platform: 'apple' as const,
  product_id: 'com.capdesis.formulae.pro_monthly',
  transaction_id: '1000000123456789',
  user_id: '550e8400-e29b-41d4-a716-446655440000',
};

describe('persistValidatedMobileIap', () => {
  test('passes a confirmed purchase to the durable entitlement grant', () => {
    let persisted: unknown;

    persistValidatedMobileIap(validatedPurchase, (input) => {
      persisted = input;
    });

    expect(persisted).toEqual({
      subject: 'device-subject',
      payment_source: 'app_store',
      product_id: 'com.capdesis.formulae.pro_monthly',
      raw_receipt_ref: '1000000123456789',
      user_id: '550e8400-e29b-41d4-a716-446655440000',
    });
  });

  test('fails closed when a confirmed purchase cannot be persisted', () => {
    try {
      persistValidatedMobileIap(validatedPurchase, () => {
        throw new Error('disk unavailable');
      });
      throw new Error('expected persistence to fail');
    } catch (error) {
      expect(error).toBeInstanceOf(BffError);
      expect((error as BffError).kind).toBe('internal_error');
      expect((error as BffError).code).toBe('E_ENTITLEMENT_PERSISTENCE');
    }
  });

  test('fails closed if the JWT middleware did not provide a subject', () => {
    expect(() =>
      persistValidatedMobileIap({ ...validatedPurchase, subject: '   ' }, () => undefined),
    ).toThrow(BffError);
  });
});
