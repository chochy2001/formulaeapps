import { z } from '@hono/zod-openapi';

// Data Model E1 — AuthTokenRequest
export const AuthTokenRequestSchema = z
  .object({
    client_id: z
      .string()
      .uuid()
      .openapi({
        example: '550e8400-e29b-41d4-a716-446655440000',
        description: 'Per-install client identifier, stable across launches.',
      }),
    client_proof: z
      .string()
      // Case-insensitive hex expressed in the char class (NOT the /i flag): the
      // /i flag leaks a literal "/i" into the exported OpenAPI `pattern`, an
      // invalid ECMA-262 regex. [a-fA-F0-9] keeps the constant-time compare's
      // case-insensitive acceptance while exporting a valid pattern.
      .regex(/^[a-fA-F0-9]{64}$/)
      .openapi({
        example: 'a'.repeat(64),
        description:
          'HMAC-SHA256(JWT_SHARED_SECRET, client_id || build_nonce) hex (64 chars).',
      }),
    build_nonce: z
      .string()
      .regex(/^[a-fA-F0-9]{32}$/)
      .openapi({
        example: 'b'.repeat(32),
        description: 'Per-build constant baked into the app bundle (32 hex chars).',
      }),
    platform: z.enum(['web', 'android', 'ios', 'macos']).openapi({
      example: 'web',
      description: 'Client platform identifier.',
    }),
    app_version: z
      .string()
      .regex(/^\d+\.\d+\.\d+/)
      .openapi({
        example: '3.7.2',
        description: 'Client app version (semver-ish).',
      }),
  })
  .openapi('AuthTokenRequest');

export type AuthTokenRequest = z.infer<typeof AuthTokenRequestSchema>;

// Data Model E2 — AuthTokenResponse
export const AuthTokenResponseSchema = z
  .object({
    token: z.string().openapi({
      example: 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIuLi4iLCJleHAiOjEyMzR9.sig',
      description: 'Compact JWS (HS256). 60-min max lifetime.',
    }),
    expires_at: z.string().datetime().openapi({
      example: '2026-05-18T16:00:00.000Z',
      description: 'ISO-8601 UTC token expiry.',
    }),
    refresh_after: z.string().datetime().openapi({
      example: '2026-05-18T15:50:00.000Z',
      description: 'ISO-8601 UTC hint for proactive refresh.',
    }),
    prompts_version: z.string().openapi({
      example: '1.0.0',
      description: 'Semver of system prompts in use.',
    }),
  })
  .openapi('AuthTokenResponse');

export type AuthTokenResponse = z.infer<typeof AuthTokenResponseSchema>;
