import { env } from '../lib/env';
import type { AppContext } from '../lib/openapi';
import { createRateLimiter, clientIpFromContext, shortHash } from './rate-limit';

/**
 * Configured per-route rate limiters (audit P2). Constructed once at module
 * load and shared for the process lifetime.
 *
 * The limiters run before the route handlers, so the request body is not yet
 * parsed — `/auth/token` is keyed on the forwarded client IP only. The
 * per-proof replay throttle (audit P3) lives in services/jwt-issuer.ts, where
 * the validated client_proof is available.
 */

export const authRateLimiter = createRateLimiter({
  name: 'auth',
  windowSeconds: env.RATE_LIMIT_WINDOW_SECONDS,
  max: env.RATE_LIMIT_AUTH_MAX,
  keyFn: (c: AppContext): string => clientIpFromContext(c),
});

export const chatRateLimiter = createRateLimiter({
  name: 'chat',
  windowSeconds: env.RATE_LIMIT_WINDOW_SECONDS,
  max: env.RATE_LIMIT_CHAT_MAX,
  // Key chat on IP + authenticated sub (when present) so a shared-NAT IP isn't
  // unfairly throttled by one heavy user, and one rotated identity still counts
  // against its own budget.
  keyFn: (c: AppContext): string => {
    const ip = clientIpFromContext(c);
    const sub = c.get('jwt_claims')?.sub;
    return sub ? `${ip}|${shortHash(sub)}` : ip;
  },
});
