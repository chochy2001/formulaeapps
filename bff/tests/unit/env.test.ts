import { describe, test, expect, afterAll } from 'bun:test';

const ORIGINAL = { ...process.env };
let counter = 0;

async function freshEnv() {
  counter++;
  return await import(`../../src/lib/env.ts?env${counter}`);
}

describe('env.ts: dev mode defaults', () => {
  test('isDev=true, isProd=false in development', async () => {
    process.env['BFF_ENV'] = 'development';
    process.env['JWT_SHARED_SECRET'] = 'test-secret-' + 'a'.repeat(48);
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-test-key';
    process.env['JWT_SIGNING_SECRET'] = undefined;

    const mod = await freshEnv();
    expect(mod.isDev).toBe(true);
    expect(mod.isProd).toBe(false);
    expect(mod.env.BFF_ENV).toBe('development');
    expect(mod.env.BFF_PORT).toBe(3000);
    expect(mod.env.LOG_LEVEL).toBe('error');
  });
});

describe('env.ts: placeholder rejection in staging/production', () => {
  afterAll(() => {
    Object.assign(process.env, ORIGINAL);
  });

  test('rejects placeholder JWT_SHARED_SECRET in staging', async () => {
    process.env['BFF_ENV'] = 'staging';
    process.env['JWT_SHARED_SECRET'] = 'PLACEHOLDER_DEV_NOT_FOR_PROD';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = undefined;
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('JWT_SHARED_SECRET appears to be a placeholder in staging environment');
  });

  test('rejects placeholder JWT_SIGNING_SECRET in staging', async () => {
    process.env['BFF_ENV'] = 'staging';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = 'replace-me';
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('JWT_SIGNING_SECRET appears to be a placeholder in staging environment');
  });

  test('rejects placeholder OPENROUTER_API_KEY in staging', async () => {
    process.env['BFF_ENV'] = 'staging';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'replace-me';
    process.env['JWT_SIGNING_SECRET'] = undefined;
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('OPENROUTER_API_KEY appears to be a placeholder in staging environment');
  });

  test('warns about missing JWT_SIGNING_SECRET in production', async () => {
    process.env['BFF_ENV'] = 'production';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = undefined;
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    const warnings: string[] = [];
    const origWarn = console.warn;
    console.warn = (m: string) => { warnings.push(String(m)); };

    await freshEnv();

    console.warn = origWarn;
    expect(warnings.some((w) => w.includes('JWT_SIGNING_SECRET') && w.includes('client-shared'))).toBe(true);
  });

  test('throws on invalid env values (parse error)', async () => {
    process.env['BFF_ENV'] = 'development';
    process.env['BFF_PORT'] = 'not-a-number';
    process.env['JWT_SHARED_SECRET'] = 'test-secret-' + 'a'.repeat(48);
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-test-key';
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('Invalid env configuration');
  });
});
