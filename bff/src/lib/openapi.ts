import { OpenAPIHono } from '@hono/zod-openapi';
import type { Context, Next } from 'hono';
import type { SessionClaims } from './jwt';

// FormulaeApps BFF OpenAPI/contract version. Bumped on every schema change;
// surfaces in the exported contracts/bff.openapi.yaml info.version field.
//
// Bump rules (research §R13):
// - MAJOR: breaking change (field renamed, response type changed, route removed).
// - MINOR: additive (new route, new optional field, new error code).
// - PATCH: non-semantic (description, example, examples).
// 2.0.0 removes the unproved account register/login `client_id` field. Clients
// must regenerate rather than silently sending a field the server now rejects.
// 2.1.0 adds POST /auth/oauth stub (Google/Apple) — 503 until providers wired.
export const CONTRACT_VERSION = '2.1.0';
export type AppEnv = {
  Variables: {
    request_id: string;
    jwt_claims?: SessionClaims;
  };
};

/**
 * Create a fresh OpenAPIHono instance with the FormulaeApps app type bound.
 * Routes attach via `app.openapi(routeDef, handler)`; middleware via `app.use`.
 */
export function createApp(): OpenAPIHono<AppEnv> {
  return new OpenAPIHono<AppEnv>();
}

export type AppContext = Context<AppEnv>;
export type AppMiddleware = (c: AppContext, next: Next) => Promise<void | Response>;
