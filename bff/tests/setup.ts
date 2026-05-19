// Test preload — runs once before every test file.
// Provides deterministic env vars so env.ts doesn't throw on import.
// Configured via bunfig.toml [test] preload entry.

process.env['BFF_ENV'] = 'development';
process.env['BFF_PORT'] = '3000';
process.env['JWT_SHARED_SECRET'] =
  'test-secret-' + 'a'.repeat(48); // 60 chars, non-placeholder pattern
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
