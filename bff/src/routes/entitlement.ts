import { createRoute } from '@hono/zod-openapi';
import type { AppContext } from '../lib/openapi';
import { EntitlementResponseSchema } from '../schemas/entitlement';
import { ErrorEnvelopeSchema, errorEnvelope } from '../schemas/error';
import { listEntitlementsForSubject } from '../services/entitlements-store';
import { randomUUID } from 'node:crypto';

export const entitlementGetRoute = createRoute({
  method: 'get',
  path: '/entitlement',
  tags: ['entitlement'],
  summary: 'List mobile entitlements for the current JWT subject',
  description:
    'Returns channel-scoped mobile entitlements persisted after successful ' +
    'POST /iap/validate. Keyed by interim JWT sub until user accounts land. ' +
    'Never returns Polar/web scope from this store.',
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

  const rows = listEntitlementsForSubject(claims.sub);
  return c.json(
    {
      scope: 'mobile' as const,
      sources: rows.map((r) => ({
        payment_source: r.payment_source,
        product_id: r.product_id,
        granted_at: r.granted_at,
      })),
    },
    200,
  );
};
