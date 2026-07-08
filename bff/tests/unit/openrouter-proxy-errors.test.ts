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
  test('network error maps to upstream_error E_OPENROUTER_FETCH', async () => {
    const fetchImpl: FetchLike = async () => {
      throw new Error('connect ECONNREFUSED 127.0.0.1:443');
    };

    await expect(
      proxyChat({ message: 'hi' }, { fetchImpl }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_FETCH',
    });
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

  test('OpenRouter error field in body maps to E_OPENROUTER_<type>', async () => {
    const fetchImpl = makeFetch({
      ok: true,
      status: 200,
      body: { error: { message: 'Rate limit exceeded', type: 'rate_limited' } },
    });

    await expect(
      proxyChat({ message: 'x' }, { fetchImpl }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_rate_limited',
    });
  });

  test('OpenRouter error without type falls back to E_OPENROUTER_ERROR', async () => {
    const fetchImpl = makeFetch({
      ok: true,
      status: 200,
      body: { error: { message: 'Internal error' } },
    });

    await expect(
      proxyChat({ message: 'x' }, { fetchImpl }),
    ).rejects.toMatchObject({
      kind: 'upstream_error',
      code: 'E_OPENROUTER_ERROR',
    });
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

  test('returns NOT 502 but 200 because proxyChat throws and errorHandler maps it', async () => {
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
