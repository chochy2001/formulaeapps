import { createRoute } from '@hono/zod-openapi';
import type { AppContext } from '../lib/openapi';
import { IapValidateRequestSchema, IapValidateResponseSchema } from '../schemas/iap';
import { ErrorEnvelopeSchema, errorEnvelope } from '../schemas/error';
import { createAppleIapValidator } from '../services/apple-iap';
import { createGoogleIapValidator } from '../services/google-iap';
import { checkIapAvailability } from '../services/iap-availability';
import {
  grantMobileEntitlement,
  paymentSourceFromPlatform,
} from '../services/entitlements-store';
import { issueToken, shouldRefresh } from '../lib/jwt';
import { randomUUID } from 'node:crypto';

export const iapValidateRoute = createRoute({
  method: 'post',
  path: '/iap/validate',
  tags: ['iap'],
  summary: 'Validate an Apple or Google IAP receipt server-side',
  description:
    'Uses the official Apple/Google SDKs with secrets mounted at runtime. ' +
    'Returns a normalized result without leaking the raw provider response.',
  security: [{ bearerAuth: [] }],
  request: {
    body: {
      required: true,
      content: { 'application/json': { schema: IapValidateRequestSchema } },
    },
  },
  responses: {
    200: {
      description: 'Validation completed',
      content: { 'application/json': { schema: IapValidateResponseSchema } },
      headers: {
        'X-Auth-Refresh': {
          schema: { type: 'string' },
          description: 'Optional rotated JWT.',
        },
      },
    },
    400: { description: 'Bad request', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    401: { description: 'Unauthorized', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    429: { description: 'Rate limited', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    502: { description: 'Upstream error', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    500: { description: 'Internal error', content: { 'application/json': { schema: ErrorEnvelopeSchema } } },
    503: {
      description: 'IAP validation not configured on this BFF instance',
      content: { 'application/json': { schema: ErrorEnvelopeSchema } },
    },
  },
});

export const iapValidateHandler = async (c: AppContext): Promise<Response> => {
  const body = (c.req as unknown as { valid: (t: 'json') => { platform: 'apple' | 'google'; product_id: string; transaction_id: string; receipt_data: string; subscription: boolean } }).valid('json');

  // Detect missing-or-placeholder secrets BEFORE constructing the SDK so the
  // client gets a clean envelope instead of a leaked jsonwebtoken / googleapis
  // construction error. See src/services/iap-availability.ts for the rules.
  const availability = await checkIapAvailability(body.platform);
  if (!availability.available) {
    const requestId = c.get('request_id') ?? randomUUID();
    return c.json(
      errorEnvelope(
        'internal_error',
        `IAP validation unavailable for ${body.platform}: ${availability.reason}`,
        requestId,
        'E_IAP_VALIDATION_UNAVAILABLE',
      ),
      503,
    );
  }

  const validator =
    body.platform === 'apple'
      ? await createAppleIapValidator()
      : await createGoogleIapValidator();

  const result = await validator.validate(body);

  const claims = c.get('jwt_claims');

  // WP5 step 1 + #86: persist mobile entitlement on successful IAP validation.
  // Scope is hardcoded `mobile` — never Polar/web from this path.
  // FE still gates calls with ENABLE_BFF_IAP_VALIDATION (default off).
  // user_id is written only when ENABLE_USER_ACCOUNT_AUTH is on (store helper).
  if (result.valid && claims?.sub) {
    try {
      grantMobileEntitlement({
        subject: claims.sub,
        payment_source: paymentSourceFromPlatform(body.platform),
        product_id: result.product_id,
        raw_receipt_ref: result.transaction_id,
        user_id: claims.user_id,
      });
    } catch (err) {
      // Persistence must not fail the validate response; FE still has local IAP.
      // eslint-disable-next-line no-console
      console.warn(
        `[entitlements] grant failed for sub=${claims.sub}: ${err instanceof Error ? err.message : String(err)}`,
      );
    }
  }

  // Rotate JWT if close to expiry.
  if (claims && shouldRefresh(claims)) {
    const { token } = await issueToken({
      sub: claims.sub,
      aud: claims.aud,
      platform: claims.platform,
      app_version: claims.app_version,
      jti: randomUUID(),
      user_id: claims.user_id,
    });
    c.header('X-Auth-Refresh', token);
  }

  return c.json(result, 200);
};
