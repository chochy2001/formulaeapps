import {
  listEntitlementsForSubject,
  type PaymentSource,
} from './entitlements-store';

/**
 * Fail-closed mobile entitlement readers (fleet §10 / WP5).
 *
 * On store errors or empty subject: treat as **not entitled**. Callers that
 * gate Pro access MUST use these helpers rather than raw SQLite queries.
 */

export type MobileEntitlementSourceView = {
  payment_source: PaymentSource;
  product_id: string;
  granted_at: string;
};

export type MobileEntitlementView = {
  /** IAP path is mobile-only; never `web`. */
  scope: 'mobile';
  sources: MobileEntitlementSourceView[];
  entitled: boolean;
};

const EMPTY: MobileEntitlementView = {
  scope: 'mobile',
  sources: [],
  entitled: false,
};

/**
 * Read channel-scoped mobile entitlements for a subject.
 * Fail-closed: any error → empty sources / entitled=false.
 */
export function readMobileEntitlement(subject: string): MobileEntitlementView {
  try {
    if (!subject.trim()) {
      return { ...EMPTY, sources: [] };
    }
    const rows = listEntitlementsForSubject(subject).filter((r) => r.scope === 'mobile');
    return {
      scope: 'mobile',
      sources: rows.map((r) => ({
        payment_source: r.payment_source,
        product_id: r.product_id,
        granted_at: r.granted_at,
      })),
      entitled: rows.length > 0,
    };
  } catch {
    return { ...EMPTY, sources: [] };
  }
}

/** Fail-closed: true only when a mobile row is confirmed present. */
export function hasActiveMobileEntitlement(subject: string): boolean {
  return readMobileEntitlement(subject).entitled;
}

/** Pre-charge decision for mobile IAP (paywall). Fail-closed on access = not owned. */
export type MobileIapPurchaseDecision = 'allow' | 'blockAlreadyOwned';

export function evaluateMobileIapPurchase(subject: string): MobileIapPurchaseDecision {
  return hasActiveMobileEntitlement(subject) ? 'blockAlreadyOwned' : 'allow';
}
