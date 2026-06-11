import { SignJWT, jwtVerify, type JWTPayload } from 'jose';
import { env } from './env';

const ISSUER = 'api.formulaeapps.com';
const ALG = 'HS256';
const TOKEN_LIFETIME_SECONDS = 3600; // 60 minutes max per spec FR-005
const REFRESH_WINDOW_SECONDS = 600; // refresh 10 minutes before expiry

export type SessionClaims = {
  sub: string;
  iss: typeof ISSUER;
  aud: 'formulaeapps-pro' | 'formulaeapps-community';
  jti: string;
  platform: 'web' | 'android' | 'ios' | 'macos';
  app_version: string;
  iat: number;
  exp: number;
};

/**
 * Resolve the secret used to sign/verify session JWTs. Prefers the server-only
 * JWT_SIGNING_SECRET; falls back to the client-shared JWT_SHARED_SECRET when
 * unset so existing deploys keep working (zero-downtime compat).
 *
 * JWT_SHARED_SECRET is baked into client builds for the client_proof HMAC and
 * is therefore extractable from a deployed web bundle / APK. Once
 * JWT_SIGNING_SECRET is set, that leaked shared secret can no longer be used to
 * forge valid session JWTs. Exported for unit tests.
 */
export function resolveSigningSecret(e: {
  JWT_SIGNING_SECRET?: string;
  JWT_SHARED_SECRET: string;
}): string {
  return e.JWT_SIGNING_SECRET ?? e.JWT_SHARED_SECRET;
}

function secretBytes(): Uint8Array {
  return new TextEncoder().encode(resolveSigningSecret(env));
}

export async function issueToken(args: {
  sub: string;
  aud: 'formulaeapps-pro' | 'formulaeapps-community';
  platform: SessionClaims['platform'];
  app_version: string;
  jti: string;
}): Promise<{ token: string; iat: number; exp: number; refresh_after: number }> {
  const iat = Math.floor(Date.now() / 1000);
  const exp = iat + TOKEN_LIFETIME_SECONDS;
  const refresh_after = exp - REFRESH_WINDOW_SECONDS;

  const token = await new SignJWT({
    sub: args.sub,
    aud: args.aud,
    jti: args.jti,
    platform: args.platform,
    app_version: args.app_version,
  })
    .setProtectedHeader({ alg: ALG })
    .setIssuer(ISSUER)
    .setIssuedAt(iat)
    .setExpirationTime(exp)
    .sign(secretBytes());

  return { token, iat, exp, refresh_after };
}

export async function verifyToken(token: string): Promise<SessionClaims> {
  const { payload } = await jwtVerify(token, secretBytes(), {
    algorithms: [ALG],
    issuer: ISSUER,
  });

  // Validate the payload shape — jose returns a generic JWTPayload.
  const p = payload as JWTPayload;
  if (
    typeof p.sub !== 'string' ||
    typeof p.iss !== 'string' ||
    typeof p.aud !== 'string' ||
    typeof p.jti !== 'string' ||
    typeof (p as { platform?: unknown }).platform !== 'string' ||
    typeof (p as { app_version?: unknown }).app_version !== 'string' ||
    typeof p.iat !== 'number' ||
    typeof p.exp !== 'number'
  ) {
    throw new Error('Invalid JWT payload shape');
  }

  const aud = p.aud as SessionClaims['aud'];
  if (aud !== 'formulaeapps-pro' && aud !== 'formulaeapps-community') {
    throw new Error(`Unexpected JWT audience: ${aud}`);
  }

  const platform = (p as { platform: string }).platform as SessionClaims['platform'];
  if (!['web', 'android', 'ios', 'macos'].includes(platform)) {
    throw new Error(`Unexpected JWT platform: ${platform}`);
  }

  return {
    sub: p.sub,
    iss: ISSUER,
    aud,
    jti: p.jti,
    platform,
    app_version: (p as { app_version: string }).app_version,
    iat: p.iat,
    exp: p.exp,
  };
}

/** Returns true when the token is past its `refresh_after` boundary but still valid. */
export function shouldRefresh(claims: SessionClaims): boolean {
  const now = Math.floor(Date.now() / 1000);
  const refresh_after = claims.exp - REFRESH_WINDOW_SECONDS;
  return now >= refresh_after && now < claims.exp;
}

export const JWT_CONSTANTS = {
  ISSUER,
  ALG,
  TOKEN_LIFETIME_SECONDS,
  REFRESH_WINDOW_SECONDS,
};
