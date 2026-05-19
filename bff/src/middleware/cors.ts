import { cors } from 'hono/cors';
import { env, isDev } from '../lib/env';

const DEV_ORIGINS = [
  'http://localhost:4321', // landing dev
  'http://localhost:8080', // Pro Web dev (default flutter run -d chrome)
  'http://localhost:3000', // BFF self-call during dev
];

/**
 * CORS middleware with an exact-match origin allowlist per research §R8 and
 * spec §FR-031. Wildcard "*" origins are prohibited in production.
 *
 * In development, localhost origins are also accepted. In production / staging,
 * only the configured CORS_ALLOWED_ORIGINS are honored.
 */
export const corsMiddleware = cors({
  origin: (origin) => {
    if (!origin) return null;
    const allowed = isDev ? [...env.CORS_ALLOWED_ORIGINS, ...DEV_ORIGINS] : env.CORS_ALLOWED_ORIGINS;
    return allowed.includes(origin) ? origin : null;
  },
  allowMethods: ['GET', 'POST', 'OPTIONS'],
  allowHeaders: ['Content-Type', 'Authorization'],
  exposeHeaders: ['X-Auth-Refresh', 'X-Request-Id'],
  credentials: false,
  maxAge: 600,
});
