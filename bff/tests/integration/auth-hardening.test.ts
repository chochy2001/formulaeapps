import { describe, test, expect, beforeEach } from 'bun:test';
import { createHmac, randomUUID } from 'node:crypto';
import { app } from '../../src/index';
import { __resetReplayWindow } from '../../src/services/jwt-issuer';

// Regression tests for the /auth/token hardening (audit P2 + P3):
//  - constant-time client_proof comparison still accepts valid / rejects invalid
//  - the replay throttle bounds high-volume reuse of one captured proof
//
// The route-level per-IP rate limiter is disabled in tests/setup.ts to keep the
// shared-app suites isolated; the replay throttle lives in the issuer and is
// always active, so it is exercised directly here.

function makeProof(clientId: string, buildNonce: string): string {
  return createHmac('sha256', process.env['JWT_SHARED_SECRET']!)
    .update(clientId + buildNonce)
    .digest('hex');
}

async function postToken(body: Record<string, unknown>): Promise<Response> {
  return app.request('/auth/token', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });
}

describe('integration: /auth/token hardening', () => {
  beforeEach(() => {
    __resetReplayWindow();
  });

  test('accepts an uppercase-hex client_proof (constant-time compare is case-insensitive)', async () => {
    const clientId = randomUUID();
    const buildNonce = 'b'.repeat(32);
    const proof = makeProof(clientId, buildNonce).toUpperCase();

    const res = await postToken({
      client_id: clientId,
      client_proof: proof,
      build_nonce: buildNonce,
      platform: 'web',
      app_version: '3.7.2',
    });
    expect(res.status).toBe(200);
  });

  test('rejects a proof that differs only in the last character (timingSafeEqual)', async () => {
    const clientId = randomUUID();
    const buildNonce = 'b'.repeat(32);
    const valid = makeProof(clientId, buildNonce);
    // Flip the final hex nibble so length is identical but the value differs.
    const lastChar = valid.slice(-1);
    const flipped = lastChar === 'a' ? 'b' : 'a';
    const tampered = valid.slice(0, -1) + flipped;

    const res = await postToken({
      client_id: clientId,
      client_proof: tampered,
      build_nonce: buildNonce,
      platform: 'web',
      app_version: '3.7.2',
    });
    expect(res.status).toBe(401);
    const body = (await res.json()) as { error: { code?: string } };
    expect(body.error.code).toBe('E_INVALID_PROOF');
  });

  test('throttles high-volume replay of the same valid proof with 429 E_PROOF_REPLAY', async () => {
    const clientId = randomUUID();
    const buildNonce = 'b'.repeat(32);
    const proof = makeProof(clientId, buildNonce);
    const body = {
      client_id: clientId,
      client_proof: proof,
      build_nonce: buildNonce,
      platform: 'web' as const,
      app_version: '3.7.2',
    };

    // REPLAY_MAX_PER_WINDOW = 5 accepts before the throttle trips.
    for (let i = 0; i < 5; i++) {
      const res = await postToken(body);
      expect(res.status).toBe(200);
    }

    const sixth = await postToken(body);
    expect(sixth.status).toBe(429);
    const errBody = (await sixth.json()) as { error: { kind: string; code?: string } };
    expect(errBody.error.kind).toBe('rate_limited');
    expect(errBody.error.code).toBe('E_PROOF_REPLAY');
  });

  test('replay throttle is per-proof: a different install is unaffected', async () => {
    const buildNonce = 'b'.repeat(32);

    // Exhaust install A's window.
    const idA = randomUUID();
    const proofA = makeProof(idA, buildNonce);
    const bodyA = {
      client_id: idA,
      client_proof: proofA,
      build_nonce: buildNonce,
      platform: 'web' as const,
      app_version: '3.7.2',
    };
    for (let i = 0; i < 5; i++) await postToken(bodyA);
    expect((await postToken(bodyA)).status).toBe(429);

    // Install B mints fine.
    const idB = randomUUID();
    const proofB = makeProof(idB, buildNonce);
    const resB = await postToken({
      client_id: idB,
      client_proof: proofB,
      build_nonce: buildNonce,
      platform: 'web',
      app_version: '3.7.2',
    });
    expect(resB.status).toBe(200);
  });
});
