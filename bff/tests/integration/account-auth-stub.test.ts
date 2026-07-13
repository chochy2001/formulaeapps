import { describe, test, expect, beforeAll, afterAll } from 'bun:test';
import { app } from '../../src/index';

describe('POST /auth/register + /auth/login stubs (fleet #86)', () => {
  const prev = process.env['ENABLE_USER_ACCOUNT_AUTH'];

  beforeAll(() => {
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
  });

  afterAll(() => {
    if (prev === undefined) {
      delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    } else {
      process.env['ENABLE_USER_ACCOUNT_AUTH'] = prev;
    }
  });

  test('register returns 403 with E_ACCOUNTS_DISABLED when flag off', async () => {
    const res = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        email: 'user@example.com',
        password: 'correct-horse',
      }),
    });
    expect(res.status).toBe(403);
    const body = (await res.json()) as {
      error: { kind: string; code?: string };
    };
    expect(body.error.kind).toBe('forbidden');
    expect(body.error.code).toBe('E_ACCOUNTS_DISABLED');
  });

  test('login returns 403 with E_ACCOUNTS_DISABLED when flag off', async () => {
    const res = await app.request('/auth/login', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        email: 'user@example.com',
        password: 'correct-horse',
      }),
    });
    expect(res.status).toBe(403);
    const body = (await res.json()) as {
      error: { kind: string; code?: string };
    };
    expect(body.error.kind).toBe('forbidden');
    expect(body.error.code).toBe('E_ACCOUNTS_DISABLED');
  });

  test('register returns 503 stub when flag on (impl not landed)', async () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    const res = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        email: 'user@example.com',
        password: 'correct-horse',
      }),
    });
    expect(res.status).toBe(503);
    const body = (await res.json()) as {
      error: { code?: string };
    };
    expect(body.error.code).toBe('E_ACCOUNTS_STUB');
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
  });

  test('rejects invalid email with 400', async () => {
    const res = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        email: 'not-an-email',
        password: 'correct-horse',
      }),
    });
    expect(res.status).toBe(400);
  });
});
