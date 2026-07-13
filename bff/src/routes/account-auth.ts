import { createRoute } from '@hono/zod-openapi';
import { randomUUID } from 'node:crypto';
import type { AppContext } from '../lib/openapi';
import { isUserAccountAuthEnabled } from '../lib/feature-flags';
import {
  AccountAuthResponseSchema,
  AccountLoginRequestSchema,
  AccountRegisterRequestSchema,
} from '../schemas/account-auth';
import { ErrorEnvelopeSchema, errorEnvelope } from '../schemas/error';

const accountsDisabledResponse = (requestId: string) =>
  errorEnvelope(
    'forbidden',
    'User account auth is disabled (ENABLE_USER_ACCOUNT_AUTH=false)',
    requestId,
    'E_ACCOUNTS_DISABLED',
  );

const accountsStubResponse = (requestId: string) =>
  errorEnvelope(
    'internal_error',
    'User account auth stub — register/login not implemented yet',
    requestId,
    'E_ACCOUNTS_STUB',
  );

export const authRegisterRoute = createRoute({
  method: 'post',
  path: '/auth/register',
  tags: ['auth'],
  summary: 'Register an email/password account (stub)',
  description:
    'Design stub for WP5 step 2 / fleet #86. Returns 403 while ' +
    'ENABLE_USER_ACCOUNT_AUTH is off (default). When the flag is on, still ' +
    'returns 503 until users table + password hashing land. See ' +
    'docs/ACCOUNTS_USER_ID_PLAN.md. Polar web checkout is out of scope here.',
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: AccountRegisterRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Account created (not yet implemented)',
      content: { 'application/json': { schema: AccountAuthResponseSchema } },
    },
    400: {
      description: 'Bad request',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    403: {
      description: 'Account auth flag off',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    429: {
      description: 'Rate limited',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    503: {
      description: 'Stub — not implemented yet',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
  },
});

export const authLoginRoute = createRoute({
  method: 'post',
  path: '/auth/login',
  tags: ['auth'],
  summary: 'Login with email/password (stub)',
  description:
    'Design stub for WP5 step 2 / fleet #86. Returns 403 while ' +
    'ENABLE_USER_ACCOUNT_AUTH is off (default). When the flag is on, still ' +
    'returns 503 until credential verification lands. See ' +
    'docs/ACCOUNTS_USER_ID_PLAN.md.',
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: AccountLoginRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Login successful (not yet implemented)',
      content: { 'application/json': { schema: AccountAuthResponseSchema } },
    },
    400: {
      description: 'Bad request',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    403: {
      description: 'Account auth flag off',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    429: {
      description: 'Rate limited',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    503: {
      description: 'Stub — not implemented yet',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
  },
});

export const authRegisterHandler = async (c: AppContext): Promise<Response> => {
  const requestId = c.get('request_id') ?? randomUUID();
  // Validate body so OpenAPI/Zod still runs even while stubbed.
  (c.req as unknown as { valid: (t: 'json') => unknown }).valid('json');
  if (!isUserAccountAuthEnabled()) {
    return c.json(accountsDisabledResponse(requestId), 403);
  }
  return c.json(accountsStubResponse(requestId), 503);
};

export const authLoginHandler = async (c: AppContext): Promise<Response> => {
  const requestId = c.get('request_id') ?? randomUUID();
  (c.req as unknown as { valid: (t: 'json') => unknown }).valid('json');
  if (!isUserAccountAuthEnabled()) {
    return c.json(accountsDisabledResponse(requestId), 403);
  }
  return c.json(accountsStubResponse(requestId), 503);
};
