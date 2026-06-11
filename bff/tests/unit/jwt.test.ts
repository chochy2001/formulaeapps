import { describe, test, expect } from 'bun:test';
import { issueToken, verifyToken, shouldRefresh, JWT_CONSTANTS, resolveSigningSecret } from '../../src/lib/jwt';
import { randomUUID } from 'node:crypto';
import { SignJWT, jwtVerify } from 'jose';

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
    // Tamper the signature by altering multiple characters in the middle/end
    const parts = result.token.split('.');
    const signature = parts[2];
    if (!signature) {
      throw new Error('Expected signature part in issued token');
    }
    parts[2] = signature.slice(0, -4) + 'xyz1';
    const tampered = parts.join('.');
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

describe('resolveSigningSecret (audit P1: server-only signing secret)', () => {
  test('falls back to JWT_SHARED_SECRET when JWT_SIGNING_SECRET is unset', () => {
    expect(resolveSigningSecret({ JWT_SHARED_SECRET: 'shared-only' })).toBe('shared-only');
    expect(
      resolveSigningSecret({ JWT_SHARED_SECRET: 'shared-only', JWT_SIGNING_SECRET: undefined }),
    ).toBe('shared-only');
  });

  test('prefers JWT_SIGNING_SECRET when set', () => {
    expect(
      resolveSigningSecret({ JWT_SHARED_SECRET: 'shared', JWT_SIGNING_SECRET: 'server-only' }),
    ).toBe('server-only');
  });

  test('a token forged with the leaked shared secret is rejected once a distinct signing secret is in effect', async () => {
    // Simulates an attacker who extracted JWT_SHARED_SECRET from a client bundle
    // and forged an HS256 token, while the server signs/verifies with a separate
    // JWT_SIGNING_SECRET. Verification under the signing secret must fail.
    const sharedSecret = 'leaked-client-shared-secret';
    const signingSecret = 'server-only-signing-secret';

    const enc = (s: string): Uint8Array => new TextEncoder().encode(s);

    const forged = await new SignJWT({ sub: 'attacker', aud: 'formulaeapps-pro' })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuer('api.formulaeapps.com')
      .setIssuedAt()
      .setExpirationTime('1h')
      .sign(enc(sharedSecret));

    // Forged token verifies under the shared secret (attacker's view)...
    await expect(jwtVerify(forged, enc(sharedSecret))).resolves.toBeDefined();
    // ...but NOT under the server-only signing secret.
    await expect(jwtVerify(forged, enc(signingSecret))).rejects.toThrow();

    // A token the server signs with the signing secret verifies under it.
    const legit = await new SignJWT({ sub: 'real', aud: 'formulaeapps-pro' })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuer('api.formulaeapps.com')
      .setIssuedAt()
      .setExpirationTime('1h')
      .sign(enc(signingSecret));
    await expect(jwtVerify(legit, enc(signingSecret))).resolves.toBeDefined();
  });
});
