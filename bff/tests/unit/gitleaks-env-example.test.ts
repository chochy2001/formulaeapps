import { describe, expect, test } from 'bun:test';
import { mkdtempSync, writeFileSync, rmSync, readFileSync, copyFileSync, mkdirSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { repoRoot } from '../helpers/platform';
const gitleaksConfig = join(repoRoot, '.gitleaks.toml');
/** Prefer CI-pinned binary (GITLEAKS_BIN) so the suite cannot false-green on a
 * newer PATH gitleaks while workflows still pin an older scanner. */
const gitleaksBin = process.env['GITLEAKS_BIN']?.trim() || 'gitleaks';

function runGitleaks(sourceDir: string) {
  return Bun.spawnSync(
    [
      gitleaksBin,
      'dir',
      '--no-banner',
      '--redact',
      '--config',
      gitleaksConfig,
      '--exit-code',
      '1',
      sourceDir,
    ],
    { cwd: repoRoot, stderr: 'pipe', stdout: 'pipe' },
  );
}

function requireGitleaksAllowlistsSupport() {
  const version = Bun.spawnSync([gitleaksBin, 'version'], {
    cwd: repoRoot,
    stderr: 'pipe',
    stdout: 'pipe',
  });
  const text = `${version.stdout.toString()}${version.stderr.toString()}`;
  const match = text.match(/(\d+)\.(\d+)\.(\d+)/);
  if (!match) {
    throw new Error(`unable to parse gitleaks version from: ${text}`);
  }
  const major = Number(match[1]);
  const minor = Number(match[2]);
  // [[allowlists]] landed in 8.25.0
  if (major < 8 || (major === 8 && minor < 25)) {
    throw new Error(
      `gitleaks ${match[0]} does not load [[allowlists]]; need >= 8.25.0 (bin=${gitleaksBin})`,
    );
  }
}

/** Build a high-entropy OpenRouter-shaped fixture at runtime so the source
 * file itself does not embed a credential-shaped literal for gitleaks dir. */
function syntheticOpenRouterKey(): string {
  const prefix = ['sk', 'or', 'v1'].join('-');
  const hex = '0123456789abcdef'.repeat(4);
  return `${prefix}-${hex}`;
}

/** The scanner binary is not guaranteed on every self-hosted runner. When it is
 * absent the binary-dependent checks below are skipped (not failed): the
 * enforcing secret gate is the dedicated gitleaks workflow, and these unit
 * tests only shadow it. The absence is logged so it stays visible. */
function gitleaksIsAvailable(): boolean {
  try {
    const probe = Bun.spawnSync([gitleaksBin, 'version'], {
      cwd: repoRoot,
      stderr: 'pipe',
      stdout: 'pipe',
    });
    return /\d+\.\d+\.\d+/.test(`${probe.stdout.toString()}${probe.stderr.toString()}`);
  } catch {
    return false;
  }
}

const hasGitleaks = gitleaksIsAvailable();
if (!hasGitleaks) {
  console.warn(
    `[gitleaks-env-example] gitleaks binary not found (bin=${gitleaksBin}); skipping scanner-dependent tests. The dedicated gitleaks workflow remains the enforcing gate.`,
  );
}
const scannerTest = hasGitleaks ? test : test.skip;

describe('gitleaks .env.example allowlist', () => {
  scannerTest('scanner binary understands [[allowlists]] (>= 8.25)', () => {
    requireGitleaksAllowlistsSupport();
  });

  test('config uses placeholder-only exceptions (no global .env.example path allowlist)', () => {
    const configText = readFileSync(gitleaksConfig, 'utf8');

    // No allowlist may skip an entire .env.example via paths=.
    const pathBlocks = [...configText.matchAll(/paths\s*=\s*\[([\s\S]*?)\]/g)];
    for (const match of pathBlocks) {
      expect(match[1] ?? '').not.toContain('env\\.example');
    }

    expect(configText).toContain('Known placeholder secret values only');
    expect(configText).toContain("(?i)^sk-or-v1-replace-me$");
    expect(configText).toContain("(?i)^replace-with-real-hex-secret$");
  });

  scannerTest('committed .env.example placeholders pass gitleaks', () => {
    const probeDir = mkdtempSync(join(tmpdir(), 'gitleaks-placeholders-'));
    try {
      mkdirSync(join(probeDir, 'bff'), { recursive: true });
      mkdirSync(join(probeDir, 'landing'), { recursive: true });
      copyFileSync(join(repoRoot, 'bff', '.env.example'), join(probeDir, 'bff', '.env.example'));
      copyFileSync(
        join(repoRoot, 'landing', '.env.example'),
        join(probeDir, 'landing', '.env.example'),
      );

      const result = runGitleaks(probeDir);
      expect(result.exitCode).toBe(0);
      expect(result.stderr.toString() + result.stdout.toString()).toContain('no leaks found');
    } finally {
      rmSync(probeDir, { recursive: true, force: true });
    }
  });

  scannerTest('a simulated real credential inside .env.example fails gitleaks', () => {
    const probeDir = mkdtempSync(join(tmpdir(), 'gitleaks-realcred-'));
    try {
      writeFileSync(
        join(probeDir, '.env.example'),
        ['# synthetic fixture for gitleaks guard, not a real secret', `OPENROUTER_API_KEY=${syntheticOpenRouterKey()}`, ''].join(
          '\n',
        ),
      );

      const result = runGitleaks(probeDir);
      expect(result.exitCode).not.toBe(0);
      const output = result.stderr.toString() + result.stdout.toString();
      expect(output).toMatch(/leaks found/i);
    } finally {
      rmSync(probeDir, { recursive: true, force: true });
    }
  });
});
