import { z } from '@hono/zod-openapi';

// Data Model E6 — IapValidateRequest
export const IapValidateRequestSchema = z
  .object({
    platform: z.enum(['apple', 'google']).openapi({
      example: 'apple',
      description: 'IAP provider.',
    }),
    product_id: z.string().openapi({
      example: 'com.capdesis.formulae.pro_monthly',
      description: "Provider's product identifier.",
    }),
    transaction_id: z.string().openapi({
      example: '1000000123456789',
      description: "Provider's transaction id.",
    }),
    receipt_data: z.string().max(16384).openapi({
      description:
        'Base64-encoded receipt (Apple) or purchase token (Google). Max 16 KB.',
    }),
    subscription: z.boolean().openapi({
      example: true,
      description: 'true for subscriptions, false for one-time purchases.',
    }),
  })
  .openapi('IapValidateRequest');

export type IapValidateRequest = z.infer<typeof IapValidateRequestSchema>;

// Data Model E7 — IapValidateResponse
export const IapValidateResponseSchema = z
  .object({
    valid: z.boolean().openapi({
      description: 'true if the provider confirms the receipt.',
    }),
    expires_at: z.string().datetime().optional().openapi({
      example: '2026-06-18T00:00:00.000Z',
      description: 'ISO-8601 UTC. Present for subscriptions.',
    }),
    product_id: z.string(),
    transaction_id: z.string(),
    environment: z.enum(['sandbox', 'production']).openapi({
      example: 'production',
      description: 'IAP environment that produced the receipt.',
    }),
    provider_reason: z.string().max(200).optional().openapi({
      description:
        "Short reason when valid=false. Does not leak the raw provider body.",
    }),
  })
  .openapi('IapValidateResponse');

export type IapValidateResponse = z.infer<typeof IapValidateResponseSchema>;
