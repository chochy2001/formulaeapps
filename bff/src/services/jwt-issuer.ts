import { createHmac, randomUUID, timingSafeEqual } from 'node:crypto';
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
 *
 * The comparison is constant-time (crypto.timingSafeEqual) so the proof cannot
 * be recovered byte-by-byte via response-timing analysis. Both sides are
 * lowercase 64-char hex (the request shape is enforced by zod
 * `/^[a-f0-9]{64}$/i`), so the buffers are guaranteed equal length and
 * timingSafeEqual never throws.
 */
function verifyClientProof(req: AuthTokenRequest): boolean {
  const expected = createHmac('sha256', env.JWT_SHARED_SECRET)
    .update(req.client_id + req.build_nonce)
    .digest('hex');

  const expectedBuf = Buffer.from(expected.toLowerCase(), 'utf8');
  const providedBuf = Buffer.from(req.client_proof.toLowerCase(), 'utf8');

  // timingSafeEqual requires equal-length buffers; bail in constant-ish time
  // on a length mismatch (only possible if the zod regex is ever relaxed).
  if (expectedBuf.length !== providedBuf.length) return false;

  return timingSafeEqual(expectedBuf, providedBuf);
}

// ──────────────────────── replay throttle (audit P3) ────────────────────────
//
// client_proof is deterministic for a given (client_id, build_nonce), so the
// request contract carries no nonce/timestamp we can use for classic replay
// rejection without breaking every deployed client (FormulaeCommunity + Pro
// compute exactly HMAC(client_id + build_nonce); changing that 401s all live
// installs, which ship manually via Play Store with no CD). Instead we bound
// how often the SAME proof may mint a fresh token in a short window: a captured
// proof replayed at volume trips the guard, while a legitimate install — which
// re-mints at most ~once per ~55 min — never approaches it. In-memory only;
// resets on restart and is per-replica (acceptable for the single-container
// deploy). Set REPLAY_WINDOW_SECONDS/REPLAY_MAX_PER_WINDOW via constants below.

const REPLAY_WINDOW_SECONDS = 60;
const REPLAY_MAX_PER_WINDOW = 5;

type ReplayBucket = { count: number; resetAt: number };
const replayBuckets = new Map<string, ReplayBucket>();

const replaySweep = setInterval(() => {
  const now = Date.now();
  for (const [k, b] of replayBuckets) {
    if (b.resetAt <= now) replayBuckets.delete(k);
  }
}, REPLAY_WINDOW_SECONDS * 1000);
if (typeof replaySweep === 'object' && typeof replaySweep.unref === 'function') {
  replaySweep.unref();
}

/**
 * Returns false when the same client_proof has already been accepted
 * REPLAY_MAX_PER_WINDOW times within REPLAY_WINDOW_SECONDS — i.e. a high-volume
 * replay of one captured proof. The key is a truncated SHA-256 of the proof so
 * the raw value never lands in a Map key. Exported for tests via __resetReplay.
 */
function checkReplay(clientProof: string): boolean {
  const key = createHmac('sha256', env.JWT_SHARED_SECRET)
    .update(`replay:${clientProof.toLowerCase()}`)
    .digest('hex')
    .slice(0, 24);
  const now = Date.now();
  const existing = replayBuckets.get(key);
  if (!existing || existing.resetAt <= now) {
    replayBuckets.set(key, { count: 1, resetAt: now + REPLAY_WINDOW_SECONDS * 1000 });
    return true;
  }
  if (existing.count >= REPLAY_MAX_PER_WINDOW) return false;
  existing.count += 1;
  return true;
}

/** Test-only: clear the replay window between cases. */
export function __resetReplayWindow(): void {
  replayBuckets.clear();
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

  // Replay throttle runs only after a valid proof so it cannot be used to probe
  // proof validity. Bounds high-volume replay of one captured proof.
  if (!checkReplay(req.client_proof)) {
    throw new BffError(
      'rate_limited',
      'Too many token requests for this client. Retry shortly.',
      'E_PROOF_REPLAY',
    );
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
