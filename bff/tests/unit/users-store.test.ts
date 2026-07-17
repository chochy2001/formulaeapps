import { describe, test, expect, beforeEach, afterEach } from 'bun:test';
import {
  authenticateUser,
  createUser,
  findUserByEmail,
  resetUsersStoreForTests,
  verifyPassword,
} from '../../src/services/users-store';

describe('users-store (email/password)', () => {
  beforeEach(() => {
    process.env['ACCOUNTS_DB_PATH'] = ':memory:';
    resetUsersStoreForTests();
  });

  afterEach(() => {
    resetUsersStoreForTests();
  });

  test('createUser persists normalized email and argon2id hash', async () => {
    const user = await createUser('User@Example.COM', 'correct-horse');
    expect(user.email).toBe('user@example.com');
    expect(user.id).toMatch(
      /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i,
    );
    expect(user.password_hash.startsWith('$argon2')).toBe(true);
    expect(await verifyPassword('correct-horse', user.password_hash)).toBe(true);
    expect(await verifyPassword('wrong-password', user.password_hash)).toBe(false);
  });

  test('duplicate email throws EMAIL_TAKEN', async () => {
    await createUser('dup@example.com', 'correct-horse');
    await expect(createUser('DUP@example.com', 'other-password')).rejects.toMatchObject({
      message: 'EMAIL_TAKEN',
    });
  });

  test('authenticateUser returns user on valid credentials', async () => {
    await createUser('login@example.com', 'correct-horse');
    const ok = await authenticateUser('login@example.com', 'correct-horse');
    expect(ok?.email).toBe('login@example.com');
    const bad = await authenticateUser('login@example.com', 'nope');
    expect(bad).toBeNull();
    const missing = await authenticateUser('missing@example.com', 'correct-horse');
    expect(missing).toBeNull();
  });

  test('findUserByEmail is case-insensitive', async () => {
    await createUser('Case@Example.com', 'correct-horse');
    expect(findUserByEmail('case@example.com')?.email).toBe('case@example.com');
  });
});
