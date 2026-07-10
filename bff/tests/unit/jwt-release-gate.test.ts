import { describe, expect, test } from 'bun:test';

const repoRoot = new URL('../../..', import.meta.url).pathname;
/** First commit with exclusive signing + immutable UTC [start, cutoff). */
const firstValidatedDualKeyCommit = ['5a7795f657283f1b', '47069ef026ef864d3a65f73c'].join('');
/** Dual-key commit that still recomputed grace from process start — not a safe rollback. */
const preFixedWindowDualKeyCommit = ['9363daeb6e032a4d', 'a2ab2ee3223603c3da9228ed'].join('');

function runGate(candidate: string, ...options: string[]) {
  return Bun.spawnSync(
    ['bash', 'scripts/verify-jwt-release-artifact.sh', candidate, ...options],
    { cwd: repoRoot, stderr: 'pipe', stdout: 'pipe' },
  );
}

describe('JWT release artifact gate', () => {
  test('allows rollback to a validated fixed-window dual-key artifact when the signing key is retained', () => {
    const result = runGate(firstValidatedDualKeyCommit, '--rollback', '--keep-signing-secret');

    expect(result.exitCode).toBe(0);
    expect(result.stdout.toString()).toContain('JWT artifact gate passed');
    expect(result.stdout.toString()).toContain(firstValidatedDualKeyCommit);
  });

  test('inspects candidate blobs: rejects a dual-key SHA that predates the fixed window', () => {
    const result = runGate(preFixedWindowDualKeyCommit, '--rollback', '--keep-signing-secret');

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('predates validated fixed-window dual-key JWT support');
  });

  test('blocks rollback to an artifact that signs with JWT_SHARED_SECRET', () => {
    const result = runGate(`${preFixedWindowDualKeyCommit}^`, '--rollback', '--keep-signing-secret');

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('predates validated fixed-window dual-key JWT support');
  });

  test('blocks rollback unless retaining JWT_SIGNING_SECRET is explicitly confirmed', () => {
    const result = runGate(firstValidatedDualKeyCommit, '--rollback');

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('must retain JWT_SIGNING_SECRET');
  });
});
