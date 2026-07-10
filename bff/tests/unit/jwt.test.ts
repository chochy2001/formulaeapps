import { describe, test, expect } from 'bun:test';
import {
  issueToken,
  issueTokenWithConfig,
  verifyToken,
  verifyTokenWithConfig,
  shouldRefresh,
  JWT_CONSTANTS,
  resolveSigningSecret,
  legacyVerificationAllowed,
  type JwtKeyConfig,
} from '../../src/lib/jwt';
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

describe('dual-key JWT migration', () => {
  const startMillis = 1_800_000_000_000;
  const cutoffMillis = startMillis + 3_599_000;
  const signingSecret = 'new-server-only-signing-secret-32bytes';
  const legacySecret = 'legacy-client-shared-secret';

  const config = (overrides: Partial<JwtKeyConfig> = {}): JwtKeyConfig => ({
    JWT_SIGNING_SECRET: signingSecret,
    JWT_SHARED_SECRET: legacySecret,
    JWT_LEGACY_VERIFY_ENABLED: true,
    JWT_LEGACY_VERIFY_START: new Date(startMillis).toISOString(),
    JWT_LEGACY_VERIFY_CUTOFF: new Date(cutoffMillis).toISOString(),
    ...overrides,
  });

  async function signSession(secret: string): Promise<string> {
    const nowSeconds = Math.floor(startMillis / 1000);
    return await new SignJWT({
      sub: 'existing-session',
      aud: 'formulaeapps-pro',
      jti: randomUUID(),
      platform: 'web',
      app_version: '3.7.2',
    })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuer('api.formulaeapps.com')
      .setIssuedAt(nowSeconds - 60)
      .setExpirationTime(nowSeconds + JWT_CONSTANTS.TOKEN_LIFETIME_SECONDS)
      .sign(new TextEncoder().encode(secret));
  }

  test('requires JWT_SIGNING_SECRET for all newly issued JWTs', () => {
    expect(() =>
      resolveSigningSecret({
        JWT_SHARED_SECRET: legacySecret,
        JWT_SIGNING_SECRET: undefined,
      }),
    ).toThrow('JWT_SIGNING_SECRET is required to issue session JWTs');
  });

  test('accepts a legacy token only during an explicitly enabled grace window', async () => {
    const token = await signSession(legacySecret);
    const claims = await verifyTokenWithConfig(token, config(), startMillis + 1);

    expect(claims.sub).toBe('existing-session');
  });

  test('accepts a token signed by the new server-only key', async () => {
    const token = await signSession(signingSecret);
    const claims = await verifyTokenWithConfig(token, config(), startMillis + 1);

    expect(claims.sub).toBe('existing-session');
  });

  test('rejects a legacy token at the exact cutoff millisecond', async () => {
    const token = await signSession(legacySecret);

    await expect(verifyTokenWithConfig(token, config(), cutoffMillis)).rejects.toThrow();
  });

  test('rejects a legacy token one millisecond after cutoff', async () => {
    const token = await signSession(legacySecret);

    await expect(verifyTokenWithConfig(token, config(), cutoffMillis + 1)).rejects.toThrow();
  });

  test('honors a fractional-second cutoff using real milliseconds', () => {
    const fractionalCutoffMillis = cutoffMillis + 500;
    const fractionalConfig = config({
      JWT_LEGACY_VERIFY_CUTOFF: new Date(fractionalCutoffMillis).toISOString(),
    });

    expect(legacyVerificationAllowed(fractionalConfig, fractionalCutoffMillis - 1)).toBe(true);
    expect(legacyVerificationAllowed(fractionalConfig, fractionalCutoffMillis)).toBe(false);
  });

  test('rejects legacy tokens when the migration flag is disabled', async () => {
    const token = await signSession(legacySecret);

    await expect(
      verifyTokenWithConfig(token, config({ JWT_LEGACY_VERIFY_ENABLED: false }), startMillis + 1),
    ).rejects.toThrow();
  });

  test('a restart one hour later cannot extend the immutable cutoff', () => {
    const bootConfig = config();
    const restartedConfig = { ...bootConfig };
    const restartMillis = startMillis + 3_600_000;

    expect(legacyVerificationAllowed(bootConfig, startMillis + 1)).toBe(true);
    expect(legacyVerificationAllowed(restartedConfig, restartMillis)).toBe(false);
    expect(restartedConfig.JWT_LEGACY_VERIFY_CUTOFF).toBe(bootConfig.JWT_LEGACY_VERIFY_CUTOFF);
  });

  test('rollback keeps the new key and does not resume legacy signing', async () => {
    const result = await issueTokenWithConfig(
      {
        sub: 'rollback-session',
        aud: 'formulaeapps-pro',
        platform: 'web',
        app_version: '3.7.2',
        jti: randomUUID(),
      },
      config({
        JWT_LEGACY_VERIFY_ENABLED: false,
        JWT_LEGACY_VERIFY_START: undefined,
        JWT_LEGACY_VERIFY_CUTOFF: undefined,
      }),
      Math.floor(startMillis / 1000),
    );

    await expect(
      jwtVerify(result.token, new TextEncoder().encode(signingSecret)),
    ).resolves.toBeDefined();
    await expect(
      jwtVerify(result.token, new TextEncoder().encode(legacySecret)),
    ).rejects.toThrow();
    await expect(
      verifyTokenWithConfig(
        result.token,
        config({
          JWT_LEGACY_VERIFY_ENABLED: false,
          JWT_LEGACY_VERIFY_START: undefined,
          JWT_LEGACY_VERIFY_CUTOFF: undefined,
        }),
        startMillis,
      ),
    ).resolves.toMatchObject({ sub: 'rollback-session' });
  });
});

describe('legacyVerificationAllowed helper (direct)', () => {
  const startMillis = 1_800_000_000_000;
  const twoHours = 7_200_000;
  const twentyFourHours = 86_400_000;

  const base = (overrides: Partial<JwtKeyConfig> = {}): JwtKeyConfig => ({
    JWT_SIGNING_SECRET: 'new-server-only-signing-secret-32bytes',
    JWT_SHARED_SECRET: 'legacy-client-shared-secret',
    JWT_LEGACY_VERIFY_ENABLED: true,
    JWT_LEGACY_VERIFY_START: new Date(startMillis).toISOString(),
    JWT_LEGACY_VERIFY_CUTOFF: new Date(startMillis + twoHours).toISOString(),
    ...overrides,
  });

  test('allows verification inside a valid 24h-request window only when duration ≤ 2h', () => {
    // A requested 24h window is invalid and must be rejected by the helper itself.
    const twentyFourHourConfig = base({
      JWT_LEGACY_VERIFY_CUTOFF: new Date(startMillis + twentyFourHours).toISOString(),
    });
    expect(legacyVerificationAllowed(twentyFourHourConfig, startMillis + 1)).toBe(false);
    expect(legacyVerificationAllowed(twentyFourHourConfig, startMillis + twoHours - 1)).toBe(false);
  });

  test('accepts the inclusive start and rejects the exclusive cutoff boundary', () => {
    const cfg = base();
    expect(legacyVerificationAllowed(cfg, startMillis)).toBe(true);
    expect(legacyVerificationAllowed(cfg, startMillis + twoHours - 1)).toBe(true);
    expect(legacyVerificationAllowed(cfg, startMillis + twoHours)).toBe(false);
    expect(legacyVerificationAllowed(cfg, startMillis - 1)).toBe(false);
  });

  test('accepts an exact two-hour (7200000 ms) window', () => {
    const cfg = base({
      JWT_LEGACY_VERIFY_CUTOFF: new Date(startMillis + 7_200_000).toISOString(),
    });
    expect(legacyVerificationAllowed(cfg, startMillis + 1)).toBe(true);
  });

  test('rejects cutoff equal to start', () => {
    const cfg = base({
      JWT_LEGACY_VERIFY_CUTOFF: new Date(startMillis).toISOString(),
    });
    expect(legacyVerificationAllowed(cfg, startMillis)).toBe(false);
  });

  test('rejects cutoff before start', () => {
    const cfg = base({
      JWT_LEGACY_VERIFY_CUTOFF: new Date(startMillis - 1).toISOString(),
    });
    expect(legacyVerificationAllowed(cfg, startMillis - 1)).toBe(false);
  });

  test('rejects duration greater than 7200000 ms by one millisecond', () => {
    const cfg = base({
      JWT_LEGACY_VERIFY_CUTOFF: new Date(startMillis + 7_200_001).toISOString(),
    });
    expect(legacyVerificationAllowed(cfg, startMillis + 1)).toBe(false);
  });

  test('rejects NaN / unparseable timestamps', () => {
    expect(
      legacyVerificationAllowed(
        base({ JWT_LEGACY_VERIFY_START: 'not-a-date', JWT_LEGACY_VERIFY_CUTOFF: 'also-bad' }),
        startMillis,
      ),
    ).toBe(false);
  });

  test('rejects when legacy flag is disabled or bounds are missing', () => {
    expect(legacyVerificationAllowed(base({ JWT_LEGACY_VERIFY_ENABLED: false }), startMillis + 1)).toBe(
      false,
    );
    expect(
      legacyVerificationAllowed(base({ JWT_LEGACY_VERIFY_START: undefined }), startMillis + 1),
    ).toBe(false);
    expect(
      legacyVerificationAllowed(base({ JWT_LEGACY_VERIFY_CUTOFF: undefined }), startMillis + 1),
    ).toBe(false);
  });
});
