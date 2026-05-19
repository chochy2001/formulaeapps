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

  JWT_SHARED_SECRET: z.string().min(1, 'JWT_SHARED_SECRET is required'),
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
      //   anthropic/claude-haiku-4.5         ~$1.00/M   in,  ~$5.00/M out
      //   anthropic/claude-3.5-haiku         ~$0.80/M   in,  ~$4.00/M out
      //   openai/gpt-4o                      ~$2.50/M   in,  ~$10.00/M out
      //   anthropic/claude-3.5-sonnet        ~$3.00/M   in,  ~$15.00/M out
      'openai/gpt-4o-mini,openai/gpt-4o,anthropic/claude-3.5-haiku,anthropic/claude-haiku-4.5,anthropic/claude-3.5-sonnet,google/gemini-2.0-flash-001,google/gemini-2.0-flash-lite-001',
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
    if (isPlaceholder(env.OPENROUTER_API_KEY)) {
      throw new Error(
        `OPENROUTER_API_KEY appears to be a placeholder in ${env.BFF_ENV} environment.`,
      );
    }
  }

  return env;
}

export const env: Env = parseEnv();
export const isProd = env.BFF_ENV === 'production';
export const isDev = env.BFF_ENV === 'development';
