// Test preload — runs once before every test file.
// Provides deterministic env vars so env.ts doesn't throw on import.
// Configured via bunfig.toml [test] preload entry.

import { createHash } from 'node:crypto';

process.env['BFF_ENV'] = 'development';
process.env['BFF_PORT'] = '3000';
process.env['JWT_SHARED_SECRET'] =
  'test-secret-' + 'a'.repeat(48); // 60 chars, non-placeholder pattern
process.env['JWT_SIGNING_SECRET'] = createHash('sha256')
  .update('formulae-bff-test-signing-key')
  .digest('hex');
process.env['JWT_LEGACY_VERIFY_ENABLED'] = 'false';
process.env['JWT_LEGACY_VERIFY_START'] = undefined;
process.env['JWT_LEGACY_VERIFY_CUTOFF'] = undefined;
process.env['OPENROUTER_API_KEY'] = 'sk-or-v1-test-key-for-bff-unit-tests';
process.env['OPENROUTER_DEFAULT_MODEL'] = 'openai/gpt-4o-mini';
process.env['OPENROUTER_MODEL_ALLOWLIST'] =
  'openai/gpt-4o-mini,openai/gpt-4o,anthropic/claude-3.5-haiku,anthropic/claude-haiku-4.5,anthropic/claude-3.5-sonnet,google/gemini-2.0-flash-001,google/gemini-2.0-flash-lite-001';
process.env['OPENROUTER_HTTP_REFERER'] = 'https://test.formulaeapps.com';
process.env['OPENROUTER_X_TITLE'] = 'FormulaeApps BFF Tests';
process.env['CORS_ALLOWED_ORIGINS'] =
  'https://app.formulaeapps.com,https://formulaeapps.com';
process.env['LOG_LEVEL'] = 'error'; // quiet logs during tests
process.env['BFF_VERSION'] = '0.0.0-test';
// Ephemeral SQLite DBs for tests; never touch shared files.
process.env['ENTITLEMENTS_DB_PATH'] = ':memory:';
process.env['ACCOUNTS_DB_PATH'] = ':memory:';

// Disable the in-process rate limiters for the shared-app integration suites
// (every test hits the same 'unknown' IP bucket; a low default would cause
// cross-test interference). Dedicated rate-limit tests construct their own
// limiter instances with explicit low limits.
process.env['RATE_LIMIT_AUTH_MAX'] = '0';
process.env['RATE_LIMIT_CHAT_MAX'] = '0';
