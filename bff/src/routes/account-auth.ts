import { createRoute } from '@hono/zod-openapi';
import { randomUUID } from 'node:crypto';
import type { AppContext } from '../lib/openapi';
import { isUserAccountAuthEnabled } from '../lib/feature-flags';
import { loginAccount, registerAccount } from '../services/account-auth';
import {
  AccountAuthResponseSchema,
  AccountLoginRequestSchema,
  AccountOAuthRequestSchema,
  AccountRegisterRequestSchema,
  type AccountLoginRequest,
  type AccountOAuthRequest,
  type AccountRegisterRequest,
} from '../schemas/account-auth';
import { ErrorEnvelopeSchema, errorEnvelope } from '../schemas/error';

const accountsDisabledResponse = (requestId: string) =>
  errorEnvelope(
    'forbidden',
    'User account auth is disabled (ENABLE_USER_ACCOUNT_AUTH=false)',
    requestId,
    'E_ACCOUNTS_DISABLED',
  );

const oauthNotImplementedResponse = (requestId: string) =>
  errorEnvelope(
    'internal_error',
    'OAuth providers are not configured (stub only; no token verification)',
    requestId,
    'E_OAUTH_NOT_IMPLEMENTED',
  );

export const authRegisterRoute = createRoute({
  method: 'post',
  path: '/auth/register',
  tags: ['auth'],
  summary: 'Register an email/password account',
  description:
    'Creates a users-row (argon2id password hash) and returns a JWT with ' +
    'claim user_id. Returns 403 while ENABLE_USER_ACCOUNT_AUTH is off ' +
    '(default). It never accepts an unproved device identifier or adopts ' +
    'a device entitlement. See docs/ACCOUNTS_USER_ID_PLAN.md. Polar web ' +
    'checkout is out of scope here.',
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: AccountRegisterRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Account created; JWT includes user_id',
      content: { 'application/json': { schema: AccountAuthResponseSchema } },
    },
    400: {
      description: 'Bad request (validation or email taken)',
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
  },
});

export const authLoginRoute = createRoute({
  method: 'post',
  path: '/auth/login',
  tags: ['auth'],
  summary: 'Login with email/password',
  description:
    'Verifies credentials against the users table and returns a JWT with ' +
    'claim user_id. Returns 403 while ENABLE_USER_ACCOUNT_AUTH is off ' +
    '(default); it does not accept an unproved device identifier. See ' +
    'docs/ACCOUNTS_USER_ID_PLAN.md.',
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: AccountLoginRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Login successful; JWT includes user_id',
      content: { 'application/json': { schema: AccountAuthResponseSchema } },
    },
    400: {
      description: 'Bad request',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
    401: {
      description: 'Invalid credentials',
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
  },
});

export const authOAuthRoute = createRoute({
  method: 'post',
  path: '/auth/oauth',
  tags: ['auth'],
  summary: 'OAuth Sign-In stub (Google/Apple)',
  description:
    'Reserved surface for Google/Apple Sign-In. Returns 403 while ' +
    'ENABLE_USER_ACCOUNT_AUTH is off. When the flag is on, returns 503 ' +
    'E_OAUTH_NOT_IMPLEMENTED until Jorge configures provider clients — ' +
    'the stub never verifies id_token. See docs/ACCOUNTS_USER_ID_PLAN.md.',
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: AccountOAuthRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Reserved — not returned by the stub',
      content: { 'application/json': { schema: AccountAuthResponseSchema } },
    },
    400: {
      description: 'Bad request (validation)',
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
      description: 'OAuth stub — provider verification not implemented',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
  },
});

export const authRegisterHandler = async (c: AppContext): Promise<Response> => {
  const requestId = c.get('request_id') ?? randomUUID();
  const body = (
    c.req as unknown as { valid: (t: 'json') => AccountRegisterRequest }
  ).valid('json');
  if (!isUserAccountAuthEnabled()) {
    return c.json(accountsDisabledResponse(requestId), 403);
  }
  const response = await registerAccount(body);
  return c.json(response, 200);
};

export const authLoginHandler = async (c: AppContext): Promise<Response> => {
  const requestId = c.get('request_id') ?? randomUUID();
  const body = (
    c.req as unknown as { valid: (t: 'json') => AccountLoginRequest }
  ).valid('json');
  if (!isUserAccountAuthEnabled()) {
    return c.json(accountsDisabledResponse(requestId), 403);
  }
  const response = await loginAccount(body);
  return c.json(response, 200);
};

export const authOAuthHandler = async (c: AppContext): Promise<Response> => {
  const requestId = c.get('request_id') ?? randomUUID();
  // Validate body even on the stub path so unknown providers get 400.
  (
    c.req as unknown as { valid: (t: 'json') => AccountOAuthRequest }
  ).valid('json');
  if (!isUserAccountAuthEnabled()) {
    return c.json(accountsDisabledResponse(requestId), 403);
  }
  return c.json(oauthNotImplementedResponse(requestId), 503);
};
