import { z } from 'zod';

const PLACEHOLDER_PATTERNS = [
  'placeholder_dev_not_for_prod',
  'replace-with-real-hex-secret',
  'replace-me',
];

/** Hard ceiling for legacy JWT verification windows (2 hours). */
export const MAX_LEGACY_WINDOW_MILLIS = 2 * 60 * 60 * 1000;

const isPlaceholder = (v: string): boolean => {
  const normalized = v.toLowerCase();
  return v.length === 0 || PLACEHOLDER_PATTERNS.some((p) => normalized.includes(p));
};

const hasObviouslyWeakPattern = (value: string): boolean => {
  const frequencies = new Map<string, number>();
  for (const character of value.toLowerCase()) {
    frequencies.set(character, (frequencies.get(character) ?? 0) + 1);
  }
  if (Math.max(...frequencies.values()) >= value.length - 1) {
    return true;
  }

  for (let patternLength = 1; patternLength <= value.length / 2; patternLength++) {
    if (
      value.length % patternLength === 0 &&
      value.slice(0, patternLength).repeat(value.length / patternLength) === value
    ) {
      return true;
    }
  }
  return false;
};

/** Reject calendar-impossible values that Date.parse would otherwise normalize. */
const isExactAbsoluteUtcTimestamp = (value: string): boolean => {
  if (!/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{1,3})?Z$/.test(value)) {
    return false;
  }
  const millis = Date.parse(value);
  if (Number.isNaN(millis)) {
    return false;
  }
  const normalize = (raw: string): string | null => {
    const match = raw.match(/^(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})(?:\.(\d{1,3}))?Z$/);
    if (!match || match[1] === undefined) {
      return null;
    }
    return `${match[1]}.${(match[2] ?? '').padEnd(3, '0')}Z`;
  };
  const expected = normalize(value);
  const actual = normalize(new Date(millis).toISOString());
  return expected !== null && actual !== null && expected === actual;
};

const absoluteUtcTimestamp = (name: string) =>
  z
    .string()
    .optional()
    .transform((v) => (v !== undefined && v.length > 0 ? v : undefined))
    .refine((v) => v === undefined || isExactAbsoluteUtcTimestamp(v), {
      message: `${name} must be an absolute UTC timestamp ending in Z`,
    });

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
  // any client build. Development may omit it for local compatibility, but
  // production fails closed when it is absent so the client-shared secret can
  // never become the production JWT signing key.
  JWT_SIGNING_SECRET: z
    .string()
    .optional()
    .transform((v) => (v !== undefined && v.length > 0 ? v : undefined)),

  // Temporary migration controls. Start and cutoff are absolute UTC instants,
  // so process restarts cannot recompute or extend the verification window.
  JWT_LEGACY_VERIFY_ENABLED: z
    .enum(['true', 'false'])
    .default('false')
    .transform((v) => v === 'true'),
  JWT_LEGACY_VERIFY_START: absoluteUtcTimestamp('JWT_LEGACY_VERIFY_START'),
  JWT_LEGACY_VERIFY_CUTOFF: absoluteUtcTimestamp('JWT_LEGACY_VERIFY_CUTOFF'),

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
    if (isPlaceholder(env.OPENROUTER_API_KEY)) {
      throw new Error(
        `OPENROUTER_API_KEY appears to be a placeholder in ${env.BFF_ENV} environment.`,
      );
    }
  }

  if (env.BFF_ENV !== 'development' && env.JWT_SIGNING_SECRET === undefined) {
    throw new Error(`JWT_SIGNING_SECRET is required in ${env.BFF_ENV} environment.`);
  }

  if (env.JWT_SIGNING_SECRET !== undefined) {
    if (isPlaceholder(env.JWT_SIGNING_SECRET)) {
      throw new Error(
        `JWT_SIGNING_SECRET appears to be a placeholder in ${env.BFF_ENV} environment. ` +
          'Provide an independently generated server-only secret.',
      );
    }
    if (env.JWT_SIGNING_SECRET === env.JWT_SHARED_SECRET) {
      throw new Error('JWT_SIGNING_SECRET must differ from JWT_SHARED_SECRET.');
    }
    if (!/^[0-9a-fA-F]{64}$/.test(env.JWT_SIGNING_SECRET)) {
      throw new Error(
        `JWT_SIGNING_SECRET must be exactly 64 hexadecimal characters in ${env.BFF_ENV} environment.`,
      );
    }
    // This rejects obvious low-effort values; it is not a mathematical entropy
    // proof. Operators must still generate the 32 bytes with a CSPRNG.
    if (hasObviouslyWeakPattern(env.JWT_SIGNING_SECRET)) {
      throw new Error('JWT_SIGNING_SECRET must not use a trivially repeated pattern.');
    }
  }

  if (env.JWT_LEGACY_VERIFY_ENABLED && env.JWT_LEGACY_VERIFY_START === undefined) {
    throw new Error(
      'JWT_LEGACY_VERIFY_START is required when legacy JWT verification is enabled.',
    );
  }

  if (env.JWT_LEGACY_VERIFY_ENABLED && env.JWT_LEGACY_VERIFY_CUTOFF === undefined) {
    throw new Error(
      'JWT_LEGACY_VERIFY_CUTOFF is required when legacy JWT verification is enabled.',
    );
  }

  if (
    env.JWT_LEGACY_VERIFY_ENABLED &&
    env.JWT_LEGACY_VERIFY_START !== undefined &&
    env.JWT_LEGACY_VERIFY_CUTOFF !== undefined
  ) {
    const startMillis = Date.parse(env.JWT_LEGACY_VERIFY_START);
    const cutoffMillis = Date.parse(env.JWT_LEGACY_VERIFY_CUTOFF);
    if (cutoffMillis <= startMillis) {
      throw new Error('JWT_LEGACY_VERIFY_CUTOFF must be after JWT_LEGACY_VERIFY_START.');
    }
    if (cutoffMillis - startMillis > MAX_LEGACY_WINDOW_MILLIS) {
      throw new Error(
        `legacy JWT verification window must not exceed ${MAX_LEGACY_WINDOW_MILLIS} milliseconds.`,
      );
    }
  }

  return env;
}

export const env: Env = parseEnv();
export const isProd = env.BFF_ENV === 'production';
export const isDev = env.BFF_ENV === 'development';
