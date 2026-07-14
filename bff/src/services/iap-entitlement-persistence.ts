import { BffError } from '../middleware/error';
import {
  grantMobileEntitlement,
  paymentSourceFromPlatform,
  type GrantInput,
} from './entitlements-store';

type ValidatedMobileIap = {
  platform: 'apple' | 'google';
  product_id: string;
  transaction_id: string;
};

type PersistValidatedMobileIapInput = ValidatedMobileIap & {
  subject: string;
  user_id?: string;
};

type EntitlementGrant = (input: GrantInput) => unknown;

/**
 * Record a provider-confirmed mobile purchase before reporting it as valid.
 *
 * A successful provider validation without a durable local grant leaves the
 * pre-purchase guard unable to see the purchase. That is unsafe once the BFF
 * participates in entitlement decisions, so persistence failure is surfaced
 * as a sanitized 500 that the caller can retry instead of a false 200.
 */
export function persistValidatedMobileIap(
  input: PersistValidatedMobileIapInput,
  grant: EntitlementGrant = grantMobileEntitlement,
): void {
  if (!input.subject.trim()) {
    throw new BffError(
      'internal_error',
      'Validated purchase is missing its authenticated subject.',
      'E_IAP_MISSING_SUBJECT',
    );
  }

  try {
    grant({
      subject: input.subject,
      payment_source: paymentSourceFromPlatform(input.platform),
      product_id: input.product_id,
      raw_receipt_ref: input.transaction_id,
      user_id: input.user_id,
    });
  } catch {
    throw new BffError(
      'internal_error',
      'Validated purchase could not be persisted.',
      'E_ENTITLEMENT_PERSISTENCE',
    );
  }
}
