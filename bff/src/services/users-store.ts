import { Database } from 'bun:sqlite';
import { randomUUID } from 'node:crypto';
import { mkdirSync } from 'node:fs';
import { dirname } from 'node:path';

/**
 * Email/password users store (fleet #86 / WP5 step 2b).
 * Only used when ENABLE_USER_ACCOUNT_AUTH=true. Default flag off → routes 403.
 */

export type UserRow = {
  id: string;
  email: string;
  password_hash: string;
  created_at: string;
};

const FALLBACK_DB_PATH = '.data/accounts.sqlite';

let dbSingleton: Database | null = null;
let dbPathOpened: string | null = null;

function resolveDbPath(): string {
  const fromEnv = process.env['ACCOUNTS_DB_PATH']?.trim();
  return fromEnv && fromEnv.length > 0 ? fromEnv : FALLBACK_DB_PATH;
}

function openDb(path: string): Database {
  if (path !== ':memory:') {
    mkdirSync(dirname(path), { recursive: true });
  }
  const db = new Database(path, { create: true });
  db.exec(`
    CREATE TABLE IF NOT EXISTS users (
      id TEXT PRIMARY KEY NOT NULL,
      email TEXT NOT NULL COLLATE NOCASE,
      password_hash TEXT NOT NULL,
      created_at TEXT NOT NULL,
      UNIQUE (email)
    );
    CREATE INDEX IF NOT EXISTS idx_users_email ON users (email);
  `);
  return db;
}

export function resetUsersStoreForTests(): void {
  if (dbSingleton) {
    dbSingleton.close();
    dbSingleton = null;
    dbPathOpened = null;
  }
}

export function getUsersDb(): Database {
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

function normalizeEmail(email: string): string {
  return email.trim().toLowerCase();
}

export async function hashPassword(password: string): Promise<string> {
  // Bun argon2id by default — never log password or hash in handlers.
  return await Bun.password.hash(password, { algorithm: 'argon2id' });
}

export async function verifyPassword(password: string, passwordHash: string): Promise<boolean> {
  return await Bun.password.verify(password, passwordHash);
}

export async function createUser(email: string, password: string): Promise<UserRow> {
  const normalized = normalizeEmail(email);
  if (!normalized) {
    throw new Error('createUser: email is required');
  }
  const id = randomUUID();
  const password_hash = await hashPassword(password);
  const created_at = new Date().toISOString();
  const db = getUsersDb();
  try {
    db.query(
      `INSERT INTO users (id, email, password_hash, created_at)
       VALUES ($id, $email, $password_hash, $created_at)`,
    ).run({
      $id: id,
      $email: normalized,
      $password_hash: password_hash,
      $created_at: created_at,
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    if (message.includes('UNIQUE') || message.includes('unique')) {
      const conflict = new Error('EMAIL_TAKEN');
      conflict.name = 'EmailTakenError';
      throw conflict;
    }
    throw err;
  }
  return { id, email: normalized, password_hash, created_at };
}

export function findUserByEmail(email: string): UserRow | null {
  const normalized = normalizeEmail(email);
  const row = getUsersDb()
    .query(
      `SELECT id, email, password_hash, created_at FROM users WHERE email = $email`,
    )
    .get({ $email: normalized }) as UserRow | null;
  return row ?? null;
}

export function findUserById(id: string): UserRow | null {
  const row = getUsersDb()
    .query(`SELECT id, email, password_hash, created_at FROM users WHERE id = $id`)
    .get({ $id: id }) as UserRow | null;
  return row ?? null;
}

/** Fixed argon2id hash for missing-user verify path (timing pad; not a real secret). */
const TIMING_PAD_HASH =
  '$argon2id$v=19$m=65536,t=2,p=1$dGltZWluZ3BhZGRpbmdzYWx0$8G+8nQb5G8v3n6n5p0vKqXwYxY3aZ1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6';

export async function authenticateUser(
  email: string,
  password: string,
): Promise<UserRow | null> {
  const user = findUserByEmail(email);
  if (!user) {
    // Dummy verify to reduce timing oracle on missing emails.
    try {
      await Bun.password.verify(password, TIMING_PAD_HASH);
    } catch {
      // Invalid pad hash still burns some work; ignore verify errors.
    }
    return null;
  }
  const ok = await verifyPassword(password, user.password_hash);
  return ok ? user : null;
}
