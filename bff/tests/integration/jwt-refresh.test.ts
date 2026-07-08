import { describe, test, expect, beforeEach, afterEach } from 'bun:test';
import { createHmac, randomUUID } from 'node:crypto';
import { SignJWT } from 'jose';
import { resolveSigningSecret } from '../../src/lib/jwt';

const ORIGINAL_FETCH = globalThis.fetch;

function makeProof(clientId: string, buildNonce: string): string {
  return createHmac('sha256', process.env['JWT_SHARED_SECRET']!)
    .update(clientId + buildNonce)
    .digest('hex');
}

const SECRET = resolveSigningSecret({
  JWT_SHARED_SECRET: process.env['JWT_SHARED_SECRET'] ?? 'test-secret-' + 'a'.repeat(48),
});
const enc = (s: string): Uint8Array => new TextEncoder().encode(s);

async function issueNearExpiryToken(): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  return await new SignJWT({
    sub: 'hashed-client-id',
    aud: 'formulaeapps-pro',
    jti: randomUUID(),
    platform: 'web',
    app_version: '3.7.2',
    iat: now - 3300,
    exp: now + 60,
  })
    .setProtectedHeader({ alg: 'HS256' })
    .setIssuer('api.formulaeapps.com')
    .sign(enc(SECRET));
}

async function issueFreshToken(): Promise<string> {
  const clientId = randomUUID();
  const buildNonce = 'b'.repeat(32);
  const proof = makeProof(clientId, buildNonce);
  const { app } = await import('../../src/index');
  const res = await app.request('/auth/token', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      client_id: clientId,
      client_proof: proof,
      build_nonce: buildNonce,
      platform: 'web',
      app_version: '3.7.2',
    }),
  });
  const body = (await res.json()) as { token: string };
  return body.token;
}

describe('JWT refresh: X-Auth-Refresh in chat handler', () => {
  beforeEach(() => {
    globalThis.fetch = (async (_url: string | URL | Request, _init?: RequestInit) =>
      new Response(
        JSON.stringify({
          choices: [{ message: { role: 'assistant', content: 'E = mc²' }, finish_reason: 'stop' }],
          usage: { prompt_tokens: 10, completion_tokens: 5, total_tokens: 15 },
        }),
        { status: 200, headers: { 'Content-Type': 'application/json' } },
      )) as unknown as typeof fetch;
  });

  afterEach(() => {
    globalThis.fetch = ORIGINAL_FETCH;
  });

  test('chat with near-expiry token receives X-Auth-Refresh header', async () => {
    const { app } = await import('../../src/index');
    const token = await issueNearExpiryToken();
    const res = await app.request('/openai/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({ message: '¿Fórmula de la relatividad?' }),
    });

    expect(res.status).toBe(200);
    const refreshHeader = res.headers.get('X-Auth-Refresh');
    expect(refreshHeader).toBeTruthy();
    expect(refreshHeader!.split('.').length).toBe(3);
  });
});

describe('JWT refresh: X-Auth-Refresh in IAP handler', () => {
  beforeEach(() => {
    globalThis.fetch = (async (_url: string | URL | Request, _init?: RequestInit) =>
      new Response(JSON.stringify({}), { status: 200, headers: { 'Content-Type': 'application/json' } })) as unknown as typeof fetch;
  });

  afterEach(() => {
    globalThis.fetch = ORIGINAL_FETCH;
  });

  test('IAP validate with near-expiry token receives X-Auth-Refresh header', async () => {
    const { app } = await import('../../src/index');
    const token = await issueNearExpiryToken();
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

    expect(res.status).toBe(200);
    const refreshHeader = res.headers.get('X-Auth-Refresh');
    expect(refreshHeader).toBeTruthy();
    expect(refreshHeader!.split('.').length).toBe(3);
  });
});
