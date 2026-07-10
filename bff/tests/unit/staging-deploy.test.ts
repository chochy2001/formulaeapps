import { describe, expect, test } from 'bun:test';

const repoRoot = new URL('../../..', import.meta.url).pathname;

function runPython(args: string[], cwd = repoRoot) {
  return Bun.spawnSync(['python3', ...args], { cwd, stderr: 'pipe', stdout: 'pipe', env: process.env });
}

function runBash(script: string, args: string[] = [], env: Record<string, string> = {}) {
  return Bun.spawnSync(['bash', script, ...args], {
    cwd: repoRoot,
    stderr: 'pipe',
    stdout: 'pipe',
    env: { ...process.env, ...env },
  });
}

describe('staging deploy hardening', () => {
  test('python staging lib suite passes', () => {
    const result = runPython(['scripts/test_staging_lib.py', '-v']);
    expect(result.exitCode).toBe(0);
    const combined = result.stdout.toString() + result.stderr.toString();
    expect(combined).toContain('OK');
  });

  test('validate-legacy-window accepts fractional UTC for staging max', () => {
    const result = runBash('scripts/validate-legacy-window.sh', [
      '2026-07-10T00:00:00.000Z',
      '2026-07-10T00:10:00.500Z',
    ], { STAGING_LEGACY_MAX_MS: '1200000' });
    expect(result.exitCode).toBe(0);
  });

  test('validate-legacy-window rejects prod window under staging cap', () => {
    const result = runBash('scripts/validate-legacy-window.sh', [
      '2026-07-10T00:00:00Z',
      '2026-07-10T02:00:00Z',
    ], { STAGING_LEGACY_MAX_MS: '1200000' });
    expect(result.exitCode).not.toBe(0);
  });

  test('staging transport rejects invalid candidate SHA', () => {
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

  test('staging transport JSON excludes secret field names as values', () => {
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

  test('shellcheck-clean staging scripts', () => {
    const scripts = [
      'scripts/staging-deploy-remote.sh',
      'scripts/staging-rollback-remote.sh',
      'scripts/staging-sync-release.sh',
      'scripts/jwt-staging-smoke.sh',
      'scripts/validate-legacy-window.sh',
    ];
    for (const script of scripts) {
      const result = Bun.spawnSync(['shellcheck', '-x', script], { cwd: repoRoot, stderr: 'pipe', stdout: 'pipe' });
      expect(result.exitCode).toBe(0);
    }
  });
});
