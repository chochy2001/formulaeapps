import { randomUUID } from 'node:crypto';
import { issueToken, JWT_CONSTANTS, type SessionClaims } from '../lib/jwt';
import { BffError } from '../middleware/error';
import type {
  AccountAuthResponse,
  AccountLoginRequest,
  AccountRegisterRequest,
} from '../schemas/account-auth';
import { bindEntitlementsUserId } from './entitlements-store';
import { hashClientId } from './jwt-issuer';
import { authenticateUser, createUser } from './users-store';

/**
 * Account register/login service (fleet #86).
 * Callers must gate on ENABLE_USER_ACCOUNT_AUTH before invoking.
 *
 * JWT always includes claim `user_id`. When optional `client_id` is sent,
 * `sub` matches the device-session hash from POST /auth/token and prior
 * mobile entitlements are bound to the account. Otherwise `sub` is
 * `user:<uuid>`.
 */

const DEFAULT_PLATFORM: SessionClaims['platform'] = 'web';
const DEFAULT_APP_VERSION = '0.0.0';
const ACCOUNT_AUD: SessionClaims['aud'] = 'formulaeapps-pro';

type AccountSessionOpts = {
  userId: string;
  platform?: SessionClaims['platform'];
  app_version?: string;
  client_id?: string;
};

function resolveSubject(userId: string, clientId?: string): string {
  if (clientId && clientId.trim().length > 0) {
    return hashClientId(clientId.trim());
  }
  return `user:${userId}`;
}

async function issueAccountToken(opts: AccountSessionOpts): Promise<AccountAuthResponse> {
  const subject = resolveSubject(opts.userId, opts.client_id);
  if (opts.client_id?.trim()) {
    bindEntitlementsUserId(subject, opts.userId);
  }

  const { token, exp } = await issueToken({
    sub: subject,
    aud: ACCOUNT_AUD,
    platform: opts.platform ?? DEFAULT_PLATFORM,
    app_version: opts.app_version ?? DEFAULT_APP_VERSION,
    jti: randomUUID(),
    user_id: opts.userId,
  });
  return {
    token,
    expires_at: new Date(exp * 1000).toISOString(),
    user_id: opts.userId,
  };
}

export async function registerAccount(
  req: AccountRegisterRequest,
): Promise<AccountAuthResponse> {
  try {
    const user = await createUser(req.email, req.password);
    return await issueAccountToken({
      userId: user.id,
      platform: req.platform,
      app_version: req.app_version,
      client_id: req.client_id,
    });
  } catch (err) {
    if (err instanceof Error && (err.name === 'EmailTakenError' || err.message === 'EMAIL_TAKEN')) {
      throw new BffError('bad_request', 'Email already registered', 'E_EMAIL_TAKEN');
    }
    throw err;
  }
}

export async function loginAccount(req: AccountLoginRequest): Promise<AccountAuthResponse> {
  const user = await authenticateUser(req.email, req.password);
  if (!user) {
    throw new BffError('unauthorized', 'Invalid email or password', 'E_INVALID_CREDENTIALS');
  }
  return await issueAccountToken({
    userId: user.id,
    platform: req.platform,
    app_version: req.app_version,
    client_id: req.client_id,
  });
}

export const ACCOUNT_AUTH_CONSTANTS = {
  DEFAULT_PLATFORM,
  DEFAULT_APP_VERSION,
  ACCOUNT_AUD,
  TOKEN_LIFETIME_SECONDS: JWT_CONSTANTS.TOKEN_LIFETIME_SECONDS,
};
