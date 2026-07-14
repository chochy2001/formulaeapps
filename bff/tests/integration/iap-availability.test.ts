import { describe, test, expect, mock, beforeAll, afterAll } from 'bun:test';
import { createHmac, randomUUID } from 'node:crypto';

// Mock the iap-availability module BEFORE importing `app` so the route's
// `checkIapAvailability` reference points at our stub for every request in
// this file. We toggle the platform-specific result via a closure so each
// test case can flip apple/google independently without re-importing.
//
// This is the canonical way to simulate the production "placeholder secrets
// landed but real ones haven't been scp'd yet" state in unit-tests, without
// reaching for env tricks that wouldn't take effect after env.ts has frozen
// its snapshot at module-load time.
type AvailabilityResult =
  | { available: true }
  | { available: false; reason: string };

const overrides: { apple: AvailabilityResult; google: AvailabilityResult } = {
  apple: { available: true },
  google: { available: true },
};

mock.module('../../src/services/iap-availability', () => ({
  checkIapAvailability: async (platform: 'apple' | 'google'): Promise<AvailabilityResult> =>
    overrides[platform],
  formatAvailability: (r: AvailabilityResult): string =>
    r.available ? 'ok' : `missing(${r.reason})`,
}));

// Defer this import so the mock is in place before src/index resolves
// src/routes/iap which imports src/services/iap-availability.
const { app } = await import('../../src/index');

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

describe('integration: POST /iap/validate — placeholder-secret 503 envelope', () => {
  beforeAll(() => {
    // Default to "available" so unrelated assertions don't accidentally hit
    // the 503 branch. Each test flips its target platform to unavailable.
    overrides.apple = { available: true };
    overrides.google = { available: true };
  });

  afterAll(() => {
    overrides.apple = { available: true };
    overrides.google = { available: true };
    mock.restore();
  });

  test('apple: returns 503 + iap_validation_unavailable envelope when secrets are placeholders', async () => {
    overrides.apple = { available: false, reason: 'apple_p8_file_missing' };
    const token = await issueTestToken();
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

    overrides.apple = { available: true };
  });

  test('returns 503 instead of a simulated valid=false response when a deployed provider is unconfigured', async () => {
    // This is the result emitted by the real availability policy for a
    // staging/production process with no Apple credentials. The route must
    // stop before it can select the development-only stub validator.
    overrides.apple = { available: false, reason: 'apple_not_configured' };
    const token = await issueTestToken();
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

    overrides.apple = { available: true };
  });

  test('google: returns 503 + iap_validation_unavailable envelope when secrets are placeholders', async () => {
    overrides.google = { available: false, reason: 'google_sa_missing_client_email' };
    const token = await issueTestToken();
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

    overrides.google = { available: true };
  });

  test('503 does NOT fire when availability check returns ok — handler proceeds to stub', async () => {
    // Both platforms ok by default. Hitting the route should fall through to
    // the existing stub validator (200 + valid=false), proving the 503 gate
    // only fires on unavailable.
    overrides.apple = { available: true };
    const token = await issueTestToken();
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
});
