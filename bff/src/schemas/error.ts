import { z } from '@hono/zod-openapi';

// Data Model E8 — ErrorKind enum
export const ErrorKindSchema = z
  .enum([
    'unauthorized',
    'forbidden',
    'not_found',
    'bad_request',
    'upstream_error',
    'rate_limited',
    'internal_error',
  ])
  .openapi('ErrorKind');

export type ErrorKind = z.infer<typeof ErrorKindSchema>;

// Data Model E8 — ErrorEnvelope
export const ErrorEnvelopeSchema = z
  .object({
    error: z.object({
      kind: ErrorKindSchema,
      message: z.string().max(200).openapi({
        example: 'JWT inválido',
        description:
          'Short user-presentable message in ES (default) or _en. No secrets.',
      }),
      code: z
        .string()
        .regex(/^E_[A-Z0-9_]+$/)
        .optional()
        .openapi({
          example: 'E_INVALID_JWT',
          description: 'Stable error code for client branching.',
        }),
      request_id: z.string().uuid().openapi({
        description: 'Matches the request_id in BFF logs.',
      }),
    }),
  })
  .openapi('ErrorEnvelope');

export type ErrorEnvelope = z.infer<typeof ErrorEnvelopeSchema>;

// Helper for handler use
export function errorEnvelope(
  kind: ErrorKind,
  message: string,
  requestId: string,
  code?: string,
): ErrorEnvelope {
  return {
    error: { kind, message, ...(code !== undefined ? { code } : {}), request_id: requestId },
  };
}
