import { env } from '../lib/env';
import { BffError } from '../middleware/error';
import { PROMPTS_VERSION, SYSTEM_PROMPTS } from '../schemas/prompts';
import type { ChatRequest, ChatResponse } from '../schemas/chat';

// OpenRouter is OpenAI-API-compatible at the request/response level
// (https://openrouter.ai/docs/api-reference/overview). We POST the same
// /v1/chat/completions shape and parse the same `choices[].message.content`
// + `usage.{prompt,completion,total}_tokens` fields.
const OPENROUTER_CHAT_URL = 'https://openrouter.ai/api/v1/chat/completions';

type OpenRouterRequestBody = {
  model: string;
  messages: Array<{ role: 'system' | 'user' | 'assistant'; content: string }>;
  max_tokens: number;
  temperature: number;
};

type OpenRouterChoice = {
  message: { role: string; content: string };
  finish_reason: string;
};

type OpenRouterResponseBody = {
  choices: OpenRouterChoice[];
  usage: {
    prompt_tokens: number;
    completion_tokens: number;
    total_tokens: number;
  };
  error?: { message: string; type?: string; code?: string };
};

/**
 * Inject the BFF-side system prompts and forward the user's message to OpenRouter.
 *
 * Routing through OpenRouter (instead of OpenAI directly) lets the FE switch
 * models per-task and adopt new models without a BFF redeploy — `model_id` is
 * `provider/model-id` (e.g. `openai/gpt-4o-mini`, `anthropic/claude-3.5-sonnet`,
 * `google/gemini-2.0-flash`). The accepted set is gated by
 * OPENROUTER_MODEL_ALLOWLIST, evaluated server-side.
 *
 * - Model id falls back to env default if not provided; rejected if not in allowlist.
 * - System prompts are server-side (spec §FR-019).
 * - The OpenRouter API key never leaves this process.
 * - HTTP-Referer + X-Title are attribution headers OpenRouter uses for model
 *   ranking on https://openrouter.ai/rankings; recommended but not required.
 * - Validates the `total_tokens === prompt_tokens + completion_tokens` invariant
 *   (VR-001). OpenRouter normalizes usage to OpenAI's shape across providers.
 */
// Narrower than `typeof fetch` so test mocks (bare arrow functions) satisfy it
// without an `as unknown as` cast. The real `fetch` is structurally compatible
// (it just has extra Bun-specific properties like `preconnect`).
export type FetchLike = (url: string | URL | Request, init?: RequestInit) => Promise<Response>;

export async function proxyChat(req: ChatRequest, opts?: { fetchImpl?: FetchLike }): Promise<ChatResponse> {
  const fetchImpl: FetchLike = opts?.fetchImpl ?? fetch;
  const modelId = req.model_id ?? env.OPENROUTER_DEFAULT_MODEL;

  if (!env.OPENROUTER_MODEL_ALLOWLIST.includes(modelId)) {
    throw new BffError(
      'bad_request',
      `model_id '${modelId}' is not in the BFF allowlist`,
      'E_MODEL_NOT_ALLOWED',
    );
  }

  const body: OpenRouterRequestBody = {
    model: modelId,
    messages: [
      ...SYSTEM_PROMPTS.map((content) => ({ role: 'system' as const, content })),
      { role: 'user' as const, content: req.message },
    ],
    max_tokens: 150,
    temperature: 0,
  };

  let res: Response;
  try {
    res = await fetchImpl(OPENROUTER_CHAT_URL, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${env.OPENROUTER_API_KEY}`,
        'Content-Type': 'application/json',
        'HTTP-Referer': env.OPENROUTER_HTTP_REFERER,
        'X-Title': env.OPENROUTER_X_TITLE,
      },
      body: JSON.stringify(body),
    });
  } catch (err) {
    throw new BffError(
      'upstream_error',
      `OpenRouter request failed: ${err instanceof Error ? err.message : 'unknown'}`,
      'E_OPENROUTER_FETCH',
    );
  }

  if (!res.ok) {
    throw new BffError(
      'upstream_error',
      `OpenRouter responded ${res.status}`,
      `E_OPENROUTER_${res.status}`,
    );
  }

  let json: OpenRouterResponseBody;
  try {
    json = (await res.json()) as OpenRouterResponseBody;
  } catch {
    throw new BffError('upstream_error', 'OpenRouter returned non-JSON response', 'E_OPENROUTER_BAD_JSON');
  }

  if (json.error) {
    throw new BffError(
      'upstream_error',
      `OpenRouter error: ${json.error.message}`,
      `E_OPENROUTER_${json.error.type ?? 'ERROR'}`,
    );
  }

  const choice = json.choices?.[0];
  if (!choice || typeof choice.message?.content !== 'string') {
    throw new BffError('upstream_error', 'OpenRouter returned no completion', 'E_OPENROUTER_NO_CHOICE');
  }

  const usage = json.usage;
  if (
    !usage ||
    usage.total_tokens !== usage.prompt_tokens + usage.completion_tokens
  ) {
    throw new BffError(
      'upstream_error',
      'OpenRouter usage shape invariant violated',
      'E_OPENROUTER_USAGE_INVARIANT',
    );
  }

  return {
    message: choice.message.content,
    model_id: modelId,
    usage: {
      prompt_tokens: usage.prompt_tokens,
      completion_tokens: usage.completion_tokens,
      total_tokens: usage.total_tokens,
    },
    ...(req.conversation_id !== undefined ? { conversation_id: req.conversation_id } : {}),
    prompts_version: PROMPTS_VERSION,
  };
}
