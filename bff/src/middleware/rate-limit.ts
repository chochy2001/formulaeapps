import type { Next } from 'hono';
import { createHash } from 'node:crypto';
import type { AppContext, AppMiddleware } from '../lib/openapi';
import { errorEnvelope } from '../schemas/error';

/**
 * Lightweight in-process fixed-window rate limiter — defense-in-depth UNDER the
 * Traefik `api-ratelimit@file` edge middleware, not a replacement for it.
 *
 * Rationale (audit P2): the BFF's only auth gate (forgeable HS256 JWT minted via
 * a client-shared secret) means per-IP throttling at the app layer is a cheap
 * extra brake on cost-DoS of the paid OpenRouter proxy and on brute/replay of
 * /auth/token, in case the edge limiter is mis-tuned or drifts.
 *
 * Notes / limits:
 *  - State is in-memory: it resets on restart and does NOT coordinate across
 *    replicas. That is acceptable for the current single-container deploy; if
 *    the BFF is ever scaled out, move this to a shared store (Redis) or rely on
 *    the edge limiter for global guarantees.
 *  - Keys are derived from the forwarded client IP (cf-connecting-ip /
 *    x-forwarded-for first hop), matching the logger's IP extraction. Behind
 *    Cloudflare+Traefik the BFF would otherwise see only the proxy socket IP,
 *    so every user would collapse into one bucket.
 *  - A tripped limit returns a real 429 ErrorEnvelope (kind `rate_limited`) with
 *    a `Retry-After` header — the contract already declares 429 on these routes.
 */

type Bucket = { count: number; resetAt: number };

export type RateLimiterOptions = {
  /** Window length in seconds. */
  windowSeconds: number;
  /** Max requests permitted per key per window. `0` disables the limiter. */
  max: number;
  /** Label used to namespace buckets and surface in the error code. */
  name: string;
  /**
   * Derive the limiter key from the request context. Defaults to the forwarded
   * client IP. Override to add a secondary dimension (e.g. a hashed proof) so a
   * single captured credential cannot be replayed at high volume from one IP.
   */
  keyFn?: (c: AppContext) => string;
};

/** Extract the forwarded client IP, mirroring middleware/logger.ts. */
export function clientIpFromContext(c: AppContext): string {
  return (
    c.req.header('cf-connecting-ip') ??
    c.req.header('x-forwarded-for')?.split(',')[0]?.trim() ??
    // No forwarded header (direct/local call): fall back to a constant bucket.
    'unknown'
  );
}

/** Short stable hash so secrets/long values never become Map keys verbatim. */
export function shortHash(value: string): string {
  return createHash('sha256').update(value).digest('hex').slice(0, 16);
}

/**
 * Create a rate-limit middleware plus its backing store. The store is exposed
 * only so tests can reset it deterministically between cases.
 */
export function createRateLimiter(opts: RateLimiterOptions): {
  middleware: AppMiddleware;
  reset: () => void;
} {
  const buckets = new Map<string, Bucket>();
  const windowMs = opts.windowSeconds * 1000;
  const keyFn = opts.keyFn ?? ((c) => clientIpFromContext(c));

  // Periodic sweep so the Map cannot grow unbounded from one-off IPs. Unref the
  // timer so it never keeps the process (or a test runner) alive.
  const sweep = setInterval(() => {
    const now = Date.now();
    for (const [k, b] of buckets) {
      if (b.resetAt <= now) buckets.delete(k);
    }
  }, Math.max(windowMs, 30_000));
  if (typeof sweep === 'object' && typeof sweep.unref === 'function') sweep.unref();

  const middleware: AppMiddleware = async (c: AppContext, next: Next): Promise<void | Response> => {
    // Disabled limiter: pass through unchanged.
    if (opts.max <= 0) {
      await next();
      return;
    }

    const now = Date.now();
    const key = `${opts.name}:${keyFn(c)}`;
    const existing = buckets.get(key);

    if (!existing || existing.resetAt <= now) {
      buckets.set(key, { count: 1, resetAt: now + windowMs });
      await next();
      return;
    }

    if (existing.count >= opts.max) {
      const retryAfter = Math.max(1, Math.ceil((existing.resetAt - now) / 1000));
      const requestId = c.get('request_id') ?? 'unknown';
      c.header('Retry-After', String(retryAfter));
      return c.json(
        errorEnvelope(
          'rate_limited',
          'Too many requests. Retry after the indicated delay.',
          requestId,
          `E_RATE_LIMITED_${opts.name.toUpperCase()}`,
        ),
        429,
      );
    }

    existing.count += 1;
    await next();
  };

  return { middleware, reset: (): void => buckets.clear() };
}
