import { createRoute } from '@hono/zod-openapi';
import type { AppContext } from '../lib/openapi';
import { EntitlementResponseSchema } from '../schemas/entitlement';
import { ErrorEnvelopeSchema, errorEnvelope } from '../schemas/error';
import { readMobileEntitlement } from '../services/entitlement-check';
import { randomUUID } from 'node:crypto';

export const entitlementGetRoute = createRoute({
  method: 'get',
  path: '/entitlement',
  tags: ['entitlement'],
  summary: 'List mobile entitlements for the current JWT subject',
  description:
    'Returns channel-scoped mobile entitlements persisted after successful ' +
    'POST /iap/validate. Account JWTs can additionally read rows belonging to ' +
    'their own user_id; register/login never adopts a device row. Never returns ' +
    'Polar/web scope from this store.',
  security: [{ bearerAuth: [] }],
  responses: {
    200: {
      description: 'Mobile entitlements for the subject',
      content: { 'application/json': { schema: EntitlementResponseSchema } },
    },
    401: {
      description: 'Unauthorized',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
  },
});

export const entitlementGetHandler = (c: AppContext): Response => {
  const claims = c.get('jwt_claims');
  if (!claims?.sub) {
    const requestId = c.get('request_id') ?? randomUUID();
    return c.json(errorEnvelope('unauthorized', 'Missing JWT subject', requestId), 401);
  }

  // Fail-closed reader: store errors → empty sources (not entitled).
  // When account auth is on and JWT carries user_id, prefer account-keyed rows.
  const view = readMobileEntitlement(claims.sub, claims.user_id);
  return c.json(
    {
      scope: view.scope,
      sources: view.sources,
    },
    200,
  );
};
