import { createRoute } from '@hono/zod-openapi';
import type { AppContext } from '../lib/openapi';
import { IapValidateRequestSchema, IapValidateResponseSchema } from '../schemas/iap';
import { ErrorEnvelopeSchema } from '../schemas/error';
import { createAppleIapValidator } from '../services/apple-iap';
import { createGoogleIapValidator } from '../services/google-iap';
import { issueToken, shouldRefresh } from '../lib/jwt';
import { randomUUID } from 'node:crypto';

export const iapValidateRoute = createRoute({
  method: 'post',
  path: '/iap/validate',
  tags: ['iap'],
  summary: 'Validate an Apple or Google IAP receipt server-side',
  description:
    'Uses the official Apple/Google SDKs with secrets mounted at runtime. ' +
    'Returns a normalized result without leaking the raw provider response.',
  security: [{ bearerAuth: [] }],
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: IapValidateRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Validation completed',
      content: { 'application/json': { schema: IapValidateResponseSchema } },
      headers: {
        'X-Auth-Refresh': {
          schema: { type: 'string' },
          description: 'Optional rotated JWT.',
        },
      },
    },
    400: { description: 'Bad request', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    401: { description: 'Unauthorized', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    429: { description: 'Rate limited', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    502: { description: 'Upstream error', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    500: { description: 'Internal error', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
  },
});

export const iapValidateHandler = async (c: AppContext): Promise<Response> => {
  const body = (c.req as unknown as { valid: (t: 'json') => { platform: 'apple' | 'google'; product_id: string; transaction_id: string; receipt_data: string; subscription: boolean } }).valid('json');

  const validator =
    body.platform === 'apple'
      ? await createAppleIapValidator()
      : await createGoogleIapValidator();

  const result = await validator.validate(body);

  // Rotate JWT if close to expiry.
  const claims = c.get('jwt_claims');
  if (claims && shouldRefresh(claims)) {
    const { token } = await issueToken({
      sub: claims.sub,
      aud: claims.aud,
      platform: claims.platform,
      app_version: claims.app_version,
      jti: randomUUID(),
    });
    c.header('X-Auth-Refresh', token);
  }

  return c.json(result, 200);
};
