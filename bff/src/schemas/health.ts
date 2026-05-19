import { z } from '@hono/zod-openapi';

// Data Model E9 — HealthStatus
export const HealthStatusSchema = z
  .enum(['ok', 'degraded', 'unhealthy'])
  .openapi('HealthStatus');

export type HealthStatus = z.infer<typeof HealthStatusSchema>;

// Data Model E9 — HealthResponse
export const HealthResponseSchema = z
  .object({
    status: HealthStatusSchema,
    version: z.string().openapi({
      example: '0.1.0',
      description: 'BFF build version (semver).',
    }),
    prompts_version: z.string().openapi({
      example: '1.0.0',
    }),
    uptime_seconds: z.number().nonnegative().openapi({
      description: 'Seconds since BFF process start.',
    }),
  })
  .openapi('HealthResponse');

export type HealthResponse = z.infer<typeof HealthResponseSchema>;
