import { createRoute } from '@hono/zod-openapi';
import { env } from '../lib/env';
import type { AppContext } from '../lib/openapi';
import { HealthResponseSchema } from '../schemas/health';
import { PROMPTS_VERSION } from '../schemas/prompts';

const PROCESS_START_MS = Date.now();

export const healthRoute = createRoute({
  method: 'get',
  path: '/health',
  tags: ['health'],
  summary: 'Liveness and version probe',
  description:
    'Used by Docker compose healthcheck (every 30s) and the infra validator. No auth required.',
  responses: {
    200: {
      description: 'Healthy',
      content: { 'application/json': { schema: HealthResponseSchema } },
    },
  },
});

export const healthHandler = (c: AppContext): Response => {
  const uptime_seconds = (Date.now() - PROCESS_START_MS) / 1000;
  return c.json(
    {
      status: 'ok' as const,
      version: env.BFF_VERSION,
      prompts_version: PROMPTS_VERSION,
      uptime_seconds,
    },
    200,
  );
};
