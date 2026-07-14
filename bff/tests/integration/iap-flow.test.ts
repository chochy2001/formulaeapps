import { afterEach, beforeEach, describe, test, expect } from 'bun:test';
import { createHmac, randomUUID } from 'node:crypto';
import { app } from '../../src/index';
import { IAP_RATE_LIMIT_MAX, iapRateLimiter } from '../../src/middleware/limiters';

function makeProof(clientId: string, buildNonce: string): string {
  return createHmac('sha256', process.env['JWT_SHARED_SECRET']!)
    .update(clientId + buildNonce)
    .digest('hex');
}

async function issueTestToken(): Promise<string> {
  const clientId = randomUUID();
  const buildNonce = 'b'.repeat(32);
  const proof = makeProof(clientId, buildNonce);
  const res = await app.request('/auth/token', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      client_id: clientId,
      client_proof: proof,
      build_nonce: buildNonce,
      platform: 'ios',
      app_version: '3.7.2',
    }),
  });
  const body = (await res.json()) as { token: string };
  return body.token;
}

describe('integration: POST /iap/validate (JWT-gated, stub validators in dev)', () => {
  beforeEach(() => {
    iapRateLimiter.reset();
  });

  afterEach(() => {
    iapRateLimiter.reset();
  });

  test('returns 401 without bearer token', async () => {
    const res = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        platform: 'apple',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: '12345',
        receipt_data: 'base64==',
        subscription: true,
      }),
    });
    expect(res.status).toBe(401);
  });

  test('returns valid=false with Apple stub validator (no apple_p8 configured in tests)', async () => {
    const token = await issueTestToken();
    const res = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({
        platform: 'apple',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: '12345',
        receipt_data: 'base64==',
        subscription: true,
      }),
    });

    expect(res.status).toBe(200);
    const body = (await res.json()) as { valid: boolean; environment: string; provider_reason?: string };
    expect(body.valid).toBe(false);
    expect(body.environment).toBe('sandbox');
    expect(body.provider_reason).toContain('not configured');
  });

  test('returns valid=false with Google stub validator', async () => {
    const token = await issueTestToken();
    const res = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({
        platform: 'google',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: 'tx',
        receipt_data: 'purchase-token',
        subscription: true,
      }),
    });
    expect(res.status).toBe(200);
    const body = (await res.json()) as { valid: boolean };
    expect(body.valid).toBe(false);
  });

  test('returns 400 on malformed body', async () => {
    const token = await issueTestToken();
    const res = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({ platform: 'martian', product_id: '', transaction_id: '', receipt_data: '', subscription: 'maybe' }),
    });
    expect(res.status).toBe(400);
  });

  test('returns the declared 429 envelope after the per-client IAP budget', async () => {
    const token = await issueTestToken();
    const request = async (): Promise<Response> =>
      await app.request('/iap/validate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
          'cf-connecting-ip': '203.0.113.80',
        },
        body: JSON.stringify({
          platform: 'apple',
          product_id: 'com.capdesis.formulae.pro_monthly',
          transaction_id: 'rate-limit-test',
          receipt_data: 'base64==',
          subscription: true,
        }),
      });

    for (let attempt = 0; attempt < IAP_RATE_LIMIT_MAX; attempt++) {
      expect((await request()).status).toBe(200);
    }

    const throttled = await request();
    const body = (await throttled.json()) as {
      error: { kind: string; code?: string; request_id: string };
    };

    expect(throttled.status).toBe(429);
    expect(throttled.headers.get('Retry-After')).toMatch(/^\d+$/);
    expect(body.error.kind).toBe('rate_limited');
    expect(body.error.code).toBe('E_RATE_LIMITED_IAP');
    expect(body.error.request_id).toMatch(
      /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i,
    );
  });
});
