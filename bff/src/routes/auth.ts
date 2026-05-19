import { createRoute } from '@hono/zod-openapi';
import type { AppContext } from '../lib/openapi';
import { AuthTokenRequestSchema, AuthTokenResponseSchema } from '../schemas/auth';
import { ErrorEnvelopeSchema } from '../schemas/error';
import { issueSessionToken } from '../services/jwt-issuer';

export const authTokenRoute = createRoute({
  method: 'post',
  path: '/auth/token',
  tags: ['auth'],
  summary: 'Issue a session JWT',
  description:
    'Verifies the client_proof HMAC and issues a short-lived (≤60min) HS256 JWT. ' +
    'Called by the FE at app cold start and again when the previous token expires.',
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: AuthTokenRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Token issued',
      content: { 'application/json': { schema: AuthTokenResponseSchema } },
    },
    400: {
      description: 'Bad request',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    401: {
      description: 'Invalid client_proof',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    429: {
      description: 'Rate limited',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    500: {
      description: 'Internal error',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
  },
});

export const authTokenHandler = async (
  c: AppContext & { req: { valid: (target: 'json') => unknown } },
): Promise<Response> => {
  // Hono's typed valid('json') would be inferred via OpenAPIHono — we cast
  // here to keep this handler file isolated from the app generic.
  const body = (c.req as unknown as { valid: (t: 'json') => Parameters<typeof issueSessionToken>[0] }).valid('json');
  const response = await issueSessionToken(body);
  return c.json(response, 200);
};
