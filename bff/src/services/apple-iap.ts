import { env } from '../lib/env';
import { BffError } from '../middleware/error';
import type { IapValidateRequest, IapValidateResponse } from '../schemas/iap';

/**
 * Apple IAP receipt validation wrapper.
 *
 * Spec §FR-024 + Research §R5. Uses `@apple/app-store-server-library`.
 *
 * NOTE: real SDK integration requires the apple_p8 private key file mounted
 * at `env.APPLE_P8_FILE`, plus issuer id + key id + bundle id. The validator
 * verifies subscriptions via the App Store Server API. This wrapper isolates
 * the SDK so route handlers and tests can mock it cleanly.
 *
 * For live integration testing — see US6 acceptance scenario #4.
 */
export interface AppleIapValidator {
  validate(req: IapValidateRequest): Promise<IapValidateResponse>;
}

export class AppleIapStubValidator implements AppleIapValidator {
  // Default validator used when Apple credentials are not configured (dev).
  // Returns valid=false with a clear reason so the FE flow exercises the
  // error path without leaking that the BFF is unconfigured.
  async validate(req: IapValidateRequest): Promise<IapValidateResponse> {
    if (req.platform !== 'apple') {
      throw new BffError('bad_request', `Wrong validator for platform ${req.platform}`, 'E_WRONG_PLATFORM');
    }
    return {
      valid: false,
      product_id: req.product_id,
      transaction_id: req.transaction_id,
      environment: 'sandbox',
      provider_reason: 'Apple IAP validator not configured on this BFF instance',
    };
  }
}

export class AppleIapRealValidator implements AppleIapValidator {
  constructor(
    private readonly opts: {
      privateKey: string; // contents of apple_p8.txt
      issuerId: string;
      keyId: string;
      bundleId: string;
    },
  ) {}

  async validate(req: IapValidateRequest): Promise<IapValidateResponse> {
    if (req.platform !== 'apple') {
      throw new BffError('bad_request', `Wrong validator for platform ${req.platform}`, 'E_WRONG_PLATFORM');
    }

    // Real implementation pending live integration testing (US6 acceptance
    // scenario #4). The @apple/app-store-server-library has a non-trivial
    // setup involving JWS-signed requests; integration is verified manually
    // during VPS Contabo rollout, not in CI (research §R12).
    //
    // For now, throw an explicit not-implemented to make it clear this code
    // path isn't safe to ship until the integration test passes.
    throw new BffError(
      'internal_error',
      'AppleIapRealValidator real-mode not yet integration-tested; see US6 acceptance #4',
      'E_APPLE_IAP_NOT_READY',
    );
  }
}

/**
 * Factory — chooses real vs. stub validator based on env configuration.
 * Real Apple validation is enabled only when all four required env vars are
 * present AND can be read from disk; otherwise the stub validator is used.
 */
export async function createAppleIapValidator(): Promise<AppleIapValidator> {
  const ready =
    !!env.APPLE_P8_FILE &&
    !!env.APPLE_ISSUER_ID &&
    !!env.APPLE_KEY_ID &&
    !!env.APPLE_BUNDLE_ID;

  if (!ready) return new AppleIapStubValidator();

  try {
    const file = Bun.file(env.APPLE_P8_FILE!);
    if (!(await file.exists())) {
      return new AppleIapStubValidator();
    }
    const privateKey = await file.text();
    return new AppleIapRealValidator({
      privateKey,
      issuerId: env.APPLE_ISSUER_ID!,
      keyId: env.APPLE_KEY_ID!,
      bundleId: env.APPLE_BUNDLE_ID!,
    });
  } catch {
    return new AppleIapStubValidator();
  }
}
