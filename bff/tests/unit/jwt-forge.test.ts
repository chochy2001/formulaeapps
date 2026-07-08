import { describe, test, expect } from 'bun:test';
import { SignJWT } from 'jose';
import { verifyToken, resolveSigningSecret } from '../../src/lib/jwt';

const enc = (s: string): Uint8Array => new TextEncoder().encode(s);
const SECRET = resolveSigningSecret({
  JWT_SHARED_SECRET: process.env['JWT_SHARED_SECRET'] ?? 'test-secret-' + 'a'.repeat(48),
});

describe('jwt verifyToken: invalid payload shape', () => {
  test('rejects token with missing iat', async () => {
    const forged = await new SignJWT({
      sub: 'abc',
      aud: 'formulaeapps-pro',
      jti: 'jti-1',
      platform: 'web',
      app_version: '1.0.0',
      exp: Math.floor(Date.now() / 1000) + 3600,
    })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuer('api.formulaeapps.com')
      .sign(enc(SECRET));

    await expect(verifyToken(forged)).rejects.toThrow('Invalid JWT payload shape');
  });

  test('rejects token with missing exp', async () => {
    const forged = await new SignJWT({
      sub: 'abc',
      aud: 'formulaeapps-pro',
      jti: 'jti-1',
      platform: 'web',
      app_version: '1.0.0',
      iat: Math.floor(Date.now() / 1000),
    })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuer('api.formulaeapps.com')
      .sign(enc(SECRET));

    await expect(verifyToken(forged)).rejects.toThrow('Invalid JWT payload shape');
  });

  test('rejects token with unexpected audience', async () => {
    const forged = await new SignJWT({
      sub: 'abc',
      aud: 'unknown-app',
      jti: 'jti-1',
      platform: 'web',
      app_version: '1.0.0',
    })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuer('api.formulaeapps.com')
      .setIssuedAt()
      .setExpirationTime('1h')
      .sign(enc(SECRET));

    await expect(verifyToken(forged)).rejects.toThrow('Unexpected JWT audience: unknown-app');
  });

  test('rejects token with unexpected platform', async () => {
    const forged = await new SignJWT({
      sub: 'abc',
      aud: 'formulaeapps-pro',
      jti: 'jti-1',
      platform: 'windows',
      app_version: '1.0.0',
    })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuer('api.formulaeapps.com')
      .setIssuedAt()
      .setExpirationTime('1h')
      .sign(enc(SECRET));

    await expect(verifyToken(forged)).rejects.toThrow('Unexpected JWT platform: windows');
  });
});
