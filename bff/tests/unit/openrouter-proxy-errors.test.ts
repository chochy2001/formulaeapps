import { describe, test, expect } from 'bun:test';
import { proxyChat, type FetchLike } from '../../src/services/openrouter-proxy';

function makeFetch(responseInit: { ok: boolean; status: number; body: unknown; headers?: Record<string, string> }): FetchLike {
  return async () =>
    new Response(JSON.stringify(responseInit.body), {
      status: responseInit.status,
      headers: { 'Content-Type': 'application/json', ...responseInit.headers },
    });
}

describe('openrouter-proxy: error paths', () => {
  test('network error maps to a client-safe upstream error', async () => {
    const fetchImpl: FetchLike = async () => {
      throw new Error('connect ECONNREFUSED 127.0.0.1:443');
    };

    let thrown: unknown;
    try {
      await proxyChat({ message: 'hi' }, { fetchImpl });
    } catch (error) {
      thrown = error;
    }

    expect(thrown).toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_FETCH',
      message: 'The requested service is temporarily unavailable. Please try again.',
    });
    expect((thrown as Error).message).not.toContain('ECONNREFUSED');
  });

  test('network error with non-Error cause', async () => {
    const fetchImpl: FetchLike = async () => {
      throw 'string error';
    };

    await expect(
      proxyChat({ message: 'hi' }, { fetchImpl }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_FETCH',
    });
  });

  test('non-JSON response maps to upstream_error E_OPENROUTER_BAD_JSON', async () => {
    const fetchImpl: FetchLike = async () =>
      new Response('<html>', {
        status: 200,
        headers: { 'Content-Type': 'text/html' },
      });

    await expect(
      proxyChat({ message: 'hi' }, { fetchImpl }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_BAD_JSON',
    });
  });

  test('provider error body never exposes its message or type', async () => {
    const fetchImpl = makeFetch({
      ok: true,
      status: 200,
      body: { error: { message: 'Rate limit exceeded', type: 'rate_limited' } },
    });

    await expect(proxyChat({ message: 'x' }, { fetchImpl })).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_PROVIDER_ERROR',
      message: 'The requested service is temporarily unavailable. Please try again.',
    });
  });

  test('provider error without a type uses the same normalized code', async () => {
    const fetchImpl = makeFetch({
      ok: true,
      status: 200,
      body: { error: { message: 'Internal error' } },
    });

    await expect(proxyChat({ message: 'x' }, { fetchImpl })).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_PROVIDER_ERROR',
    });
  });

  test('passes an AbortSignal to fetch and maps an elapsed timeout safely', async () => {
    let signal: AbortSignal | null | undefined;
    const fetchImpl: FetchLike = (_url, init) =>
      new Promise<Response>((_resolve, reject) => {
        signal = init?.signal;
        signal?.addEventListener(
          'abort',
          () => reject(new DOMException('provider transport detail', 'AbortError')),
          { once: true },
        );
      });

    await expect(
      proxyChat({ message: 'hi' }, { fetchImpl, timeoutMs: 1 }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_TIMEOUT',
      message: 'The requested service is temporarily unavailable. Please try again.',
    });
    expect(signal).toBeDefined();
    expect(signal?.aborted).toBe(true);
  });

  test('no choices in response maps to E_OPENROUTER_NO_CHOICE', async () => {
    const fetchImpl = makeFetch({
      ok: true,
      status: 200,
      body: {
        choices: [],
        usage: { prompt_tokens: 0, completion_tokens: 0, total_tokens: 0 },
      },
    });

    await expect(
      proxyChat({ message: 'x' }, { fetchImpl }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_NO_CHOICE',
    });
  });

  test('choice without message content maps to E_OPENROUTER_NO_CHOICE', async () => {
    const fetchImpl = makeFetch({
      ok: true,
      status: 200,
      body: {
        choices: [{ message: { role: 'assistant', content: 42 }, finish_reason: 'stop' }],
        usage: { prompt_tokens: 1, completion_tokens: 1, total_tokens: 2 },
      },
    });

    await expect(
      proxyChat({ message: 'x' }, { fetchImpl }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_NO_CHOICE',
    });
  });

  test('maps an upstream HTTP 503 to a stable upstream error code', async () => {
    const fetchImpl = makeFetch({
      ok: false,
      status: 503,
      body: { error: { message: 'Overloaded' } },
    });

    await expect(
      proxyChat({ message: 'x' }, { fetchImpl }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_503',
    });
  });
});
