import { z } from '@hono/zod-openapi';

/**
 * OpenAPI stubs for email/password accounts (fleet #86 / WP5 step 2).
 * Handlers remain behind ENABLE_USER_ACCOUNT_AUTH (default off) until the
 * users table + password hashing land. See docs/ACCOUNTS_USER_ID_PLAN.md.
 */

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
  })
  .openapi('AccountLoginRequest');

export type AccountLoginRequest = z.infer<typeof AccountLoginRequestSchema>;

/** Shared success shape once accounts are implemented (JWT + user_id). */
export const AccountAuthResponseSchema = z
  .object({
    token: z.string().openapi({
      example: 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VyLi4uIn0.sig',
      description: 'Session JWT; future claim user_id binds entitlements.',
    }),
    expires_at: z.string().datetime().openapi({
      example: '2026-07-13T18:00:00.000Z',
    }),
    user_id: z.string().uuid().openapi({
      example: '550e8400-e29b-41d4-a716-446655440000',
      description: 'Stable account id — entitlement key once accounts go live.',
    }),
  })
  .openapi('AccountAuthResponse');

export type AccountAuthResponse = z.infer<typeof AccountAuthResponseSchema>;
