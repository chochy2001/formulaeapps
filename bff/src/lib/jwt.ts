import { SignJWT, jwtVerify, type JWTPayload } from 'jose';
import { env, MAX_LEGACY_WINDOW_MILLIS } from './env';

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

export type JwtKeyConfig = {
  JWT_SIGNING_SECRET?: string;
  JWT_SHARED_SECRET: string;
  JWT_LEGACY_VERIFY_ENABLED?: boolean;
  JWT_LEGACY_VERIFY_START?: string;
  JWT_LEGACY_VERIFY_CUTOFF?: string;
};

type IssueTokenArgs = {
  sub: string;
  aud: 'formulaeapps-pro' | 'formulaeapps-community';
  platform: SessionClaims['platform'];
  app_version: string;
  jti: string;
};

/**
 * Resolve the only secret permitted for signing new session JWTs.
 *
 * JWT_SHARED_SECRET is baked into client builds for the client_proof HMAC and
 * is therefore extractable from a deployed web bundle / APK. It must never be
 * used to sign new JWTs. Exported for focused migration tests.
 */
export function resolveSigningSecret(e: JwtKeyConfig): string {
  if (e.JWT_SIGNING_SECRET === undefined) {
    throw new Error('JWT_SIGNING_SECRET is required to issue session JWTs');
  }
  return e.JWT_SIGNING_SECRET;
}

function secretBytes(secret: string): Uint8Array {
  return new TextEncoder().encode(secret);
}

export async function issueTokenWithConfig(
  args: IssueTokenArgs,
  keyConfig: JwtKeyConfig,
  nowSeconds = Math.floor(Date.now() / 1000),
): Promise<{ token: string; iat: number; exp: number; refresh_after: number }> {
  const iat = nowSeconds;
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
    .sign(secretBytes(resolveSigningSecret(keyConfig)));

  return { token, iat, exp, refresh_after };
}

export async function issueToken(
  args: IssueTokenArgs,
): Promise<{ token: string; iat: number; exp: number; refresh_after: number }> {
  return await issueTokenWithConfig(args, env);
}

async function verifyWithSecret(
  token: string,
  secret: string,
  nowMillis: number,
): Promise<JWTPayload> {
  const { payload } = await jwtVerify(token, secretBytes(secret), {
    algorithms: [ALG],
    issuer: ISSUER,
    currentDate: new Date(nowMillis),
  });
  return payload;
}

/**
 * Returns true only when legacy JWT verification is explicitly enabled and
 * `nowMillis` falls in the immutable half-open interval `[start, cutoff)`.
 *
 * Fail-closed for invalid windows even when called directly (not via env
 * parsing): `cutoff <= start`, duration `> MAX_LEGACY_WINDOW_MILLIS`, NaN
 * timestamps, or missing/disabled config all return false.
 */
export function legacyVerificationAllowed(keyConfig: JwtKeyConfig, nowMillis: number): boolean {
  if (
    keyConfig.JWT_LEGACY_VERIFY_ENABLED !== true ||
    keyConfig.JWT_LEGACY_VERIFY_START === undefined ||
    keyConfig.JWT_LEGACY_VERIFY_CUTOFF === undefined
  ) {
    return false;
  }
  const startMillis = Date.parse(keyConfig.JWT_LEGACY_VERIFY_START);
  const cutoffMillis = Date.parse(keyConfig.JWT_LEGACY_VERIFY_CUTOFF);
  if (Number.isNaN(startMillis) || Number.isNaN(cutoffMillis)) {
    return false;
  }
  // Reject inverted/empty windows and anything longer than the hard ceiling.
  if (cutoffMillis <= startMillis || cutoffMillis - startMillis > MAX_LEGACY_WINDOW_MILLIS) {
    return false;
  }
  return nowMillis >= startMillis && nowMillis < cutoffMillis;
}

export async function verifyTokenWithConfig(
  token: string,
  keyConfig: JwtKeyConfig,
  nowMillis = Date.now(),
): Promise<SessionClaims> {
  let payload: JWTPayload;
  try {
    payload = await verifyWithSecret(token, resolveSigningSecret(keyConfig), nowMillis);
  } catch (newKeyError) {
    if (!legacyVerificationAllowed(keyConfig, nowMillis)) {
      throw newKeyError;
    }
    payload = await verifyWithSecret(token, keyConfig.JWT_SHARED_SECRET, nowMillis);
  }

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

export async function verifyToken(token: string): Promise<SessionClaims> {
  return await verifyTokenWithConfig(token, env);
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
