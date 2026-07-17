import { describe, test, expect, beforeAll, afterAll, beforeEach } from 'bun:test';
import { app } from '../../src/index';
import { verifyToken } from '../../src/lib/jwt';
import {
  grantMobileEntitlement,
  listEntitlementsForSubject,
  resetEntitlementsStoreForTests,
} from '../../src/services/entitlements-store';
import { hashClientId } from '../../src/services/jwt-issuer';
import { resetUsersStoreForTests } from '../../src/services/users-store';

describe('POST /auth/register + /auth/login (fleet #86)', () => {
  const prev = process.env['ENABLE_USER_ACCOUNT_AUTH'];
  const prevDb = process.env['ACCOUNTS_DB_PATH'];
  const prevEntitlementsDb = process.env['ENTITLEMENTS_DB_PATH'];

  beforeAll(() => {
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
    process.env['ACCOUNTS_DB_PATH'] = ':memory:';
    resetUsersStoreForTests();
  });

  beforeEach(() => {
    process.env['ACCOUNTS_DB_PATH'] = ':memory:';
    process.env['ENTITLEMENTS_DB_PATH'] = ':memory:';
    resetUsersStoreForTests();
    resetEntitlementsStoreForTests();
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
    if (prevEntitlementsDb === undefined) {
      delete process.env['ENTITLEMENTS_DB_PATH'];
    } else {
      process.env['ENTITLEMENTS_DB_PATH'] = prevEntitlementsDb;
    }
    resetUsersStoreForTests();
    resetEntitlementsStoreForTests();
  });

  test('register returns 403 with E_ACCOUNTS_DISABLED when flag off', async () => {
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
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
    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
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

  test('register + login happy path when flag on (JWT includes user_id)', async () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    const email = `acct-${Date.now()}@example.com`;
    const password = 'correct-horse-battery';

    const reg = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });
    expect(reg.status).toBe(200);
    const regBody = (await reg.json()) as {
      token: string;
      expires_at: string;
      user_id: string;
    };
    expect(regBody.user_id).toMatch(
      /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i,
    );
    expect(regBody.token.split('.').length).toBe(3);
    expect(Date.parse(regBody.expires_at)).toBeGreaterThan(Date.now());

    const regClaims = await verifyToken(regBody.token);
    expect(regClaims.user_id).toBe(regBody.user_id);
    expect(regClaims.sub).toBe(`user:${regBody.user_id}`);

    const login = await app.request('/auth/login', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });
    expect(login.status).toBe(200);
    const loginBody = (await login.json()) as {
      token: string;
      user_id: string;
    };
    expect(loginBody.user_id).toBe(regBody.user_id);
    const loginClaims = await verifyToken(loginBody.token);
    expect(loginClaims.user_id).toBe(regBody.user_id);

    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
  });

  test('login rejects bad password with 401 when flag on', async () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    const email = `badpass-${Date.now()}@example.com`;
    const password = 'correct-horse-battery';

    const reg = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });
    expect(reg.status).toBe(200);

    const login = await app.request('/auth/login', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email, password: 'wrong-password' }),
    });
    expect(login.status).toBe(401);
    const body = (await login.json()) as { error: { code?: string } };
    expect(body.error.code).toBe('E_INVALID_CREDENTIALS');

    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
  });

  test('duplicate register returns 400 E_EMAIL_TAKEN when flag on', async () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    const email = `dup-${Date.now()}@example.com`;
    const password = 'correct-horse-battery';

    const first = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });
    expect(first.status).toBe(200);

    const second = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email, password }),
    });
    expect(second.status).toBe(400);
    const body = (await second.json()) as { error: { code?: string } };
    expect(body.error.code).toBe('E_EMAIL_TAKEN');

    delete process.env['ENABLE_USER_ACCOUNT_AUTH'];
  });

  test('rejects an unproved foreign client_id without adopting its entitlement', async () => {
    process.env['ENABLE_USER_ACCOUNT_AUTH'] = 'true';
    const foreignClientId = '11111111-2222-4333-8444-555555555555';
    const foreignSubject = hashClientId(foreignClientId);
    grantMobileEntitlement({
      subject: foreignSubject,
      payment_source: 'app_store',
      product_id: 'com.capdesis.formulae.pro_monthly',
      raw_receipt_ref: 'victim-transaction',
    });

    const rejectedRegistration = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        email: `attacker-${Date.now()}@example.com`,
        password: 'correct-horse-battery',
        client_id: foreignClientId,
      }),
    });
    expect(rejectedRegistration.status).toBe(400);
    expect(listEntitlementsForSubject(foreignSubject)[0]?.user_id).toBeNull();

    const email = `safe-${Date.now()}@example.com`;
    const registered = await app.request('/auth/register', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ email, password: 'correct-horse-battery' }),
    });
    expect(registered.status).toBe(200);
    const account = (await registered.json()) as { token: string; user_id: string };
    const claims = await verifyToken(account.token);
    expect(claims.sub).toBe(`user:${account.user_id}`);

    const entitlement = await app.request('/entitlement', {
      headers: { authorization: `Bearer ${account.token}` },
    });
    expect(entitlement.status).toBe(200);
    const body = (await entitlement.json()) as { sources: unknown[] };
    expect(body.sources).toEqual([]);

    const rejectedLogin = await app.request('/auth/login', {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({
        email,
        password: 'correct-horse-battery',
        client_id: foreignClientId,
      }),
    });
    expect(rejectedLogin.status).toBe(400);
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
