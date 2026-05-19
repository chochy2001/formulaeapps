import { createApp, CONTRACT_VERSION } from './lib/openapi';
import { loggerMiddleware } from './middleware/logger';
import { corsMiddleware } from './middleware/cors';
import { jwtAuthMiddleware } from './middleware/jwt-auth';
import { errorHandler } from './middleware/error';
import { healthRoute, healthHandler } from './routes/health';
import { authTokenRoute, authTokenHandler } from './routes/auth';
import { chatRoute, chatHandler } from './routes/chat';
import { iapValidateRoute, iapValidateHandler } from './routes/iap';
import { env } from './lib/env';

export const app = createApp();

// Global middleware (order matters)
app.use('*', loggerMiddleware);
app.use('*', corsMiddleware);
app.onError(errorHandler);

// Public routes (no JWT required)
app.openapi(healthRoute, healthHandler as never);
app.openapi(authTokenRoute, authTokenHandler as never);

// Auth-gated routes — JWT middleware applied before route handlers
app.use('/openai/*', jwtAuthMiddleware);
app.use('/iap/*', jwtAuthMiddleware);
app.openapi(chatRoute, chatHandler as never);
app.openapi(iapValidateRoute, iapValidateHandler as never);

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

// Bun-native server config — runs only when bun runs this file as entry point.
export default {
  port: env.BFF_PORT,
  fetch: app.fetch,
};
