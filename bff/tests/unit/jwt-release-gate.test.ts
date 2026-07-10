import { describe, expect, test } from 'bun:test';

const repoRoot = new URL('../../..', import.meta.url).pathname;
/** Canonical squash on main with exclusive signing + immutable UTC [start, cutoff). */
const firstValidatedDualKeyMainCommit = ['6c681716b5b20e60c1cf5898c61b2719171fa94', 'f'].join('');
/** Feature-branch dual-key commit — not descended from main squash. */
const featureBranchDualKeyCommit = ['5a7795f657283f1b', '47069ef026ef864d3a65f73c'].join('');
/** Dual-key commit that still recomputed grace from process start — not on main lineage. */
const preFixedWindowDualKeyCommit = ['9363daeb6e032a4d', 'a2ab2ee3223603c3da9228ed'].join('');

function runGate(candidate: string, ...options: string[]) {
  return Bun.spawnSync(
    ['bash', 'scripts/verify-jwt-release-artifact.sh', candidate, ...options],
    { cwd: repoRoot, stderr: 'pipe', stdout: 'pipe' },
  );
}

describe('JWT release artifact gate', () => {
  test('passes for the canonical dual-key squash on main', () => {
    const result = runGate(firstValidatedDualKeyMainCommit);

    expect(result.exitCode).toBe(0);
    expect(result.stdout.toString()).toContain('JWT artifact gate passed');
    expect(result.stdout.toString()).toContain(firstValidatedDualKeyMainCommit);
  });

  test('passes for a PR head descendant of the canonical squash', () => {
    const result = runGate('HEAD');

    expect(result.exitCode).toBe(0);
    expect(result.stdout.toString()).toContain('JWT artifact gate passed');
  });

  test('rejects feature-branch dual-key SHA 5a7795f not descended from main squash', () => {
    const result = runGate(featureBranchDualKeyCommit);

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('not descended from canonical dual-key squash on main');
  });

  test('rejects pre-fixed-window dual-key SHA 9363dae not descended from main squash', () => {
    const result = runGate(preFixedWindowDualKeyCommit);

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('not descended from canonical dual-key squash on main');
  });

  test('rejects pre-dual-key ancestor of 9363dae', () => {
    const result = runGate(`${preFixedWindowDualKeyCommit}^`);

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('not descended from canonical dual-key squash on main');
  });

  test('allows rollback to a validated main-lineage artifact when the signing key is retained', () => {
    const result = runGate(firstValidatedDualKeyMainCommit, '--rollback', '--keep-signing-secret');

    expect(result.exitCode).toBe(0);
    expect(result.stdout.toString()).toContain('JWT artifact gate passed');
    expect(result.stdout.toString()).toContain(firstValidatedDualKeyMainCommit);
  });

  test('blocks rollback unless retaining JWT_SIGNING_SECRET is explicitly confirmed', () => {
    const result = runGate(firstValidatedDualKeyMainCommit, '--rollback');

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('must retain JWT_SIGNING_SECRET');
  });
});
