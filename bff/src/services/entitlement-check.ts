import { isUserAccountAuthEnabled } from '../lib/feature-flags';
import {
  listEntitlementsForSubject,
  listEntitlementsForUserId,
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

function dedupeSources(
  sources: MobileEntitlementSourceView[],
): MobileEntitlementSourceView[] {
  const seen = new Set<string>();
  const out: MobileEntitlementSourceView[] = [];
  for (const s of sources) {
    const key = `${s.payment_source}|${s.product_id}|${s.granted_at}`;
    if (seen.has(key)) continue;
    seen.add(key);
    out.push(s);
  }
  return out;
}

/**
 * Read channel-scoped mobile entitlements for a subject (and optional user_id).
 * When ENABLE_USER_ACCOUNT_AUTH is on and userId is set, merges account-keyed
 * rows with subject-keyed rows (device grants may not be bound yet).
 * Fail-closed: any error → empty sources / entitled=false.
 */
export function readMobileEntitlement(
  subject: string,
  userId?: string,
): MobileEntitlementView {
  try {
    if (!subject.trim() && !(userId && userId.trim())) {
      return { ...EMPTY, sources: [] };
    }
    const sources: MobileEntitlementSourceView[] = [];
    if (subject.trim()) {
      for (const r of listEntitlementsForSubject(subject).filter((row) => row.scope === 'mobile')) {
        sources.push({
          payment_source: r.payment_source,
          product_id: r.product_id,
          granted_at: r.granted_at,
        });
      }
    }
    if (isUserAccountAuthEnabled() && userId?.trim()) {
      for (const r of listEntitlementsForUserId(userId).filter((row) => row.scope === 'mobile')) {
        sources.push({
          payment_source: r.payment_source,
          product_id: r.product_id,
          granted_at: r.granted_at,
        });
      }
    }
    const deduped = dedupeSources(sources);
    return {
      scope: 'mobile',
      sources: deduped,
      entitled: deduped.length > 0,
    };
  } catch {
    return { ...EMPTY, sources: [] };
  }
}

/** Fail-closed: true only when a mobile row is confirmed present. */
export function hasActiveMobileEntitlement(subject: string, userId?: string): boolean {
  return readMobileEntitlement(subject, userId).entitled;
}

/** Pre-charge decision for mobile IAP (paywall). Fail-closed on access = not owned. */
export type MobileIapPurchaseDecision = 'allow' | 'blockAlreadyOwned';

export function evaluateMobileIapPurchase(
  subject: string,
  userId?: string,
): MobileIapPurchaseDecision {
  return hasActiveMobileEntitlement(subject, userId) ? 'blockAlreadyOwned' : 'allow';
}
