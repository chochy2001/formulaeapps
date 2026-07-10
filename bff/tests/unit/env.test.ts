import { describe, test, expect, afterAll } from 'bun:test';
import { createHash } from 'node:crypto';

const ORIGINAL = { ...process.env };
const VALID_SIGNING_SECRET = createHash('sha256').update('formulae-test-signing-key').digest('hex');
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

  for (const environment of ['staging', 'production'] as const) {
    test(`rejects missing JWT_SIGNING_SECRET in ${environment}`, async () => {
      process.env['BFF_ENV'] = environment;
      process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
      process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
      process.env['JWT_SIGNING_SECRET'] = undefined;
      process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'false';
      process.env['JWT_LEGACY_VERIFY_START'] = undefined;
      process.env['JWT_LEGACY_VERIFY_CUTOFF'] = undefined;
      process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
      process.env['LOG_LEVEL'] = 'error';

      await expect(async () => {
        await freshEnv();
      }).toThrow(`JWT_SIGNING_SECRET is required in ${environment} environment`);
    });
  }

  for (const environment of ['staging', 'production'] as const) {
    test(`rejects non-hex JWT_SIGNING_SECRET in ${environment}`, async () => {
      process.env['BFF_ENV'] = environment;
      process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
      process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
      process.env['JWT_SIGNING_SECRET'] = 'z'.repeat(64);
      process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'false';
      process.env['JWT_LEGACY_VERIFY_START'] = undefined;
      process.env['JWT_LEGACY_VERIFY_CUTOFF'] = undefined;
      process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
      process.env['LOG_LEVEL'] = 'error';

      await expect(async () => {
        await freshEnv();
      }).toThrow(`JWT_SIGNING_SECRET must be exactly 64 hexadecimal characters in ${environment}`);
    });
  }

  test('accepts an exactly 64-character non-repeating hex signing secret', async () => {
    process.env['BFF_ENV'] = 'staging';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = VALID_SIGNING_SECRET;
    process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'false';
    process.env['JWT_LEGACY_VERIFY_START'] = undefined;
    process.env['JWT_LEGACY_VERIFY_CUTOFF'] = undefined;
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    const mod = await freshEnv();
    expect(mod.env.BFF_ENV).toBe('staging');
  });

  for (const [description, signingSecret] of [
    ['leading whitespace', ` ${VALID_SIGNING_SECRET.slice(1)}`],
    ['trailing whitespace', `${VALID_SIGNING_SECRET.slice(0, -1)} `],
    ['63 hex characters', VALID_SIGNING_SECRET.slice(0, -1)],
    ['65 hex characters', `${VALID_SIGNING_SECRET}0`],
  ] as const) {
    test(`rejects signing secret with ${description}`, async () => {
      process.env['BFF_ENV'] = 'production';
      process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
      process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
      process.env['JWT_SIGNING_SECRET'] = signingSecret;
      process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'false';
      process.env['JWT_LEGACY_VERIFY_START'] = undefined;
      process.env['JWT_LEGACY_VERIFY_CUTOFF'] = undefined;
      process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
      process.env['LOG_LEVEL'] = 'error';

      await expect(async () => {
        await freshEnv();
      }).toThrow('JWT_SIGNING_SECRET must be exactly 64 hexadecimal characters in production');
    });
  }

  for (const [description, signingSecret] of [
    ['one repeated character', 'a'.repeat(64)],
    ['a repeated short pattern', 'deadbeef'.repeat(8)],
    ['63 identical digits followed by one different digit', `${'0'.repeat(63)}1`],
  ] as const) {
    test(`rejects ${description} as a trivial signing secret`, async () => {
      process.env['BFF_ENV'] = 'production';
      process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
      process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
      process.env['JWT_SIGNING_SECRET'] = signingSecret;
      process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'false';
      process.env['JWT_LEGACY_VERIFY_START'] = undefined;
      process.env['JWT_LEGACY_VERIFY_CUTOFF'] = undefined;
      process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
      process.env['LOG_LEVEL'] = 'error';

      await expect(async () => {
        await freshEnv();
      }).toThrow('JWT_SIGNING_SECRET must not use a trivially repeated pattern');
    });
  }

  test('rejects a signing secret that matches the client-shared secret', async () => {
    const reusedSecret = VALID_SIGNING_SECRET;
    process.env['BFF_ENV'] = 'production';
    process.env['JWT_SHARED_SECRET'] = reusedSecret;
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = reusedSecret;
    process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'false';
    process.env['JWT_LEGACY_VERIFY_START'] = undefined;
    process.env['JWT_LEGACY_VERIFY_CUTOFF'] = undefined;
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('JWT_SIGNING_SECRET must differ from JWT_SHARED_SECRET');
  });

  test('requires a start timestamp when legacy verification is enabled', async () => {
    process.env['BFF_ENV'] = 'production';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = VALID_SIGNING_SECRET;
    process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'true';
    process.env['JWT_LEGACY_VERIFY_START'] = undefined;
    process.env['JWT_LEGACY_VERIFY_CUTOFF'] = '2030-01-01T01:00:00.000Z';
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('JWT_LEGACY_VERIFY_START is required when legacy JWT verification is enabled');
  });

  test('requires a cutoff timestamp when legacy verification is enabled', async () => {
    process.env['BFF_ENV'] = 'production';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = VALID_SIGNING_SECRET;
    process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'true';
    process.env['JWT_LEGACY_VERIFY_START'] = '2030-01-01T00:00:00.000Z';
    process.env['JWT_LEGACY_VERIFY_CUTOFF'] = undefined;
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('JWT_LEGACY_VERIFY_CUTOFF is required when legacy JWT verification is enabled');
  });

  test('rejects a cutoff that is not after the immutable start', async () => {
    process.env['BFF_ENV'] = 'production';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = VALID_SIGNING_SECRET;
    process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'true';
    process.env['JWT_LEGACY_VERIFY_START'] = '2030-01-01T01:00:00.000Z';
    process.env['JWT_LEGACY_VERIFY_CUTOFF'] = '2030-01-01T01:00:00.000Z';
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('JWT_LEGACY_VERIFY_CUTOFF must be after JWT_LEGACY_VERIFY_START');
  });

  test('rejects a fixed migration interval longer than two hours', async () => {
    process.env['BFF_ENV'] = 'production';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = VALID_SIGNING_SECRET;
    process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'true';
    process.env['JWT_LEGACY_VERIFY_START'] = '2030-01-01T00:00:00.000Z';
    process.env['JWT_LEGACY_VERIFY_CUTOFF'] = '2030-01-01T02:00:00.001Z';
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('legacy JWT verification window must not exceed 7200000 milliseconds');
  });

  test('accepts an absolute two-hour interval without recomputing it from process start', async () => {
    process.env['BFF_ENV'] = 'production';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = VALID_SIGNING_SECRET;
    process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'true';
    process.env['JWT_LEGACY_VERIFY_START'] = '2020-01-01T00:00:00.000Z';
    process.env['JWT_LEGACY_VERIFY_CUTOFF'] = '2020-01-01T02:00:00.000Z';
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    const mod = await freshEnv();
    expect(mod.env.JWT_LEGACY_VERIFY_ENABLED).toBe(true);
    expect(mod.env.JWT_LEGACY_VERIFY_START).toBe('2020-01-01T00:00:00.000Z');
    expect(mod.env.JWT_LEGACY_VERIFY_CUTOFF).toBe('2020-01-01T02:00:00.000Z');
  });

  test('rejects a calendar-impossible absolute UTC timestamp', async () => {
    process.env['BFF_ENV'] = 'production';
    process.env['JWT_SHARED_SECRET'] = 'a'.repeat(48) + '-real';
    process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-real-key-for-test';
    process.env['JWT_SIGNING_SECRET'] = VALID_SIGNING_SECRET;
    process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'true';
    process.env['JWT_LEGACY_VERIFY_START'] = '2020-02-30T00:00:00.000Z';
    process.env['JWT_LEGACY_VERIFY_CUTOFF'] = '2020-02-30T01:00:00.000Z';
    process.env['CORS_ALLOWED_ORIGINS'] = ORIGINAL['CORS_ALLOWED_ORIGINS'] ?? 'https://example.com';
    process.env['LOG_LEVEL'] = 'error';

    await expect(async () => {
      await freshEnv();
    }).toThrow('JWT_LEGACY_VERIFY_START must be an absolute UTC timestamp ending in Z');
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
