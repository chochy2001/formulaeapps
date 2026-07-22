import { describe, expect, test } from 'bun:test';
import { join } from 'node:path';
import {
  bashCandidates,
  python3Candidates,
  repoRoot,
  resolveBinary,
  shellcheckCandidates,
} from '../helpers/platform';

/** External tools are resolved portably (native-Windows Bun cannot spawn bare
 * `bash`/`python3` unless a Git/MSYS bin dir is on the inherited PATH) and
 * each group skips with a documented reason when its binary is absent — the
 * enforcing gates for these scripts run in Linux CI. */
const bashBin = resolveBinary('BASH_BIN', bashCandidates);
const pythonBin = resolveBinary('PYTHON3_BIN', python3Candidates);
const shellcheckBin = resolveBinary('SHELLCHECK_BIN', shellcheckCandidates);
if (!bashBin) {
  console.warn('[staging-deploy] bash not found; skipping bash-backed tests (enforced by Linux CI).');
}
if (!pythonBin) {
  console.warn('[staging-deploy] python3 not found; skipping python-backed tests (enforced by Linux CI).');
}
if (!shellcheckBin) {
  console.warn('[staging-deploy] shellcheck not found; skipping lint test (pinned shellcheck runs in the jwt-pr-preflight workflow).');
}
// Non-null assertions below are safe: each helper only runs inside its own
// gated alias, which is test.skip when the binary was not resolved.
const bashTest = bashBin ? test : test.skip;
const pythonTest = pythonBin ? test : test.skip;
const shellcheckTest = shellcheckBin ? test : test.skip;
/** test_staging_lib.py asserts POSIX-only semantics of the deploy-target
 * library (chmod 0600 bits, symlink replace via os.replace) that Windows
 * does not implement, so that one suite is POSIX-only; Linux CI enforces it.
 * The transport tests below are pure arg/JSON validation and DO run here. */
const stagingLibTest = process.platform !== 'win32' && pythonBin ? test : test.skip;
if (process.platform === 'win32') {
  console.warn(
    '[staging-deploy] skipping python staging lib suite on Windows: staging_lib asserts POSIX-only semantics (chmod bits, symlink replace); Linux CI remains the enforcing gate.',
  );
}

function runPython(args: string[], cwd = repoRoot) {
  return Bun.spawnSync([pythonBin as string, ...args], { cwd, stderr: 'pipe', stdout: 'pipe', env: process.env });
}

function runBash(script: string, args: string[] = [], env: Record<string, string> = {}) {
  return Bun.spawnSync([bashBin as string, script, ...args], {
    cwd: repoRoot,
    stderr: 'pipe',
    stdout: 'pipe',
    env: { ...process.env, ...env },
  });
}

describe('staging deploy hardening', () => {
  stagingLibTest('python staging lib suite passes', () => {
    const result = runPython(['scripts/test_staging_lib.py', '-v']);
    expect(result.exitCode).toBe(0);
    const combined = result.stdout.toString() + result.stderr.toString();
    expect(combined).toContain('OK');
  });

  bashTest('validate-legacy-window accepts fractional UTC for staging max', () => {
    const result = runBash('scripts/validate-legacy-window.sh', [
      '2026-07-10T00:00:00.000Z',
      '2026-07-10T00:10:00.500Z',
    ], { STAGING_LEGACY_MAX_MS: '1200000' });
    expect(result.exitCode).toBe(0);
  });

  bashTest('validate-legacy-window rejects prod window under staging cap', () => {
    const result = runBash('scripts/validate-legacy-window.sh', [
      '2026-07-10T00:00:00Z',
      '2026-07-10T02:00:00Z',
    ], { STAGING_LEGACY_MAX_MS: '1200000' });
    expect(result.exitCode).not.toBe(0);
  });

  pythonTest('staging transport rejects invalid candidate SHA', () => {
    const result = runPython([
      'scripts/staging-transport.py',
      'deploy',
      'not-a-sha',
      '/opt/staging/apps/formulaeapps',
      '2026-07-10T00:00:00Z',
      '2026-07-10T00:05:00Z',
    ]);
    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('candidate_sha');
  });

  pythonTest('staging transport JSON excludes secret field names as values', () => {
    const start = new Date(Date.now() - 60_000).toISOString();
    const cutoff = new Date(Date.now() + 960_000).toISOString();
    const result = runPython([
      'scripts/staging-transport.py',
      'deploy',
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      '/opt/staging/apps/formulaeapps',
      start,
      cutoff,
      'https://staging.api.formulaeapps.com',
    ]);
    expect(result.exitCode).toBe(0);
    const payload = result.stdout.toString();
    expect(payload).not.toMatch(/JWT_(SHARED|SIGNING)_SECRET=/);
    expect(JSON.parse(payload).action).toBe('deploy');
  });

  pythonTest('staging transport rejects production readiness URL', () => {
    const start = new Date(Date.now() - 60_000).toISOString();
    const cutoff = new Date(Date.now() + 960_000).toISOString();
    const result = runPython([
      'scripts/staging-transport.py',
      'deploy',
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      '/opt/staging/apps/formulaeapps',
      start,
      cutoff,
      'https://api.formulaeapps.com',
    ]);
    expect(result.exitCode).not.toBe(0);
    expect(result.stderr.toString()).toContain('readiness base URL');
  });

  pythonTest('staging transport accepts only approved staging base URL', () => {
    const start = new Date(Date.now() - 60_000).toISOString();
    const cutoff = new Date(Date.now() + 960_000).toISOString();
    const result = runPython([
      'scripts/staging-transport.py',
      'deploy',
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      '/opt/staging/apps/formulaeapps',
      start,
      cutoff,
      'https://staging.api.formulaeapps.com',
      'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
    ]);
    expect(result.exitCode).toBe(0);
    const payload = JSON.parse(result.stdout.toString());
    expect(payload.readiness_base_url).toBe('https://staging.api.formulaeapps.com');
    expect(payload.control_sha).toBe('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
  });

  test('deploy workflow uses control scripts path not candidate release scripts', () => {
    const workflow = Bun.file(join(repoRoot, '.github', 'workflows', 'deploy-staging-bff.yml'));
    // eslint-disable-next-line @typescript-eslint/no-floating-promises
    return workflow.text().then((text) => {
      expect(text).toContain('remote_control_dir}/staging_deploy_remote.py');
      expect(text).toContain('remote_control_dir}/staging-check-env.py');
      expect(text).toContain('cfg[\\"control_dir\\"] + \\"/jwt-staging-smoke.sh\\"');
      expect(text).not.toMatch(/\$\{RELEASE_PATH\}\/scripts\/staging_deploy_remote\.py/);
      expect(text).not.toMatch(/current\/scripts\/jwt-staging-smoke\.sh/);
      expect(text).toContain('candidate-tree');
      expect(text).toContain('control_sha');
    });
  });

  test('jwt preflight verifies checksum-locked warm security tools', async () => {
    const workflow = Bun.file(join(repoRoot, '.github', 'workflows', 'jwt-pr-preflight.yml'));
    const preload = Bun.file(join(repoRoot, 'scripts', 'ci-ensure-jwt-tools.sh'));
    const [workflowText, preloadText] = await Promise.all([workflow.text(), preload.text()]);

    expect(workflowText).toContain('ci-ensure-jwt-tools.sh --verify-only');
    expect(workflowText).toContain('head.repo.full_name != github.repository');
    expect(workflowText).toContain('base.sha }}...${{ github.event.pull_request.head.sha }}');
    expect(preloadText).toContain('readonly SHELLCHECK_VERSION="0.10.0"');
    expect(preloadText).toContain('readonly GITLEAKS_VERSION="8.30.1"');
    expect(preloadText).toContain('readonly SHELLCHECK_SHA256="6c881ab0698e4e6ea235245f22832860544f17ba386442fe7e9d629f8cbedf87"');
  });

  shellcheckTest('shellcheck-clean staging scripts', () => {
    const scripts = [
      'scripts/staging-deploy-remote.sh',
      'scripts/staging-rollback-remote.sh',
      'scripts/staging-sync-release.sh',
      'scripts/jwt-staging-smoke.sh',
      'scripts/validate-legacy-window.sh',
    ];
    for (const script of scripts) {
      const result = Bun.spawnSync([shellcheckBin as string, '-x', script], { cwd: repoRoot, stderr: 'pipe', stdout: 'pipe' });
      expect(result.exitCode).toBe(0);
    }
  });
});
