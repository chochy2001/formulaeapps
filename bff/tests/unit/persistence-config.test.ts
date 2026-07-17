import { describe, expect, test } from 'bun:test';
import { validatePersistenceConfig } from '../../scripts/validate-persistence-config';

describe('BFF SQLite persistence configuration', () => {
  test('keeps the runtime directory, database paths, and named volume aligned', () => {
    expect(validatePersistenceConfig()).toEqual([]);
  });
});
