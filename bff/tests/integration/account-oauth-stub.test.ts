import { describe, test, expect, beforeAll, afterAll, beforeEach } from 'bun:test';
import { app } from '../../src/index';
import { resetUsersStoreForTests } from '../../src/services/users-store';

/**
 * Optional OAuth stub for fleet #86 — Google/Apple Sign-In surface only.
 * No provider verification until Jorge configures OAuth client secrets.
 */
describe('POST /auth/oauth (fleet #86 optional stub)', () => {
  const prev = process.env['ENABLE_USER_ACCOUNT_AUTH'];
  const prevDb = process.env['ACCOUNTS_DB_PATH'];

  beforeAll(() => {
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    process.env['ACCOUNTS_DB_PATH'] = ':memory:';
    resetUsersStoreForTests();
  });

  beforeEach(() => {
    process.env['ACCOUNTS_DB_PATH'] = ':memory:';
    resetUsersStoreForTests();
  });

  afterAll(() => {
    if (prev === undefined) {
      delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    } else {
      process.env['ENABLE_USER_ACCOUNT_AUTH'] = prev;
    }
    if (prevDb === undefined) {
      delete process.env['ACCOUNTS_DB_PATH'];
    } else {
      process.env['ACCOUNTS_DB_PATH'] = prevDb;
    }
    resetUsersStoreForTests();
  });

  test('oauth returns 403 E_ACCOUNTS_DISABLED when flag off', async () => {
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    const res = await app.request('/auth/oauth', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        provider: 'google',
        id_token: 'fake.jwt.token',
      }),
    });
    expect(res.status).toBe(403);
    const body = (await res.json()) as {
      error: { kind: string; code?: string };
    };
    expect(body.error.kind).toBe('forbidden');
    expect(body.error.code).toBe('E_ACCOUNTS_DISABLED');
  });

  test('oauth returns 503 E_OAUTH_NOT_IMPLEMENTED when flag on (stub)', async () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    const res = await app.request('/auth/oauth', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        provider: 'apple',
        id_token: 'fake.jwt.token',
      }),
    });
    expect(res.status).toBe(503);
    const body = (await res.json()) as {
      error: { kind: string; code?: string };
    };
    expect(body.error.code).toBe('E_OAUTH_NOT_IMPLEMENTED');
  });

  test('oauth rejects unknown provider', async () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    const res = await app.request('/auth/oauth', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        provider: 'facebook',
        id_token: 'fake.jwt.token',
      }),
    });
    expect(res.status).toBe(400);
  });
});
