import { createRoute } from '@hono/zod-openapi';
import type { AppContext } from '../lib/openapi';
import { ChatRequestSchema, ChatResponseSchema } from '../schemas/chat';
import { ErrorEnvelopeSchema } from '../schemas/error';
import { proxyChat } from '../services/openrouter-proxy';
import { issueToken, shouldRefresh } from '../lib/jwt';
import { randomUUID } from 'node:crypto';

// Path kept as `/openai/chat` for FE/contract backward compat; upstream is now
// OpenRouter (https://openrouter.ai), which is OpenAI-API-compatible and lets
// the FE select any provider+model in the allowlist via `model_id`.
export const chatRoute = createRoute({
  method: 'post',
  path: '/openai/chat',
  tags: ['chat'],
  summary: 'Proxy a chat completion through OpenRouter',
  description:
    'Verifies the JWT, assembles the chat request server-side (system prompts ' +
    'live in bff/src/schemas/prompts.ts), forwards to OpenRouter, returns the response. ' +
    'Routing via OpenRouter lets the FE switch models per task and adopt new ones ' +
    'without a BFF redeploy.',
  security: [{ bearerAuth: [] }],
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: ChatRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Chat completion successful',
      content: { 'application/json': { schema: ChatResponseSchema } },
      headers: {
        'X-Auth-Refresh': {
          schema: { type: 'string' },
          description: 'Optional. If present, a rotated JWT the FE should adopt.',
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

export const chatHandler = async (c: AppContext): Promise<Response> => {
  const body = (c.req as unknown as { valid: (t: 'json') => Parameters<typeof proxyChat>[0] }).valid('json');
  const result = await proxyChat(body);

  // Issue a rotated JWT in X-Auth-Refresh when the current token is past refresh_after.
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
