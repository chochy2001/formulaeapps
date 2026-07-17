import { describe, expect, test } from 'bun:test';
import {
  checkIapAvailabilityForRuntime,
  type IapAvailabilityRuntime,
} from '../../src/services/iap-availability';

function runtime(
  environment: IapAvailabilityRuntime['BFF_ENV'],
): IapAvailabilityRuntime {
  return {
    BFF_ENV: environment,
    APPLE_P8_FILE: undefined,
    APPLE_ISSUER_ID: undefined,
    APPLE_KEY_ID: undefined,
    APPLE_BUNDLE_ID: undefined,
    GOOGLE_SA_FILE: undefined,
    GOOGLE_PACKAGE_NAME: undefined,
  };
}

describe('IAP availability policy', () => {
  test('keeps the explicit unconfigured stub path available in development', async () => {
    await expect(
      checkIapAvailabilityForRuntime('apple', runtime('development')),
    ).resolves.toEqual({ available: true });
    await expect(
      checkIapAvailabilityForRuntime('google', runtime('development')),
    ).resolves.toEqual({ available: true });
  });

  test.each(['staging', 'production'] as const)(
    'fails closed when %s has no Apple or Google provider configuration',
    async (environment) => {
      await expect(
        checkIapAvailabilityForRuntime('apple', runtime(environment)),
      ).resolves.toEqual({ available: false, reason: 'apple_not_configured' });
      await expect(
        checkIapAvailabilityForRuntime('google', runtime(environment)),
      ).resolves.toEqual({ available: false, reason: 'google_not_configured' });
    },
  );

  test('fails closed when credentials are present but the Apple validator is not implemented', async () => {
    const configured: IapAvailabilityRuntime = {
      ...runtime('production'),
      APPLE_P8_FILE: '/run/secrets/apple_p8',
      APPLE_ISSUER_ID: 'issuer-id',
      APPLE_KEY_ID: 'key-id',
      APPLE_BUNDLE_ID: 'com.capdesis.formulae',
    };

    await expect(
      checkIapAvailabilityForRuntime(
        'apple',
        configured,
        async () => '-----BEGIN PRIVATE KEY-----\nfixture\n-----END PRIVATE KEY-----',
      ),
    ).resolves.toEqual({ available: false, reason: 'apple_validator_not_ready' });
  });

  test('fails closed when credentials are present but the Google validator is not implemented', async () => {
    const configured: IapAvailabilityRuntime = {
      ...runtime('production'),
      GOOGLE_SA_FILE: '/run/secrets/google_sa',
      GOOGLE_PACKAGE_NAME: 'com.capdesis.formulae',
    };

    await expect(
      checkIapAvailabilityForRuntime(
        'google',
        configured,
        async () => JSON.stringify({ client_email: 'iap@example.invalid' }),
      ),
    ).resolves.toEqual({ available: false, reason: 'google_validator_not_ready' });
  });
});
