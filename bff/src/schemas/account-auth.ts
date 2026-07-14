import { z } from '@hono/zod-openapi';

/**
 * Email/password account auth (fleet #86 / WP5 step 2b).
 * Handlers return 403 while ENABLE_USER_ACCOUNT_AUTH is off (default).
 * See docs/ACCOUNTS_USER_ID_PLAN.md.
 */

const optionalPlatform = z
  .enum(['web', 'android', 'ios', 'macos'])
  .optional()
  .openapi({
    example: 'web',
    description: 'Client platform for the issued session JWT (default: web).',
  });

const optionalAppVersion = z
  .string()
  .regex(/^\d+\.\d+\.\d+/)
  .optional()
  .openapi({
    example: '3.7.2',
    description: 'Client app version for the session JWT (default: 0.0.0).',
  });

const optionalClientId = z
  .string()
  .uuid()
  .optional()
  .openapi({
    example: '550e8400-e29b-41d4-a716-446655440000',
    description:
      'Optional device client_id — when present, prior mobile entitlements for ' +
      'that device subject are bound to the new user_id.',
  });

export const AccountRegisterRequestSchema = z
  .object({
    email: z.string().email().openapi({
      example: 'user@example.com',
      description: 'Account email (unique).',
    }),
    password: z.string().min(8).max(128).openapi({
      example: 'correct-horse-battery',
      description: 'Password (min 8 chars). Never logged.',
    }),
    platform: optionalPlatform,
    app_version: optionalAppVersion,
    client_id: optionalClientId,
  })
  .openapi('AccountRegisterRequest');

export type AccountRegisterRequest = z.infer<typeof AccountRegisterRequestSchema>;

export const AccountLoginRequestSchema = z
  .object({
    email: z.string().email().openapi({
      example: 'user@example.com',
    }),
    password: z.string().min(1).max(128).openapi({
      example: 'correct-horse-battery',
      description: 'Password. Never logged.',
    }),
    platform: optionalPlatform,
    app_version: optionalAppVersion,
    client_id: optionalClientId,
  })
  .openapi('AccountLoginRequest');

export type AccountLoginRequest = z.infer<typeof AccountLoginRequestSchema>;

/** Success shape: session JWT + stable account user_id. */
export const AccountAuthResponseSchema = z
  .object({
    token: z.string().openapi({
      example: 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VyLi4uIn0.sig',
      description: 'Session JWT with user_id claim for entitlement binding.',
    }),
    expires_at: z.string().datetime().openapi({
      example: '2026-07-13T18:00:00.000Z',
    }),
    user_id: z.string().uuid().openapi({
      example: '550e8400-e29b-41d4-a716-446655440000',
      description: 'Stable account id — entitlement key when accounts flag is on.',
    }),
  })
  .openapi('AccountAuthResponse');

export type AccountAuthResponse = z.infer<typeof AccountAuthResponseSchema>;
