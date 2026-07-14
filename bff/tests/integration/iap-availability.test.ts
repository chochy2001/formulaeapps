import { describe, test, expect } from 'bun:test';
import { createHmac, randomUUID } from 'node:crypto';
import { app as defaultApp, createBffApp } from '../../src/index';
import { createIapValidateHandler } from '../../src/routes/iap';

// This app is deliberately built with a local handler dependency rather than
// Bun's process-wide mock.module. Other integration files keep exercising the
// production singleton concurrently, including the normal valid=false stub.
type AvailabilityResult =
  | { available: true }
  | { available: false; reason: string };

const AVAILABLE: AvailabilityResult = { available: true };

function createAvailabilityApp(
  availability: Partial<Record<'apple' | 'google', AvailabilityResult>> = {},
) {
  return createBffApp({
    iapValidateHandler: createIapValidateHandler({
      checkIapAvailability: async (
        platform: 'apple' | 'google',
      ): Promise<AvailabilityResult> => availability[platform] ?? AVAILABLE,
    }),
  });
}

function makeProof(clientId: string, buildNonce: string): string {
  return createHmac('sha256', process.env['JWT_SHARED_SECRET']!)
    .update(clientId + buildNonce)
    .digest('hex');
}

async function issueTestToken(app: ReturnType<typeof createBffApp>): Promise<string> {
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

describe('integration: POST /iap/validate — placeholder-secret 503 envelope', () => {
  test('apple: returns 503 + iap_validation_unavailable envelope when secrets are placeholders', async () => {
    const app = createAvailabilityApp({
      apple: { available: false, reason: 'apple_p8_file_missing' },
    });
    const token = await issueTestToken(app);
    const res = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({
        platform: 'apple',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: '1000000123456789',
        receipt_data: 'base64==',
        subscription: true,
      }),
    });

    expect(res.status).toBe(503);
    const body = (await res.json()) as {
      error: { kind: string; message: string; code: string; request_id: string };
    };
    expect(body.error.kind).toBe('internal_error');
    expect(body.error.code).toBe('E_IAP_VALIDATION_UNAVAILABLE');
    expect(body.error.message).toContain('apple');
    expect(body.error.message).toContain('apple_p8_file_missing');
    expect(body.error.request_id).toMatch(
      /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i,
    );
  });

  test('returns 503 instead of a simulated valid=false response when a deployed provider is unconfigured', async () => {
    // This is the result emitted by the real availability policy for a
    // staging/production process with no Apple credentials. The route must
    // stop before it can select the development-only stub validator.
    const app = createAvailabilityApp({
      apple: { available: false, reason: 'apple_not_configured' },
    });
    const token = await issueTestToken(app);
    const res = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({
        platform: 'apple',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: '1000000123456789',
        receipt_data: 'base64==',
        subscription: true,
      }),
    });

    expect(res.status).toBe(503);
    const body = (await res.json()) as {
      error: { code: string; message: string };
      valid?: boolean;
    };
    expect(body.error.code).toBe('E_IAP_VALIDATION_UNAVAILABLE');
    expect(body.error.message).toContain('apple_not_configured');
    expect(body.valid).toBeUndefined();
  });

  test('google: returns 503 + iap_validation_unavailable envelope when secrets are placeholders', async () => {
    const app = createAvailabilityApp({
      google: { available: false, reason: 'google_sa_missing_client_email' },
    });
    const token = await issueTestToken(app);
    const res = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({
        platform: 'google',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: 'tx-1',
        receipt_data: 'purchase-token',
        subscription: true,
      }),
    });

    expect(res.status).toBe(503);
    const body = (await res.json()) as {
      error: { kind: string; message: string; code: string; request_id: string };
    };
    expect(body.error.kind).toBe('internal_error');
    expect(body.error.code).toBe('E_IAP_VALIDATION_UNAVAILABLE');
    expect(body.error.message).toContain('google');
    expect(body.error.message).toContain('google_sa_missing_client_email');
  });

  test('503 does NOT fire when availability check returns ok — handler proceeds to stub', async () => {
    // Both platforms ok by default. Hitting the route should fall through to
    // the existing stub validator (200 + valid=false), proving the 503 gate
    // only fires on unavailable.
    const app = createAvailabilityApp();
    const token = await issueTestToken(app);
    const res = await app.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({
        platform: 'apple',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: '99',
        receipt_data: 'base64==',
        subscription: false,
      }),
    });

    expect(res.status).toBe(200);
    const body = (await res.json()) as { valid: boolean };
    expect(body.valid).toBe(false);
  });

  test('a simulated provider scenario cannot alter the default stub app', async () => {
    const unavailableApp = createAvailabilityApp({
      apple: { available: false, reason: 'apple_p8_file_missing' },
    });
    const unavailableToken = await issueTestToken(unavailableApp);
    const unavailable = await unavailableApp.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${unavailableToken}` },
      body: JSON.stringify({
        platform: 'apple',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: 'isolated-availability',
        receipt_data: 'base64==',
        subscription: false,
      }),
    });
    expect(unavailable.status).toBe(503);

    const defaultToken = await issueTestToken(defaultApp);
    const defaultResponse = await defaultApp.request('/iap/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${defaultToken}` },
      body: JSON.stringify({
        platform: 'apple',
        product_id: 'com.capdesis.formulae.pro_monthly',
        transaction_id: 'default-stub',
        receipt_data: 'base64==',
        subscription: false,
      }),
    });
    expect(defaultResponse.status).toBe(200);
    const defaultBody = (await defaultResponse.json()) as {
      valid: boolean;
      product_id: string;
      transaction_id: string;
      environment: string;
      provider_reason: string;
    };
    expect(defaultBody).toEqual({
      valid: false,
      product_id: 'com.capdesis.formulae.pro_monthly',
      transaction_id: 'default-stub',
      environment: 'sandbox',
      provider_reason: 'Apple IAP validator not configured on this BFF instance',
    });
  });
});
