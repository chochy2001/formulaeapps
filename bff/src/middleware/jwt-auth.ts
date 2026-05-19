import type { Next } from 'hono';
import { verifyToken } from '../lib/jwt';
import type { AppContext } from '../lib/openapi';
import { errorEnvelope } from '../schemas/error';

const BEARER_PREFIX = 'Bearer ';

/**
 * Hono middleware verifying the Authorization: Bearer <jwt> header. On
 * success the claims are attached to context.jwt_claims; on failure a 401
 * ErrorEnvelope is returned.
 *
 * Spec §FR-022.
 */
export async function jwtAuthMiddleware(c: AppContext, next: Next): Promise<void | Response> {
  const requestId = c.get('request_id');
  const header = c.req.header('authorization') ?? c.req.header('Authorization');

  if (!header || !header.startsWith(BEARER_PREFIX)) {
    return c.json(
      errorEnvelope('unauthorized', 'Missing Authorization Bearer token', requestId, 'E_MISSING_JWT'),
      401,
    );
  }

  const token = header.slice(BEARER_PREFIX.length).trim();
  if (token.length === 0) {
    return c.json(
      errorEnvelope('unauthorized', 'Empty bearer token', requestId, 'E_EMPTY_JWT'),
      401,
    );
  }

  try {
    const claims = await verifyToken(token);
    c.set('jwt_claims', claims);
    await next();
  } catch (err) {
    const message = err instanceof Error ? err.message : 'JWT verification failed';
    return c.json(
      errorEnvelope('unauthorized', `Invalid JWT: ${message}`, requestId, 'E_INVALID_JWT'),
      401,
    );
  }
}
