import { createApp, CONTRACT_VERSION } from './lib/openapi';
import { loggerMiddleware } from './middleware/logger';
import { corsMiddleware } from './middleware/cors';
import { jwtAuthMiddleware } from './middleware/jwt-auth';
import { errorHandler } from './middleware/error';
import { authRateLimiter, chatRateLimiter } from './middleware/limiters';
import { healthRoute, healthHandler } from './routes/health';
import { authTokenRoute, authTokenHandler } from './routes/auth';
import {
  authRegisterRoute,
  authRegisterHandler,
  authLoginRoute,
  authLoginHandler,
} from './routes/account-auth';
import { chatRoute, chatHandler } from './routes/chat';
import { iapValidateRoute, iapValidateHandler } from './routes/iap';
import { entitlementGetRoute, entitlementGetHandler } from './routes/entitlement';
import { checkIapAvailability, formatAvailability } from './services/iap-availability';
import { env } from './lib/env';

export const app = createApp();

// Global middleware (order matters)
app.use('*', loggerMiddleware);
app.use('*', corsMiddleware);
app.onError(errorHandler);

// Per-IP rate limiting (defense-in-depth under Traefik api-ratelimit@file).
// Auth limiter runs on the public token route; chat limiter runs after the JWT
// middleware so it can key on the authenticated sub.
app.use('/auth/token', authRateLimiter.middleware);
app.use('/auth/register', authRateLimiter.middleware);
app.use('/auth/login', authRateLimiter.middleware);

// Public routes (no JWT required)
app.openapi(healthRoute, healthHandler as never);
app.openapi(authTokenRoute, authTokenHandler as never);
// Account stubs (fleet #86) — 403 while ENABLE_USER_ACCOUNT_AUTH is off.
app.openapi(authRegisterRoute, authRegisterHandler as never);
app.openapi(authLoginRoute, authLoginHandler as never);

// Auth-gated routes — JWT middleware applied before route handlers
app.use('/openai/*', jwtAuthMiddleware);
app.use('/openai/*', chatRateLimiter.middleware);
app.use('/iap/*', jwtAuthMiddleware);
app.use('/entitlement', jwtAuthMiddleware);
app.openapi(chatRoute, chatHandler as never);
app.openapi(iapValidateRoute, iapValidateHandler as never);
app.openapi(entitlementGetRoute, entitlementGetHandler as never);

// OpenAPI document endpoint — also used by export-openapi.ts script
app.doc('/openapi.json', {
  openapi: '3.1.0',
  info: {
    title: 'FormulaeApps BFF',
    version: CONTRACT_VERSION,
    description:
      'Backend-for-Frontend for FormulaeApps Pro + Community. Proxies OpenAI chat, ' +
      'validates Apple/Google IAP receipts, issues short-lived HS256 JWTs.',
  },
  servers: [
    { url: 'https://api.formulaeapps.com', description: 'Production (VPS Contabo)' },
    { url: 'http://localhost:3000', description: 'Local dev' },
  ],
});

// Register the bearer security scheme so route security: [{ bearerAuth: [] }] resolves
app.openAPIRegistry.registerComponent('securitySchemes', 'bearerAuth', {
  type: 'http',
  scheme: 'bearer',
  bearerFormat: 'JWT',
  description: 'HS256-signed JWT issued by POST /auth/token.',
});

// One-shot startup probe — surfaces missing/placeholder IAP secrets in the
// logs at boot so ops can spot a misconfigured deploy without waiting for the
// first /iap/validate call. Non-fatal: BFF must boot regardless (other routes
// keep working). See src/services/iap-availability.ts for the rules.
void (async (): Promise<void> => {
  const [apple, google] = await Promise.all([
    checkIapAvailability('apple'),
    checkIapAvailability('google'),
  ]);
  // eslint-disable-next-line no-console
  console.warn(
    `[iap] startup check: apple=${formatAvailability(apple)} google=${formatAvailability(google)}`,
  );
})();

// Bun-native server config — runs only when bun runs this file as entry point.
export default {
  port: env.BFF_PORT,
  fetch: app.fetch,
};
