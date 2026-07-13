import { Database } from 'bun:sqlite';
import { randomUUID } from 'node:crypto';
import { mkdirSync } from 'node:fs';
import { dirname } from 'node:path';

/**
 * Interim mobile entitlements store (WP5 / fleet §10 step 1).
 *
 * Keyed by JWT `sub` (hashed device/session client_id today). When real user
 * accounts land (step 2), add a `user_id` column and migrate — do not rewrite
 * the primary key shape in a throwaway way.
 *
 * Scope is ALWAYS `mobile`. Polar / `web` grants must never be written here
 * from the IAP validate path.
 */

export type PaymentSource = 'app_store' | 'play_store';
export type EntitlementScope = 'mobile';

export type EntitlementRow = {
  id: string;
  subject: string;
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
};

const FALLBACK_DB_PATH = '.data/mobile_entitlements.sqlite';

let dbSingleton: Database | null = null;
let dbPathOpened: string | null = null;

function resolveDbPath(): string {
  const fromEnv = process.env['ENTITLEMENTS_DB_PATH']?.trim();
  return fromEnv && fromEnv.length > 0 ? fromEnv : FALLBACK_DB_PATH;
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

/**
 * Persist a mobile entitlement grant. Rejects any attempt to write non-mobile
 * scope (defense in depth — callers must not pass Polar/web).
 */
export function grantMobileEntitlement(input: GrantInput): EntitlementRow {
  if (!input.subject.trim()) {
    throw new Error('grantMobileEntitlement: subject is required');
  }
  const row: EntitlementRow = {
    id: randomUUID(),
    subject: input.subject,
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
        (id, subject, payment_source, product_id, scope, granted_at, raw_receipt_ref)
       VALUES ($id, $subject, $payment_source, $product_id, $scope, $granted_at, $raw_receipt_ref)
       ON CONFLICT(subject, payment_source, product_id, raw_receipt_ref) DO UPDATE SET
         granted_at = excluded.granted_at`,
    )
    .run({
      $id: row.id,
      $subject: row.subject,
      $payment_source: row.payment_source,
      $product_id: row.product_id,
      $scope: row.scope,
      $granted_at: row.granted_at,
      $raw_receipt_ref: row.raw_receipt_ref,
    });

  const stored = db
    .query(
      `SELECT id, subject, payment_source, product_id, scope, granted_at, raw_receipt_ref
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

export function listEntitlementsForSubject(subject: string): EntitlementRow[] {
  const db = getEntitlementsDb();
  return db
    .query(
      `SELECT id, subject, payment_source, product_id, scope, granted_at, raw_receipt_ref
       FROM mobile_entitlements
       WHERE subject = $subject
       ORDER BY granted_at ASC`,
    )
    .all({ $subject: subject }) as EntitlementRow[];
}
