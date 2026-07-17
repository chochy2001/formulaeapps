import { z } from '@hono/zod-openapi';

export const EntitlementSourceSchema = z
  .object({
    payment_source: z.enum(['app_store', 'play_store']).openapi({
      example: 'app_store',
    }),
    product_id: z.string().openapi({
      example: 'com.capdesis.formulae.pro_monthly',
    }),
    granted_at: z.string().datetime().openapi({
      example: '2026-07-13T20:00:00.000Z',
    }),
  })
  .openapi('EntitlementSource');

/** GET /entitlement — channel-scoped mobile entitlement view (WP5 step 1). */
export const EntitlementResponseSchema = z
  .object({
    scope: z.literal('mobile').openapi({
      description: 'IAP grants are mobile-only; never web/Polar from this path.',
    }),
    sources: z.array(EntitlementSourceSchema),
  })
  .openapi('EntitlementResponse');

export type EntitlementResponse = z.infer<typeof EntitlementResponseSchema>;
