import { Database } from 'bun:sqlite';
import { randomUUID } from 'node:crypto';
import { mkdirSync } from 'node:fs';
import { dirname } from 'node:path';
import { isUserAccountAuthEnabled } from '../lib/feature-flags';

/**
 * Interim mobile entitlements store (WP5 / fleet §10 step 1 + #86 prep).
 *
 * Keyed by JWT `sub` (hashed device/session client_id today). Nullable
 * `user_id` is additive: written only when ENABLE_USER_ACCOUNT_AUTH=true and
 * a user_id is supplied. Default flag off → column stays NULL; subject
 * remains the live entitlement key.
 *
 * Scope is ALWAYS `mobile`. Polar / `web` grants must never be written here
 * from the IAP validate path.
 */

export type PaymentSource = 'app_store' | 'play_store';
export type EntitlementScope = 'mobile';

export type EntitlementRow = {
  id: string;
  subject: string;
  /** Nullable until accounts go live; bound only when flag on. */
  user_id: string | null;
  payment_source: PaymentSource;
  product_id: string;
  scope: EntitlementScope;
  granted_at: string;
  raw_receipt_ref: string;
};

export type GrantInput = {
  subject: string;
  payment_source: PaymentSource;
  product_id: string;
  /** Opaque receipt/transaction reference — not the full receipt body. */
  raw_receipt_ref: string;
  /**
   * Optional account id. Persisted only when ENABLE_USER_ACCOUNT_AUTH=true.
   * Ignored (stored as NULL) while the flag is off.
   */
  user_id?: string | null;
};

const FALLBACK_DB_PATH = '.data/mobile_entitlements.sqlite';

let dbSingleton: Database | null = null;
let dbPathOpened: string | null = null;

function resolveDbPath(): string {
  const fromEnv = process.env['ENTITLEMENTS_DB_PATH']?.trim();
  return fromEnv && fromEnv.length > 0 ? fromEnv : FALLBACK_DB_PATH;
}

/** Additive migration: nullable user_id for account-bound entitlements. */
function migrateEntitlementsSchema(db: Database): void {
  const cols = db
    .query(`PRAGMA table_info(mobile_entitlements)`)
    .all() as Array<{ name: string }>;
  const names = new Set(cols.map((c) => c.name));
  if (!names.has('user_id')) {
    db.exec(`ALTER TABLE mobile_entitlements ADD COLUMN user_id TEXT NULL`);
  }
  db.exec(`
    CREATE INDEX IF NOT EXISTS idx_mobile_entitlements_user_id
      ON mobile_entitlements (user_id)
      WHERE user_id IS NOT NULL
  `);
}

function openDb(path: string): Database {
  if (path !== ':memory:') {
    mkdirSync(dirname(path), { recursive: true });
  }
  const db = new Database(path, { create: true });
  db.exec(`
    CREATE TABLE IF NOT EXISTS mobile_entitlements (
      id TEXT PRIMARY KEY NOT NULL,
      subject TEXT NOT NULL,
      user_id TEXT NULL,
      payment_source TEXT NOT NULL CHECK (payment_source IN ('app_store', 'play_store')),
      product_id TEXT NOT NULL,
      scope TEXT NOT NULL CHECK (scope = 'mobile'),
      granted_at TEXT NOT NULL,
      raw_receipt_ref TEXT NOT NULL,
      UNIQUE (subject, payment_source, product_id, raw_receipt_ref)
    );
    CREATE INDEX IF NOT EXISTS idx_mobile_entitlements_subject
      ON mobile_entitlements (subject);
  `);
  migrateEntitlementsSchema(db);
  return db;
}

/** Test/helper hook — reset singleton (e.g. after switching ENTITLEMENTS_DB_PATH). */
export function resetEntitlementsStoreForTests(): void {
  if (dbSingleton) {
    dbSingleton.close();
    dbSingleton = null;
    dbPathOpened = null;
  }
}

export function getEntitlementsDb(): Database {
  const path = resolveDbPath();
  if (!dbSingleton || dbPathOpened !== path) {
    if (dbSingleton) {
      dbSingleton.close();
    }
    dbSingleton = openDb(path);
    dbPathOpened = path;
  }
  return dbSingleton;
}

export function paymentSourceFromPlatform(platform: 'apple' | 'google'): PaymentSource {
  return platform === 'apple' ? 'app_store' : 'play_store';
}

const STORE_PAYMENT_SOURCES: ReadonlySet<string> = new Set(['app_store', 'play_store']);

/**
 * Runtime guard: IAP grants accept only store sources. Polar / web / unknown
 * values throw — contract test for fleet §10 "IAP grant ≠ web unlock".
 */
export function assertStorePaymentSource(source: string): asserts source is PaymentSource {
  if (!STORE_PAYMENT_SOURCES.has(source)) {
    throw new Error(
      `IAP grant rejects payment_source=${source}; only app_store|play_store (never polar/web)`,
    );
  }
}

function resolvePersistedUserId(inputUserId: string | null | undefined): string | null {
  if (!isUserAccountAuthEnabled()) {
    return null;
  }
  const trimmed = inputUserId?.trim();
  return trimmed && trimmed.length > 0 ? trimmed : null;
}

/**
 * Persist a mobile entitlement grant. Rejects any attempt to write non-mobile
 * scope (defense in depth — callers must not pass Polar/web).
 */
export function grantMobileEntitlement(input: GrantInput): EntitlementRow {
  if (!input.subject.trim()) {
    throw new Error('grantMobileEntitlement: subject is required');
  }
  // Defense in depth: reject polar/web even if TypeScript is bypassed.
  assertStorePaymentSource(input.payment_source as string);
  const userId = resolvePersistedUserId(input.user_id);
  const row: EntitlementRow = {
    id: randomUUID(),
    subject: input.subject,
    user_id: userId,
    payment_source: input.payment_source,
    product_id: input.product_id,
    scope: 'mobile',
    granted_at: new Date().toISOString(),
    raw_receipt_ref: input.raw_receipt_ref,
  };

  const db = getEntitlementsDb();
  db
    .query(
      `INSERT INTO mobile_entitlements
        (id, subject, user_id, payment_source, product_id, scope, granted_at, raw_receipt_ref)
       VALUES ($id, $subject, $user_id, $payment_source, $product_id, $scope, $granted_at, $raw_receipt_ref)
       ON CONFLICT(subject, payment_source, product_id, raw_receipt_ref) DO UPDATE SET
         granted_at = excluded.granted_at,
         user_id = COALESCE(excluded.user_id, mobile_entitlements.user_id)`,
    )
    .run({
      $id: row.id,
      $subject: row.subject,
      $user_id: row.user_id,
      $payment_source: row.payment_source,
      $product_id: row.product_id,
      $scope: row.scope,
      $granted_at: row.granted_at,
      $raw_receipt_ref: row.raw_receipt_ref,
    });

  const stored = db
    .query(
      `SELECT id, subject, user_id, payment_source, product_id, scope, granted_at, raw_receipt_ref
       FROM mobile_entitlements
       WHERE subject = $subject
         AND payment_source = $payment_source
         AND product_id = $product_id
         AND raw_receipt_ref = $raw_receipt_ref`,
    )
    .get({
      $subject: row.subject,
      $payment_source: row.payment_source,
      $product_id: row.product_id,
      $raw_receipt_ref: row.raw_receipt_ref,
    }) as EntitlementRow;

  return stored;
}

/**
 * Bind an existing subject-keyed entitlement row to a user_id.
 * No-op (returns 0) while ENABLE_USER_ACCOUNT_AUTH is off.
 */
export function bindEntitlementsUserId(subject: string, userId: string): number {
  if (!isUserAccountAuthEnabled()) {
    return 0;
  }
  if (!subject.trim() || !userId.trim()) {
    throw new Error('bindEntitlementsUserId: subject and userId are required');
  }
  const db = getEntitlementsDb();
  const result = db
    .query(
      `UPDATE mobile_entitlements
       SET user_id = $user_id
       WHERE subject = $subject
         AND (user_id IS NULL OR user_id = $user_id)`,
    )
    .run({ $subject: subject, $user_id: userId.trim() });
  return Number(result.changes ?? 0);
}

export function listEntitlementsForSubject(subject: string): EntitlementRow[] {
  const db = getEntitlementsDb();
  return db
    .query(
      `SELECT id, subject, user_id, payment_source, product_id, scope, granted_at, raw_receipt_ref
       FROM mobile_entitlements
       WHERE subject = $subject
       ORDER BY granted_at ASC`,
    )
    .all({ $subject: subject }) as EntitlementRow[];
}

/**
 * List by account id. Empty while flag is off or user_id was never bound.
 * Subject listing remains the production path until accounts go live.
 */
export function listEntitlementsForUserId(userId: string): EntitlementRow[] {
  if (!isUserAccountAuthEnabled() || !userId.trim()) {
    return [];
  }
  const db = getEntitlementsDb();
  return db
    .query(
      `SELECT id, subject, user_id, payment_source, product_id, scope, granted_at, raw_receipt_ref
       FROM mobile_entitlements
       WHERE user_id = $user_id
       ORDER BY granted_at ASC`,
    )
    .all({ $user_id: userId.trim() }) as EntitlementRow[];
}
