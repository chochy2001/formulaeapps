import { z } from 'zod';

const PLACEHOLDER_PATTERNS = [
  'PLACEHOLDER_DEV_NOT_FOR_PROD',
  'replace-with-real-hex-secret',
  'replace-me',
];

const isPlaceholder = (v: string): boolean =>
  v.length === 0 || PLACEHOLDER_PATTERNS.some((p) => v.includes(p));

const envSchema = z.object({
  BFF_ENV: z.enum(['development', 'staging', 'production']).default('development'),
  BFF_PORT: z.coerce.number().int().min(1).max(65535).default(3000),

  // Client-shared secret. Baked into the Flutter Pro/Community bundles via
  // --dart-define and used by both BFF and clients to compute the client_proof
  // HMAC. It is therefore extractable from a deployed web bundle / APK, so it
  // MUST NOT be the only thing protecting session-JWT signing — see
  // JWT_SIGNING_SECRET below.
  JWT_SHARED_SECRET: z.string().min(1, 'JWT_SHARED_SECRET is required'),

  // Server-only secret used to sign/verify session JWTs (HS256). Never ships in
  // any client build. When unset, JWT signing falls back to JWT_SHARED_SECRET
  // so existing deploys keep working with zero downtime; production logs a
  // warning at boot until a dedicated secret is set. Once set, a leaked
  // JWT_SHARED_SECRET can no longer be used to forge valid session JWTs.
  JWT_SIGNING_SECRET: z
    .string()
    .optional()
    .transform((v) => (v !== undefined && v.length > 0 ? v : undefined)),

  OPENROUTER_API_KEY: z.string().min(1, 'OPENROUTER_API_KEY is required'),

  // model_id is OpenRouter's `provider/model` format. Update the allowlist when
  // adopting new models; see https://openrouter.ai/models for the live catalog.
  OPENROUTER_DEFAULT_MODEL: z.string().default('openai/gpt-4o-mini'),
  OPENROUTER_MODEL_ALLOWLIST: z
    .string()
    .default(
      // Verified currently available on OpenRouter 2026-05-19, cost-ranked (cheapest first):
      //   google/gemini-2.0-flash-lite-001   ~$0.075/M  in,  ~$0.30/M out
      //   google/gemini-2.0-flash-001        ~$0.10/M   in,  ~$0.40/M out
      //   openai/gpt-4o-mini                 ~$0.15/M   in,  ~$0.60/M out  ← default
      //   anthropic/claude-3.5-haiku         ~$0.80/M   in,  ~$4.00/M out
      //   anthropic/claude-haiku-4.5         ~$1.00/M   in,  ~$5.00/M out
      //   openai/gpt-4o                      ~$2.50/M   in,  ~$10.00/M out
      // (anthropic/claude-3.5-sonnet removed 2026-05-19 — silently pulled from
      //  OpenRouter catalog; if a Sonnet tier is needed, re-evaluate against the
      //  live catalog and re-add an active model id. Validated by probe-allowlist.)
      'openai/gpt-4o-mini,openai/gpt-4o,anthropic/claude-3.5-haiku,anthropic/claude-haiku-4.5,google/gemini-2.0-flash-001,google/gemini-2.0-flash-lite-001',
    )
    .transform((s) =>
      s
        .split(',')
        .map((m) => m.trim())
        .filter(Boolean),
    ),

  // Attribution headers OpenRouter uses for model ranking on
  // https://openrouter.ai/rankings. Optional but recommended.
  OPENROUTER_HTTP_REFERER: z.string().default('https://formulaeapps.com'),
  OPENROUTER_X_TITLE: z.string().default('FormulaeApps'),

  CORS_ALLOWED_ORIGINS: z
    .string()
    .default('https://app.formulaeapps.com,https://formulaeapps.com')
    .transform((s) =>
      s
        .split(',')
        .map((o) => o.trim())
        .filter(Boolean),
    ),

  APPLE_P8_FILE: z.string().optional(),
  APPLE_ISSUER_ID: z.string().optional(),
  APPLE_KEY_ID: z.string().optional(),
  APPLE_BUNDLE_ID: z.string().optional(),

  GOOGLE_SA_FILE: z.string().optional(),
  GOOGLE_PACKAGE_NAME: z.string().optional(),

  LOG_LEVEL: z.enum(['debug', 'info', 'warn', 'error']).default('info'),

  BFF_VERSION: z.string().default('0.1.0'),

  // In-process rate limiting (defense-in-depth under the Traefik
  // api-ratelimit@file edge middleware). Per-IP fixed-window limits. Defaults
  // are well above human-paced bursts (app cold-start token mint, chat usage)
  // and below abusive-loop volumes; tune via env without a code change. Set the
  // limit to 0 to disable a given limiter.
  RATE_LIMIT_WINDOW_SECONDS: z.coerce.number().int().min(1).max(3600).default(60),
  RATE_LIMIT_AUTH_MAX: z.coerce.number().int().min(0).max(100000).default(30),
  RATE_LIMIT_CHAT_MAX: z.coerce.number().int().min(0).max(100000).default(60),
});

export type Env = z.infer<typeof envSchema>;

function parseEnv(): Env {
  const parsed = envSchema.safeParse(process.env);
  if (!parsed.success) {
    const issues = parsed.error.issues.map((i) => `  - ${i.path.join('.')}: ${i.message}`).join('\n');
    throw new Error(`Invalid env configuration:\n${issues}`);
  }
  const env = parsed.data;

  // Reject placeholder secrets in production / staging — never let them ship.
  if (env.BFF_ENV !== 'development') {
    if (isPlaceholder(env.JWT_SHARED_SECRET)) {
      throw new Error(
        `JWT_SHARED_SECRET appears to be a placeholder in ${env.BFF_ENV} environment. ` +
          `Provide a real secret (openssl rand -hex 32).`,
      );
    }
    if (env.JWT_SIGNING_SECRET !== undefined && isPlaceholder(env.JWT_SIGNING_SECRET)) {
      throw new Error(
        `JWT_SIGNING_SECRET appears to be a placeholder in ${env.BFF_ENV} environment. ` +
          `Provide a real secret (openssl rand -hex 32) or unset it to fall back to JWT_SHARED_SECRET.`,
      );
    }
    if (isPlaceholder(env.OPENROUTER_API_KEY)) {
      throw new Error(
        `OPENROUTER_API_KEY appears to be a placeholder in ${env.BFF_ENV} environment.`,
      );
    }
  }

  if (env.BFF_ENV === 'production' && env.JWT_SIGNING_SECRET === undefined) {
    // eslint-disable-next-line no-console
    console.warn(
      '[env] JWT_SIGNING_SECRET is not set — session JWTs are signed with the ' +
        'client-shared JWT_SHARED_SECRET, which is extractable from client bundles. ' +
        'Set a server-only JWT_SIGNING_SECRET (openssl rand -hex 32) and recreate ' +
        'the bff container to make session JWTs unforgeable.',
    );
  }

  return env;
}

export const env: Env = parseEnv();
export const isProd = env.BFF_ENV === 'production';
export const isDev = env.BFF_ENV === 'development';
