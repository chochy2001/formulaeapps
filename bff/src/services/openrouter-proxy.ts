import { env } from '../lib/env';
import { BffError, UPSTREAM_ERROR_MESSAGE } from '../middleware/error';
import { PROMPTS_VERSION, SYSTEM_PROMPTS } from '../schemas/prompts';
import type { ChatRequest, ChatResponse } from '../schemas/chat';

// OpenRouter is OpenAI-API-compatible at the request/response level
// (https://openrouter.ai/docs/api-reference/overview). We POST the same
// /v1/chat/completions shape and parse the same `choices[].message.content`
// + `usage.{prompt,completion,total}_tokens` fields.
const OPENROUTER_CHAT_URL = 'https://openrouter.ai/api/v1/chat/completions';
const OPENROUTER_TIMEOUT_MS = 20_000;

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
  // An upstream error can contain provider-specific message/type/code values.
  // Keep it opaque: clients only receive the BFF's normalized error contract.
  error?: unknown;
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

export type ProxyChatOptions = {
  fetchImpl?: FetchLike;
  /** Optional caller cancellation, composed with the BFF request timeout. */
  signal?: AbortSignal;
  /** Test/embedding override; invalid values retain the bounded default. */
  timeoutMs?: number;
};

function resolveTimeoutMs(timeoutMs: number | undefined): number {
  return typeof timeoutMs === 'number' && Number.isFinite(timeoutMs) && timeoutMs > 0
    ? timeoutMs
    : OPENROUTER_TIMEOUT_MS;
}

export async function proxyChat(
  req: ChatRequest,
  opts?: ProxyChatOptions,
): Promise<ChatResponse> {
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

  // Do not rely on AbortSignal.timeout(): Bun and current Node expose it, but
  // composing it with an optional caller signal is not portable everywhere we
  // run tests. A local controller keeps fetch standards-compatible and lets
  // both cancellation paths share one signal.
  const controller = new AbortController();
  const callerSignal = opts?.signal;
  const abortFromCaller = (): void => controller.abort();
  if (callerSignal?.aborted) {
    controller.abort();
  } else {
    callerSignal?.addEventListener('abort', abortFromCaller, { once: true });
  }

  let timedOut = false;
  const timeout = setTimeout(() => {
    timedOut = true;
    controller.abort();
  }, resolveTimeoutMs(opts?.timeoutMs));

  try {
    if (controller.signal.aborted) {
      throw new BffError(
        'upstream_error',
        UPSTREAM_ERROR_MESSAGE,
        'E_OPENROUTER_ABORTED',
      );
    }

    const res = await fetchImpl(OPENROUTER_CHAT_URL, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${env.OPENROUTER_API_KEY}`,
        'Content-Type': 'application/json',
        'HTTP-Referer': env.OPENROUTER_HTTP_REFERER,
        'X-Title': env.OPENROUTER_X_TITLE,
      },
      body: JSON.stringify(body),
      signal: controller.signal,
    });

    if (!res.ok) {
      throw new BffError(
        'upstream_error',
        UPSTREAM_ERROR_MESSAGE,
        `E_OPENROUTER_${res.status}`,
      );
    }

    let json: OpenRouterResponseBody;
    try {
      json = (await res.json()) as OpenRouterResponseBody;
    } catch {
      throw new BffError(
        'upstream_error',
        UPSTREAM_ERROR_MESSAGE,
        'E_OPENROUTER_BAD_JSON',
      );
    }

    if (json.error) {
      throw new BffError(
        'upstream_error',
        UPSTREAM_ERROR_MESSAGE,
        'E_OPENROUTER_PROVIDER_ERROR',
      );
    }

    const choice = json.choices?.[0];
    if (!choice || typeof choice.message?.content !== 'string') {
      throw new BffError(
        'upstream_error',
        UPSTREAM_ERROR_MESSAGE,
        'E_OPENROUTER_NO_CHOICE',
      );
    }

    const usage = json.usage;
    if (
      !usage ||
      usage.total_tokens !== usage.prompt_tokens + usage.completion_tokens
    ) {
      throw new BffError(
        'upstream_error',
        UPSTREAM_ERROR_MESSAGE,
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
  } catch (err) {
    if (err instanceof BffError) {
      throw err;
    }
    if (timedOut) {
      throw new BffError(
        'upstream_error',
        UPSTREAM_ERROR_MESSAGE,
        'E_OPENROUTER_TIMEOUT',
      );
    }
    if (controller.signal.aborted) {
      throw new BffError(
        'upstream_error',
        UPSTREAM_ERROR_MESSAGE,
        'E_OPENROUTER_ABORTED',
      );
    }
    throw new BffError(
      'upstream_error',
      UPSTREAM_ERROR_MESSAGE,
      'E_OPENROUTER_FETCH',
    );
  } finally {
    clearTimeout(timeout);
    callerSignal?.removeEventListener('abort', abortFromCaller);
  }
}
