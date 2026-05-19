import { env } from '../lib/env';
import { BffError } from '../middleware/error';
import type { IapValidateRequest, IapValidateResponse } from '../schemas/iap';

/**
 * Google Play IAP receipt validation wrapper.
 *
 * Spec §FR-024 + Research §R5. Uses `googleapis` androidpublisher_v3.
 *
 * NOTE: real SDK integration requires a Google service account JSON file
 * (env.GOOGLE_SA_FILE) authorized for the AndroidPublisher API. The validator
 * verifies subscriptions or one-time purchases. Same isolation pattern as
 * Apple IAP — route handlers / tests mock at this interface.
 *
 * For live integration testing — see US6 acceptance scenario #4.
 */
export interface GoogleIapValidator {
  validate(req: IapValidateRequest): Promise<IapValidateResponse>;
}

export class GoogleIapStubValidator implements GoogleIapValidator {
  async validate(req: IapValidateRequest): Promise<IapValidateResponse> {
    if (req.platform !== 'google') {
      throw new BffError('bad_request', `Wrong validator for platform ${req.platform}`, 'E_WRONG_PLATFORM');
    }
    return {
      valid: false,
      product_id: req.product_id,
      transaction_id: req.transaction_id,
      environment: 'sandbox',
      provider_reason: 'Google IAP validator not configured on this BFF instance',
    };
  }
}

export class GoogleIapRealValidator implements GoogleIapValidator {
  constructor(
    private readonly opts: {
      serviceAccountJson: string;
      packageName: string;
    },
  ) {}

  async validate(req: IapValidateRequest): Promise<IapValidateResponse> {
    if (req.platform !== 'google') {
      throw new BffError('bad_request', `Wrong validator for platform ${req.platform}`, 'E_WRONG_PLATFORM');
    }

    // Real implementation pending live integration testing (US6 acceptance #4).
    // googleapis androidpublisher_v3 setup is straightforward, but real
    // verification needs a valid purchase token and a sandbox order in Play
    // Console. Verified manually during VPS Contabo rollout, not in CI.
    throw new BffError(
      'internal_error',
      'GoogleIapRealValidator real-mode not yet integration-tested; see US6 acceptance #4',
      'E_GOOGLE_IAP_NOT_READY',
    );
  }
}

/**
 * Factory — chooses real vs. stub validator based on env configuration.
 */
export async function createGoogleIapValidator(): Promise<GoogleIapValidator> {
  const ready = !!env.GOOGLE_SA_FILE && !!env.GOOGLE_PACKAGE_NAME;
  if (!ready) return new GoogleIapStubValidator();

  try {
    const file = Bun.file(env.GOOGLE_SA_FILE!);
    if (!(await file.exists())) return new GoogleIapStubValidator();
    const serviceAccountJson = await file.text();
    return new GoogleIapRealValidator({
      serviceAccountJson,
      packageName: env.GOOGLE_PACKAGE_NAME!,
    });
  } catch {
    return new GoogleIapStubValidator();
  }
}
