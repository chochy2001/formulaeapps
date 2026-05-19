import { describe, test, expect } from 'bun:test';
import { issueToken, verifyToken, shouldRefresh, JWT_CONSTANTS } from '../../src/lib/jwt';
import { randomUUID } from 'node:crypto';

describe('jwt issue + verify', () => {
  test('issues a valid HS256 token with correct claims', async () => {
    const sub = 'abc123';
    const jti = randomUUID();
    const result = await issueToken({
      sub,
      aud: 'formulaeapps-pro',
      platform: 'web',
      app_version: '3.7.2',
      jti,
    });

    expect(result.token).toBeTypeOf('string');
    expect(result.token.split('.').length).toBe(3); // header.payload.signature
    expect(result.exp).toBeGreaterThan(result.iat);
    expect(result.exp - result.iat).toBe(JWT_CONSTANTS.TOKEN_LIFETIME_SECONDS);
    expect(result.refresh_after).toBeLessThan(result.exp);

    const claims = await verifyToken(result.token);
    expect(claims.sub).toBe(sub);
    expect(claims.iss).toBe('api.formulaeapps.com');
    expect(claims.aud).toBe('formulaeapps-pro');
    expect(claims.jti).toBe(jti);
    expect(claims.platform).toBe('web');
    expect(claims.app_version).toBe('3.7.2');
  });

  test('rejects token with wrong signature', async () => {
    const result = await issueToken({
      sub: 'abc',
      aud: 'formulaeapps-pro',
      platform: 'web',
      app_version: '3.7.2',
      jti: randomUUID(),
    });
    // Tamper the last char of the signature
    const tampered = result.token.slice(0, -1) + (result.token.endsWith('A') ? 'B' : 'A');
    await expect(verifyToken(tampered)).rejects.toThrow();
  });

  test('rejects malformed token', async () => {
    await expect(verifyToken('not.a.jwt')).rejects.toThrow();
    await expect(verifyToken('')).rejects.toThrow();
  });

  test('shouldRefresh returns false immediately after issue', async () => {
    const result = await issueToken({
      sub: 'abc',
      aud: 'formulaeapps-pro',
      platform: 'web',
      app_version: '3.7.2',
      jti: randomUUID(),
    });
    const claims = await verifyToken(result.token);
    expect(shouldRefresh(claims)).toBe(false);
  });

  test('shouldRefresh returns true when claims are past refresh_after window', () => {
    const now = Math.floor(Date.now() / 1000);
    const claims = {
      sub: 'x',
      iss: 'api.formulaeapps.com' as const,
      aud: 'formulaeapps-pro' as const,
      jti: 'j',
      platform: 'web' as const,
      app_version: '1.0.0',
      iat: now - JWT_CONSTANTS.TOKEN_LIFETIME_SECONDS + 60,
      exp: now + 60,
    };
    expect(shouldRefresh(claims)).toBe(true);
  });
});
