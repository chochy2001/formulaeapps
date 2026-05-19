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

describe('integration: POST /openai/chat (JWT-gated, mocked OpenRouter)', () => {
  beforeEach(() => {
    globalThis.fetch = (async (_url: string | URL | Request, init?: RequestInit) =>
      new Response(
        JSON.stringify({
          choices: [{ message: { role: 'assistant', content: 'E_c = (1/2) m v²' }, finish_reason: 'stop' }],
          usage: { prompt_tokens: 120, completion_tokens: 10, total_tokens: 130 },
        }),
        { status: 200, headers: { 'Content-Type': 'application/json' } },
      )) as unknown as typeof fetch;
  });

  afterEach(() => {
    globalThis.fetch = ORIGINAL_FETCH;
  });

  test('returns 401 without bearer token', async () => {
    const res = await app.request('/openai/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ message: '¿Energía cinética?' }),
    });
    expect(res.status).toBe(401);
  });

  test('returns 401 with malformed bearer token', async () => {
    const res = await app.request('/openai/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: 'Bearer not.a.jwt' },
      body: JSON.stringify({ message: '¿Energía cinética?' }),
    });
    expect(res.status).toBe(401);
  });

  test('returns 200 with valid JWT and chat completes', async () => {
    const token = await issueTestToken();
    const res = await app.request('/openai/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({ message: '¿Energía cinética?' }),
    });

    expect(res.status).toBe(200);
    const body = (await res.json()) as { message: string; model_id: string; usage: { total_tokens: number }; prompts_version: string };
    expect(body.message).toBe('E_c = (1/2) m v²');
    expect(body.model_id).toBe('openai/gpt-4o-mini');
    expect(body.usage.total_tokens).toBe(130);
    expect(body.prompts_version).toBeTypeOf('string');
  });

  test('returns 400 on empty message', async () => {
    const token = await issueTestToken();
    const res = await app.request('/openai/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({ message: '' }),
    });
    expect(res.status).toBe(400);
  });
});
