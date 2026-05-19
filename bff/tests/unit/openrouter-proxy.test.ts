import { describe, test, expect } from 'bun:test';
import { proxyChat, type FetchLike } from '../../src/services/openrouter-proxy';
import { SYSTEM_PROMPTS, PROMPTS_VERSION } from '../../src/schemas/prompts';

function makeFetch(responseInit: { ok: boolean; status: number; body: unknown }): FetchLike {
  return async () =>
    new Response(JSON.stringify(responseInit.body), {
      status: responseInit.status,
      headers: { 'Content-Type': 'application/json' },
    });
}

describe('openrouter-proxy', () => {
  test('forwards user message + system prompts and returns ChatResponse shape', async () => {
    let capturedUrl: unknown = null;
    let capturedHeaders: Record<string, string> = {};
    let capturedBody: unknown = null;
    const fetchImpl: FetchLike = async (url, init) => {
      capturedUrl = url;
      capturedHeaders = (init?.headers ?? {}) as Record<string, string>;
      capturedBody = JSON.parse(init?.body as string);
      return new Response(
        JSON.stringify({
          choices: [
            { message: { role: 'assistant', content: 'Hola!' }, finish_reason: 'stop' },
          ],
          usage: { prompt_tokens: 100, completion_tokens: 5, total_tokens: 105 },
        }),
        { status: 200, headers: { 'Content-Type': 'application/json' } },
      );
    };

    const result = await proxyChat({ message: '¿Hola?' }, { fetchImpl });

    expect(capturedUrl).toBe('https://openrouter.ai/api/v1/chat/completions');
    expect(capturedHeaders['HTTP-Referer']).toBeTypeOf('string');
    expect(capturedHeaders['X-Title']).toBeTypeOf('string');
    expect(result.message).toBe('Hola!');
    expect(result.model_id).toBe('openai/gpt-4o-mini'); // default
    expect(result.usage.total_tokens).toBe(105);
    expect(result.prompts_version).toBe(PROMPTS_VERSION);

    // All system prompts + 1 user message
    const body = capturedBody as { messages: Array<{ role: string; content: string }>; model: string };
    expect(body.model).toBe('openai/gpt-4o-mini');
    expect(body.messages.length).toBe(SYSTEM_PROMPTS.length + 1);
    expect(body.messages[body.messages.length - 1]!.role).toBe('user');
    expect(body.messages[body.messages.length - 1]!.content).toBe('¿Hola?');
  });

  test('rejects model_id outside allowlist', async () => {
    await expect(
      proxyChat({ message: 'x', model_id: 'someprovider/secret-model' }, { fetchImpl: makeFetch({ ok: false, status: 200, body: {} }) }),
    ).rejects.toMatchObject({ kind: 'bad_request', code: 'E_MODEL_NOT_ALLOWED' });
  });

  test('maps OpenRouter 5xx to upstream_error', async () => {
    const fetchImpl = makeFetch({ ok: false, status: 502, body: { error: { message: 'down', type: 'api' } } });
    await expect(proxyChat({ message: 'x' }, { fetchImpl })).rejects.toMatchObject({ kind: 'upstream_error' });
  });

  test('rejects usage invariant violation', async () => {
    const fetchImpl: FetchLike = async () =>
      new Response(
        JSON.stringify({
          choices: [{ message: { role: 'assistant', content: 'ok' }, finish_reason: 'stop' }],
          // total != prompt + completion
          usage: { prompt_tokens: 10, completion_tokens: 5, total_tokens: 999 },
        }),
        { status: 200, headers: { 'Content-Type': 'application/json' } },
      );
    await expect(proxyChat({ message: 'x' }, { fetchImpl })).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_USAGE_INVARIANT',
    });
  });

  test('passes conversation_id through when supplied', async () => {
    const fetchImpl: FetchLike = async () =>
      new Response(
        JSON.stringify({
          choices: [{ message: { role: 'assistant', content: 'ok' }, finish_reason: 'stop' }],
          usage: { prompt_tokens: 1, completion_tokens: 1, total_tokens: 2 },
        }),
        { status: 200, headers: { 'Content-Type': 'application/json' } },
      );
    const result = await proxyChat(
      { message: 'x', conversation_id: '7c9e6679-7425-40de-944b-e07fc1f90ae7' },
      { fetchImpl },
    );
    expect(result.conversation_id).toBe('7c9e6679-7425-40de-944b-e07fc1f90ae7');
  });

  test('routes to alternate models when allowed (e.g., google/gemini-2.0-flash-lite-001)', async () => {
    let capturedModel = '';
    const fetchImpl: FetchLike = async (_url, init) => {
      const body = JSON.parse(init?.body as string) as { model: string };
      capturedModel = body.model;
      return new Response(
        JSON.stringify({
          choices: [{ message: { role: 'assistant', content: 'claude' }, finish_reason: 'stop' }],
          usage: { prompt_tokens: 2, completion_tokens: 1, total_tokens: 3 },
        }),
        { status: 200, headers: { 'Content-Type': 'application/json' } },
      );
    };
    const result = await proxyChat({ message: 'x', model_id: 'google/gemini-2.0-flash-lite-001' }, { fetchImpl });
    expect(capturedModel).toBe('google/gemini-2.0-flash-lite-001');
    expect(result.model_id).toBe('google/gemini-2.0-flash-lite-001');
  });
});
