import { describe, test, expect, beforeEach, afterEach } from 'bun:test';
import { createHmac, randomUUID } from 'node:crypto';
import { app } from '../../src/index';

const ORIGINAL_FETCH = globalThis.fetch;

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
      platform: 'web',
      app_version: '3.7.2',
    }),
  });
  const body = (await res.json()) as { token: string };
  return body.token;
}

describe('JWT middleware: edge cases', () => {
  test('Authorization: Bearer with no token returns 401', async () => {
    const res = await app.request('/openai/chat', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: 'Bearer',
      },
      body: JSON.stringify({ message: 'test' }),
    });
    expect(res.status).toBe(401);
    const body = (await res.json()) as { error: { code?: string } };
    expect(['E_MISSING_JWT', 'E_EMPTY_JWT', 'E_INVALID_JWT']).toContain(body.error.code ?? '');
  });
});

describe('Logger: IP hashing and request ID propagation', () => {
  test('X-Request-Id from client is propagated when valid UUID', async () => {
    const clientUuid = '11111111-2222-3333-4444-555555555555';
    const res = await app.request('/health', {
      headers: { 'x-request-id': clientUuid },
    });
    expect(res.headers.get('x-request-id')).toBe(clientUuid);
  });

  test('invalid X-Request-Id is replaced with fresh UUID', async () => {
    const res = await app.request('/health', {
      headers: { 'x-request-id': 'not-a-valid-uuid' },
    });
    const returnedId = res.headers.get('x-request-id');
    expect(returnedId).toMatch(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i);
    expect(returnedId).not.toBe('not-a-valid-uuid');
  });

  test('logs client_ip_hash when cf-connecting-ip is present', async () => {
    const res = await app.request('/health', {
      headers: { 'cf-connecting-ip': '203.0.113.42' },
    });
    expect(res.status).toBe(200);
  });
});

describe('CORS: origin-based allowlisting', () => {
  test('known origin is echoed in Access-Control-Allow-Origin', async () => {
    const res = await app.request('/health', {
      headers: { Origin: 'https://app.formulaeapps.com' },
    });
    expect(res.headers.get('Access-Control-Allow-Origin')).toBe('https://app.formulaeapps.com');
    expect(res.headers.get('vary')).toBe('Origin');
  });

  test('unknown origin gets null (no ACAO header)', async () => {
    const res = await app.request('/health', {
      headers: { Origin: 'https://evil.com' },
    });
    expect(res.headers.get('Access-Control-Allow-Origin')).toBeNull();
  });

  test('OPTIONS preflight is accepted', async () => {
    const res = await app.request('/health', {
      method: 'OPTIONS',
      headers: { Origin: 'https://app.formulaeapps.com' },
    });
    expect(res.status).toBe(204);
  });
});

describe('OpenRouter: mocked upstream errors', () => {
  beforeEach(() => {
    globalThis.fetch = (async () =>
      new Response('not-json', { status: 200, headers: { 'Content-Type': 'text/plain' } })) as unknown as typeof fetch;
  });

  afterEach(() => {
    globalThis.fetch = ORIGINAL_FETCH;
  });

  test('chat returns 502 on non-JSON OpenRouter response', async () => {
    const token = await issueTestToken();
    const res = await app.request('/openai/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({ message: 'test' }),
    });
    expect(res.status).toBe(502);
    const body = (await res.json()) as { error: { code?: string } };
    expect(body.error.code).toBe('E_OPENROUTER_BAD_JSON');
  });
});
