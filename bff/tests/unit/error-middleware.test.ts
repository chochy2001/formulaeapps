import { describe, expect, test } from 'bun:test';
import { Hono } from 'hono';
import { BffError, errorHandler } from '../../src/middleware/error';
import type { AppEnv } from '../../src/lib/openapi';

type ErrorResponse = {
  error: {
    kind: string;
    message: string;
    code?: string;
    request_id: string;
  };
};

function appWithErrorHandler(): Hono<AppEnv> {
  const app = new Hono<AppEnv>();
  app.onError(errorHandler);
  return app;
}

describe('errorHandler', () => {
  test('normalizes upstream errors without leaking messages or invalid codes', async () => {
    const app = appWithErrorHandler();
    app.get('/upstream', () => {
      throw new BffError(
        'upstream_error',
        'provider detail: model vendor/rate_limit internal-id=secret',
        'E_PROVIDER_rate_limit',
      );
    });

    const res = await app.request('/upstream');
    const body = (await res.json()) as ErrorResponse;

    expect(res.status).toBe(502);
    expect(body.error.kind).toBe('upstream_error');
    expect(body.error.message).toBe(
      'The requested service is temporarily unavailable. Please try again.',
    );
    expect(body.error.message).not.toContain('provider detail');
    expect(body.error.code).toBe('E_UPSTREAM_ERROR');
    expect(body.error.code).toMatch(/^E_[A-Z0-9_]+$/);
    expect(body.error.request_id).toMatch(
      /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i,
    );
  });

  test('does not trust a provider-shaped tagged object', async () => {
    const app = appWithErrorHandler();
    app.get('/spoofed', () => {
      throw Object.assign(new Error('provider secret error body'), {
        kind: 'upstream_error',
        code: 'E_PROVIDER_bad_type',
      });
    });

    const res = await app.request('/spoofed');
    const body = (await res.json()) as ErrorResponse;

    expect(res.status).toBe(500);
    expect(body.error.kind).toBe('internal_error');
    expect(body.error.message).not.toContain('provider secret');
    expect(body.error.code).toBe('E_INTERNAL');
    expect(body.error.message.length).toBeLessThanOrEqual(200);
  });
});
