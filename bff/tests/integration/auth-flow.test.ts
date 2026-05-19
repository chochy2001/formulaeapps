import { describe, test, expect } from 'bun:test';
import { createHmac, randomUUID } from 'node:crypto';
import { app } from '../../src/index';

function makeProof(clientId: string, buildNonce: string): string {
  return createHmac('sha256', process.env['JWT_SHARED_SECRET']!)
    .update(clientId + buildNonce)
    .digest('hex');
}

describe('integration: POST /auth/token', () => {
  test('issues token with valid client_proof', async () => {
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

    expect(res.status).toBe(200);
    const body = (await res.json()) as { token: string; expires_at: string; refresh_after: string; prompts_version: string };
    expect(body.token).toBeTypeOf('string');
    expect(body.token.split('.').length).toBe(3);
    expect(new Date(body.expires_at).getTime()).toBeGreaterThan(Date.now());
    expect(new Date(body.refresh_after).getTime()).toBeLessThan(new Date(body.expires_at).getTime());
    expect(body.prompts_version).toBeTypeOf('string');
  });

  test('returns 401 with E_INVALID_PROOF on bad client_proof', async () => {
    const res = await app.request('/auth/token', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        client_id: randomUUID(),
        client_proof: 'f'.repeat(64), // valid format but wrong HMAC
        build_nonce: 'a'.repeat(32),
        platform: 'web',
        app_version: '3.7.2',
      }),
    });

    expect(res.status).toBe(401);
    const body = (await res.json()) as { error: { kind: string; code?: string } };
    expect(body.error.kind).toBe('unauthorized');
    expect(body.error.code).toBe('E_INVALID_PROOF');
  });

  test('returns 400 on malformed request body', async () => {
    const res = await app.request('/auth/token', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        client_id: 'not-a-uuid',
        client_proof: 'short',
        build_nonce: 'short',
        platform: 'invalid',
        app_version: 'nope',
      }),
    });
    expect(res.status).toBe(400);
  });
});
