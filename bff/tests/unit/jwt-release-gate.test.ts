import { describe, expect, test } from 'bun:test';

const repoRoot = new URL('../../..', import.meta.url).pathname;
/** Canonical squash on main with exclusive signing + immutable UTC [start, cutoff). */
const firstValidatedDualKeyMainCommit = ['6c681716b5b20e60c1cf5898c61b2719171fa94', 'f'].join('');
//
// Rejection fixtures MUST resolve in any clean checkout of main. The historical
// off-lineage SHAs this gate was born to reject (the pre-squash feature-branch
// dual-key commit 5a7795f and the pre-fixed-window dual-key commit 9363dae) are
// unreachable from main, so they exist only as dangling loose objects in a
// contaminated developer clone. A clean CI checkout (shallow or full) never
// contains them, so `git cat-file -e` misses and the gate exits 2 ("candidate
// must identify a local Git commit") instead of exercising the real lineage
// check. Assert the gate's descent property against commits that are guaranteed
// present on main and are NOT descendants of the canonical squash: its own
// pre-dual-key ancestors. Rejecting an ancestor proves a release candidate
// cannot point at pre-migration main history.
const preDualKeyMainParent = `${firstValidatedDualKeyMainCommit}~1`;
const preDualKeyMainAncestor = `${firstValidatedDualKeyMainCommit}~2`;
const olderPreDualKeyMainAncestor = `${firstValidatedDualKeyMainCommit}~3`;

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

  test('rejects the immediate pre-dual-key parent of the canonical squash', () => {
    const result = runGate(preDualKeyMainParent);

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('not descended from canonical dual-key squash on main');
  });

  test('rejects an older pre-dual-key main ancestor of the canonical squash', () => {
    const result = runGate(preDualKeyMainAncestor);

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('not descended from canonical dual-key squash on main');
  });

  test('rejects a still-older pre-dual-key main ancestor of the canonical squash', () => {
    const result = runGate(olderPreDualKeyMainAncestor);

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
