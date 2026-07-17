import { describe, test, expect } from 'bun:test';
import { createHmac, randomUUID } from 'node:crypto';
import type { IapValidateRequest, IapValidateResponse } from '../../src/schemas/iap';
import { createBffApp } from '../../src/index';
import { createIapValidateHandler } from '../../src/routes/iap';

/**
 * Integration: successful IAP validate persists mobile entitlement;
 * GET /entitlement reflects it; Polar/web scope is never written.
 */
const app = createBffApp({
  iapValidateHandler: createIapValidateHandler({
    checkIapAvailability: async (): Promise<{ available: true }> => ({ available: true }),
    createAppleIapValidator: async () => ({
      validate: async (req: IapValidateRequest): Promise<IapValidateResponse> => ({
        valid: true,
        product_id: req.product_id,
        transaction_id: req.transaction_id,
        environment: 'sandbox',
        expires_at: '2026-12-01T00:00:00.000Z',
      }),
    }),
    createGoogleIapValidator: async () => ({
      validate: async (req: IapValidateRequest): Promise<IapValidateResponse> => ({
        valid: true,
        product_id: req.product_id,
        transaction_id: req.transaction_id,
        environment: 'sandbox',
      }),
    }),
  }),
});

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

describe('integration: mobile entitlements persistence (WP5)', () => {
  test('valid IAP validate persists mobile row; GET /entitlement returns it', async () => {
    const token = await issueTestToken();

    const empty = await app.request('/entitlement', {
      headers: { Authorization: `Bearer ${token}` },
    });
    expect(empty.status).toBe(200);
    const emptyBody = (await empty.json()) as { scope: string; sources: unknown[] };
    expect(emptyBody.scope).toBe('mobile');
    expect(emptyBody.sources).toEqual([]);

    const validate = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({
        platform: 'apple',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: '1000000999',
        receipt_data: 'base64-receipt',
        subscription: true,
      }),
    });
    expect(validate.status).toBe(200);
    const validated = (await validate.json()) as { valid: boolean };
    expect(validated.valid).toBe(true);

    const entitled = await app.request('/entitlement', {
      headers: { Authorization: `Bearer ${token}` },
    });
    expect(entitled.status).toBe(200);
    const body = (await entitled.json()) as {
      scope: string;
      sources: Array<{ payment_source: string; product_id: string; granted_at: string }>;
    };
    expect(body.scope).toBe('mobile');
    expect(body.sources).toHaveLength(1);
    expect(body.sources[0]?.payment_source).toBe('app_store');
    expect(body.sources[0]?.product_id).toBe('com.capdesis.formulae.pro_monthly');
    // Contract: IAP grant ≠ web unlock — response scope is never "web"
    expect(body.scope).not.toBe('web');
    expect(JSON.stringify(body)).not.toContain('"web"');
    expect(JSON.stringify(body)).not.toContain('polar');
  });

  test('GET /entitlement returns 401 without bearer', async () => {
    const res = await app.request('/entitlement');
    expect(res.status).toBe(401);
  });

  test('google valid path uses play_store payment_source', async () => {
    const token = await issueTestToken();
    const validate = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({
        platform: 'google',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: 'GPA.1234',
        receipt_data: 'purchase-token',
        subscription: true,
      }),
    });
    expect(validate.status).toBe(200);

    const entitled = await app.request('/entitlement', {
      headers: { Authorization: `Bearer ${token}` },
    });
    const body = (await entitled.json()) as {
      scope: string;
      sources: Array<{ payment_source: string }>;
    };
    expect(body.scope).toBe('mobile');
    expect(body.sources.some((s) => s.payment_source === 'play_store')).toBe(true);
  });
});
