import { z } from '@hono/zod-openapi';

// Data Model E4 — ChatRequest
export const ChatRequestSchema = z
  .object({
    message: z.string().min(1).max(4000).openapi({
      example: '¿Cuál es la fórmula de la energía cinética?',
      description: "User's question. Trimmed before validation.",
    }),
    model_id: z.string().optional().openapi({
      example: 'openai/gpt-4o-mini',
      description:
        "Optional OpenRouter model selector (`provider/model` format) from the BFF's allowlist. If absent, BFF default applies. See https://openrouter.ai/models.",
    }),
    conversation_id: z.string().uuid().optional().openapi({
      example: '7c9e6679-7425-40de-944b-e07fc1f90ae7',
      description: 'Optional thread correlation id.',
    }),
  })
  .openapi('ChatRequest');

export type ChatRequest = z.infer<typeof ChatRequestSchema>;

// Data Model E5 partial — ChatUsage
export const ChatUsageSchema = z
  .object({
    prompt_tokens: z.number().int().nonnegative(),
    completion_tokens: z.number().int().nonnegative(),
    total_tokens: z.number().int().nonnegative(),
  })
  .openapi('ChatUsage');

export type ChatUsage = z.infer<typeof ChatUsageSchema>;

// Data Model E5 — ChatResponse
export const ChatResponseSchema = z
  .object({
    message: z.string().openapi({
      example: 'La energía cinética es E_c = (1/2) m v^2 ...',
      description: "Assistant's text.",
    }),
    model_id: z.string().openapi({
      example: 'openai/gpt-4o-mini',
      description: 'Echo of the model that produced the response (`provider/model` format).',
    }),
    usage: ChatUsageSchema,
    conversation_id: z.string().uuid().optional().openapi({
      description: 'Echo of request conversation_id if supplied.',
    }),
    prompts_version: z.string().openapi({
      example: '1.0.0',
    }),
  })
  .openapi('ChatResponse');

export type ChatResponse = z.infer<typeof ChatResponseSchema>;
