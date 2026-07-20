import { fileURLToPath } from 'node:url';

/**
 * Repo root (formulaeapps/) as a real platform path.
 *
 * `new URL(...).pathname` is NOT a filesystem path on Windows: it keeps the
 * URL leading slash (`/A:/...`), so node:fs joins produce `\A:\...` and every
 * spawn using it as cwd fails with the misleading
 * `ENOENT: no such file or directory, uv_spawn '<binary>'` (the cwd, not the
 * binary, is what does not exist). Always derive paths via fileURLToPath.
 */
export const repoRoot = fileURLToPath(new URL('../../..', import.meta.url));

/**
 * Candidate binary names/paths per tool, ordered by preference. On Windows,
 * Bun's uv_spawn only resolves names that exist verbatim (`.exe` included) on
 * the inherited PATH, and Git-Bash/MSYS tools are not guaranteed to be on the
 * Windows PATH of every machine — so we also probe the standard Git for
 * Windows install locations by absolute path.
 */
export const bashCandidates =
  process.platform === 'win32'
    ? [
        'bash.exe',
        'bash',
        'C:\\Program Files\\Git\\bin\\bash.exe',
        'C:\\Program Files\\Git\\usr\\bin\\bash.exe',
        'C:\\Program Files (x86)\\Git\\bin\\bash.exe',
      ]
    : ['bash'];

export const python3Candidates =
  process.platform === 'win32'
    ? ['python3.exe', 'python3', 'python.exe', 'python']
    : ['python3', 'python'];

export const shellcheckCandidates =
  process.platform === 'win32' ? ['shellcheck.exe', 'shellcheck'] : ['shellcheck'];

/**
 * Resolve an external test binary to a spawn-able name or absolute path.
 *
 * `envVar` (e.g. BASH_BIN) overrides detection, mirroring the existing
 * SHELLCHECK_BIN / GITLEAKS_BIN convention. Returns null when no candidate
 * runs; the caller must then skip the dependent tests with a documented
 * reason (the enforcing gates for these scripts run in Linux CI). The probe
 * try/catch ONLY detects a missing binary — it never wraps real test
 * executions, so genuine script failures still fail loudly.
 */
export function resolveBinary(envVar: string, candidates: string[]): string | null {
  const override = process.env[envVar]?.trim();
  if (override) {
    return probe(override) ? override : null;
  }
  for (const candidate of candidates) {
    if (probe(candidate)) {
      return candidate;
    }
  }
  return null;
}

function probe(binary: string): boolean {
  try {
    const result = Bun.spawnSync([binary, '--version'], {
      stderr: 'pipe',
      stdout: 'pipe',
    });
    return result.exitCode === 0;
  } catch {
    return false;
  }
}
