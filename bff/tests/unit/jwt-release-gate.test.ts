import { describe, expect, test } from 'bun:test';
import { bashCandidates, repoRoot, resolveBinary } from '../helpers/platform';

/** The gate script is bash; native-Windows Bun cannot spawn bare `bash`
 * unless a Git/MSYS bin dir happens to be on the inherited PATH, so resolve
 * portably and skip with a documented reason when no bash exists — the
 * enforcing gate remains the JWT preflight workflow on Linux CI. */
const bashBin = resolveBinary('BASH_BIN', bashCandidates);
/** The gate script also shells out to `rg`; probe it inside the very bash
 * environment the gate runs under, so Windows machines without ripgrep skip
 * cleanly instead of failing from within the script. */
const rgAvailable =
  bashBin !== null &&
  (() => {
    try {
      return (
        Bun.spawnSync([bashBin, '-c', 'command -v rg'], { stderr: 'pipe', stdout: 'pipe' })
          .exitCode === 0
      );
    } catch {
      return false;
    }
  })();
const gateReady = bashBin !== null && rgAvailable;
if (!gateReady) {
  console.warn(
    `[jwt-release-gate] skipping gate tests: ${!bashBin ? 'bash' : 'rg (ripgrep)'} not found. The JWT preflight workflow remains the enforcing gate.`,
  );
}
const bashTest = gateReady ? test : test.skip;
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
    // Non-null: runGate only runs inside bashTest, skipped when unresolved.
    [bashBin as string, 'scripts/verify-jwt-release-artifact.sh', candidate, ...options],
    { cwd: repoRoot, stderr: 'pipe', stdout: 'pipe' },
  );
}

describe('JWT release artifact gate', () => {
  bashTest('passes for the canonical dual-key squash on main', () => {
    const result = runGate(firstValidatedDualKeyMainCommit);

    expect(result.exitCode).toBe(0);
    expect(result.stdout.toString()).toContain('JWT artifact gate passed');
    expect(result.stdout.toString()).toContain(firstValidatedDualKeyMainCommit);
  });

  bashTest('passes for a PR head descendant of the canonical squash', () => {
    const result = runGate('HEAD');

    expect(result.exitCode).toBe(0);
    expect(result.stdout.toString()).toContain('JWT artifact gate passed');
  });

  bashTest('rejects the immediate pre-dual-key parent of the canonical squash', () => {
    const result = runGate(preDualKeyMainParent);

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('not descended from canonical dual-key squash on main');
  });

  bashTest('rejects an older pre-dual-key main ancestor of the canonical squash', () => {
    const result = runGate(preDualKeyMainAncestor);

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('not descended from canonical dual-key squash on main');
  });

  bashTest('rejects a still-older pre-dual-key main ancestor of the canonical squash', () => {
    const result = runGate(olderPreDualKeyMainAncestor);

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('not descended from canonical dual-key squash on main');
  });

  bashTest('allows rollback to a validated main-lineage artifact when the signing key is retained', () => {
    const result = runGate(firstValidatedDualKeyMainCommit, '--rollback', '--keep-signing-secret');

    expect(result.exitCode).toBe(0);
    expect(result.stdout.toString()).toContain('JWT artifact gate passed');
    expect(result.stdout.toString()).toContain(firstValidatedDualKeyMainCommit);
  });

  bashTest('blocks rollback unless retaining JWT_SIGNING_SECRET is explicitly confirmed', () => {
    const result = runGate(firstValidatedDualKeyMainCommit, '--rollback');

    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('must retain JWT_SIGNING_SECRET');
  });
});
