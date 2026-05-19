import { createHmac, randomUUID } from 'node:crypto';
import { env } from '../lib/env';
import { issueToken, type SessionClaims } from '../lib/jwt';
import { BffError } from '../middleware/error';
import { PROMPTS_VERSION } from '../schemas/prompts';
import type { AuthTokenRequest, AuthTokenResponse } from '../schemas/auth';

/**
 * Verify the client_proof HMAC matches `HMAC-SHA256(JWT_SHARED_SECRET, client_id || build_nonce)`.
 * This is a deterrent against trivial replay from external clients — not a
 * strong identity proof. Real device attestation is a future hardening step
 * (research §R4 alternatives — App Attest / Play Integrity).
 */
function verifyClientProof(req: AuthTokenRequest): boolean {
  const expected = createHmac('sha256', env.JWT_SHARED_SECRET)
    .update(req.client_id + req.build_nonce)
    .digest('hex');

  // Length must match before constant-time compare
  if (expected.length !== req.client_proof.length) return false;

  // Constant-time-ish compare: case-insensitive hex compare via lowercase
  return expected.toLowerCase() === req.client_proof.toLowerCase();
}

/**
 * Hash the raw client_id to produce the JWT `sub` claim. Never echoes the raw
 * client_id back in tokens / logs.
 */
function hashClientId(clientId: string): string {
  const buf = createHmac('sha256', env.JWT_SHARED_SECRET).update(clientId).digest('hex');
  return buf.slice(0, 16);
}

function audForPlatform(platform: SessionClaims['platform']): SessionClaims['aud'] {
  // For now, all Pro flavors route to formulaeapps-pro; community apps will
  // route to formulaeapps-community once they identify themselves via a
  // future request field. Today the BFF treats every authenticated client
  // as Pro.
  return 'formulaeapps-pro';
}

export async function issueSessionToken(req: AuthTokenRequest): Promise<AuthTokenResponse> {
  if (!verifyClientProof(req)) {
    throw new BffError('unauthorized', 'Invalid client_proof for auth token request', 'E_INVALID_PROOF');
  }

  const jti = randomUUID();
  const sub = hashClientId(req.client_id);
  const aud = audForPlatform(req.platform);

  const { token, exp, refresh_after } = await issueToken({
    sub,
    aud,
    platform: req.platform,
    app_version: req.app_version,
    jti,
  });

  return {
    token,
    expires_at: new Date(exp * 1000).toISOString(),
    refresh_after: new Date(refresh_after * 1000).toISOString(),
    prompts_version: PROMPTS_VERSION,
  };
}
