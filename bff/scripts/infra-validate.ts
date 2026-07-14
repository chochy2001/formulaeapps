#!/usr/bin/env bun
/**
 * infra-validate — Multi-app infrastructure verification (Principle IX gate).
 *
 * Per specs/002-formulae-fe-be-sync/tasks.md T120 + data-model.md § E13.
 *
 * Modes:
 *   --local       Compose lint + local CORS preflight + workspace Traefik router-collision scan.
 *                 No HTTPS/TLS checks against production hostnames.
 *   (default)     Local checks + production HTTPS/TLS + production CORS preflight.
 *
 * Output: structured JSON to stdout per data-model.md § E13.
 * Exit:   0 PASS, 1 FAIL, 2 setup error.
 *
 * Invoked via the top-level scripts/infra-validate.sh wrapper.
 */

import { resolve, dirname, relative } from 'node:path';
import { fileURLToPath } from 'node:url';
import { readFileSync, readdirSync, statSync, existsSync } from 'node:fs';
import { execFileSync } from 'node:child_process';

const here = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(here, '..', '..'); // bff/scripts → bff → monorepo root
// A checkout may live directly below Apps, below Apps/worktrees, or outside
// the workspace. Prefer the enclosing Apps directory when it has the shared
// AGENTS.md; otherwise use the documented home workspace.
const enclosingWorkspace = resolve(ROOT, '..', '..');
const WORKSPACE = existsSync(resolve(enclosingWorkspace, 'AGENTS.md'))
  ? enclosingWorkspace
  : resolve(process.env['HOME'] ?? '/Users/jorge', 'Documents', 'Apps');

const args = Bun.argv.slice(2);
const LOCAL_MODE = args.includes('--local');

// ─── Production hostnames per spec FR-014 + plan.md production topology ─────
const PROD_HOSTS: ReadonlyArray<{ host: string; path: string; description: string }> = [
  { host: 'formulaeapps.com', path: '/', description: 'landing apex (Hostinger LiteSpeed)' },
  { host: 'www.formulaeapps.com', path: '/', description: 'landing www (Hostinger)' },
  { host: 'app.formulaeapps.com', path: '/', description: 'Pro Web (Hostinger /app)' },
  { host: 'api.formulaeapps.com', path: '/health', description: 'BFF health (VPS Contabo, post-cutover)' },
];

const LOCAL_BFF_URL = 'http://localhost:3001';
const ALLOWED_ORIGINS = [
  'https://app.formulaeapps.com',
  'https://formulaeapps.com',
];

// ─── Result types per data-model.md § E13 ──────────────────────────────────
type HostnameResult = {
  host: string;
  http_status: number | null;
  tls_valid: boolean | null;
  tls_expires: string | null;
  tls_issuer: string | null;
  cors_allow_origin: string | null;
  cors_preflight_ok: boolean | null;
  cloudflare_proxied: boolean | null;
  notes: string;
};

type ComposeLint = { result: 'PASS' | 'FAIL'; warnings: string[]; file: string };
type RouterCollision = { router_name: string; files: string[] };
type Report = {
  generated_at: string;
  mode: 'local' | 'production';
  hostnames: HostnameResult[];
  compose_lint: ComposeLint[];
  // CRITICAL: formulae-* router declared outside the formulaeapps project,
  // OR formulae-* used by an unrelated stack. These FAIL the gate.
  formulae_router_collisions: RouterCollision[];
  // INFO: other cross-project router-name reuse in the workspace. Reported for
  // workspace hygiene insight; does NOT fail this feature's gate (separate VPS).
  workspace_router_collisions: RouterCollision[];
  traefik_routers_total: number;
  cors_preflight_local: { target: string; ok: boolean | null; reason: string } | null;
  exit_status: 'PASS' | 'FAIL';
};

// ─── Helpers ───────────────────────────────────────────────────────────────
function tryExec(cmd: string, args: string[], timeoutMs = 8000): { stdout: string; stderr: string; status: number } {
  try {
    const stdout = execFileSync(cmd, args, {
      stdio: ['ignore', 'pipe', 'pipe'],
      timeout: timeoutMs,
      encoding: 'utf8',
    });
    return { stdout, stderr: '', status: 0 };
  } catch (err) {
    const e = err as { status?: number; stdout?: string; stderr?: string };
    return {
      stdout: typeof e.stdout === 'string' ? e.stdout : '',
      stderr: typeof e.stderr === 'string' ? e.stderr : String(err),
      status: typeof e.status === 'number' ? e.status : 1,
    };
  }
}

function asRecord(value: unknown): Record<string, unknown> | null {
  return value !== null && typeof value === 'object' && !Array.isArray(value)
    ? value as Record<string, unknown>
    : null;
}

function isEmptyComposeField(value: unknown): boolean {
  if (value === undefined || value === null) return true;
  if (Array.isArray(value)) return value.length === 0;
  const record = asRecord(value);
  return record !== null && Object.keys(record).length === 0;
}

/**
 * `docker compose config --quiet` only validates syntax. The local overlay
 * relies on Compose reset tags, so verify the merged BFF has actually shed its
 * VPS-only inputs. This prevents an innocuous-looking empty list/map from
 * silently merging the production env file, Traefik network, or secrets back.
 */
function lintLocalOverlayIsolation(base: string, overlay: string): ComposeLint {
  const rendered = tryExec('docker', [
    'compose', '-f', base, '-f', overlay, '--profile', 'full', 'config', '--format', 'json',
  ]);
  const file = 'docker-compose.yml + local overlay (local isolation)';
  if (rendered.status !== 0) {
    return {
      result: 'FAIL',
      warnings: [rendered.stderr.split('\n').slice(0, 3).join(' ')],
      file,
    };
  }

  try {
    const root = asRecord(JSON.parse(rendered.stdout));
    const services = root === null ? null : asRecord(root['services']);
    const bff = services === null ? null : asRecord(services['bff']);
    if (bff === null) {
      return { result: 'FAIL', warnings: ['Merged local config has no bff service'], file };
    }

    const warnings: string[] = [];
    const networks = asRecord(bff['networks']);
    if (networks === null || Object.keys(networks).length !== 1 || !Object.hasOwn(networks, 'default')) {
      warnings.push('BFF local config must use only the default network');
    }
    if (!isEmptyComposeField(bff['env_file'])) warnings.push('BFF local config still inherits env_file');
    if (!isEmptyComposeField(bff['secrets'])) warnings.push('BFF local config still inherits IAP secrets');
    if (!isEmptyComposeField(bff['labels'])) warnings.push('BFF local config still inherits Traefik labels');

    const bffEnvironment = asRecord(bff['environment']);
    if (process.env['JWT_SIGNING_SECRET'] === undefined && bffEnvironment?.['JWT_SIGNING_SECRET'] !== '') {
      warnings.push('BFF local config must not embed a deterministic JWT signing secret');
    }

    const ports = Array.isArray(bff['ports']) ? bff['ports'] : [];
    const hasLoopbackPort = ports.some((entry) => {
      const port = asRecord(entry);
      return port !== null &&
        String(port['host_ip']) === '127.0.0.1' &&
        String(port['published']) === '3001' &&
        String(port['target']) === '3000';
    });
    if (!hasLoopbackPort) {
      warnings.push('BFF local config must expose only 127.0.0.1:3001 to container port 3000');
    }

    const pro = services === null ? null : asRecord(services['pro']);
    const build = pro === null ? null : asRecord(pro['build']);
    const buildArgs = build === null ? null : asRecord(build['args']);
    if (
      buildArgs === null ||
      buildArgs['FORMULAE_BFF_BASE_URL'] !== 'http://localhost:3001' ||
      buildArgs['FORMULAE_BFF_CHAT_URL'] !== 'http://localhost:3001/openai/chat'
    ) {
      warnings.push('Pro local build must use the local BFF base URL and /openai/chat endpoint');
    }

    return warnings.length === 0
      ? { result: 'PASS', warnings: [], file }
      : { result: 'FAIL', warnings, file };
  } catch (err) {
    return {
      result: 'FAIL',
      warnings: [`Unable to parse merged local Compose JSON: ${err instanceof Error ? err.message : String(err)}`],
      file,
    };
  }
}

function findComposeFiles(root: string, depth = 4): string[] {
  const out: string[] = [];
  if (!existsSync(root)) return out;
  const stack: Array<{ dir: string; remaining: number }> = [{ dir: root, remaining: depth }];
  const SKIP_DIRS = new Set([
    'node_modules', '.git', '.dart_tool', 'build', 'dist', '.next',
    '.tmp.driveupload', '.specify', 'imagenes_app_archivadas', 'audits',
    // Workspace policy: generated worktrees and protected client repos are
    // not part of fleet-wide infrastructure scans.
    'worktrees', 'copilot-worktrees', 'No_tocar_repos_clientes',
  ]);
  while (stack.length) {
    const { dir, remaining } = stack.pop()!;
    if (remaining < 0) continue;
    let entries: string[] = [];
    try { entries = readdirSync(dir); } catch { continue; }
    for (const entry of entries) {
      if (SKIP_DIRS.has(entry)) continue;
      const full = resolve(dir, entry);
      let st;
      try { st = statSync(full); } catch { continue; }
      if (st.isDirectory()) stack.push({ dir: full, remaining: remaining - 1 });
      else if (st.isFile() && /^docker-compose(\.[a-z0-9-]+)?\.ya?ml$/i.test(entry)) {
        out.push(full);
      }
    }
  }
  return out;
}

const TRAEFIK_ROUTER_RE = /traefik\.http\.routers\.([a-zA-Z0-9_-]+)\.rule/g;
function extractRouterNames(file: string): string[] {
  let text;
  try { text = readFileSync(file, 'utf8'); } catch { return []; }
  const seen = new Set<string>();
  let m: RegExpExecArray | null;
  TRAEFIK_ROUTER_RE.lastIndex = 0;
  while ((m = TRAEFIK_ROUTER_RE.exec(text)) !== null) {
    if (m[1]) seen.add(m[1]);
  }
  return [...seen];
}

// ─── Checks ────────────────────────────────────────────────────────────────
function lintComposes(localMode: boolean): ComposeLint[] {
  const results: ComposeLint[] = [];
  const base = resolve(ROOT, 'docker-compose.yml');
  const localOverlay = resolve(ROOT, 'docker-compose.local.yml');

  // 1. The production base intentionally requires its protected `.env` and
  //    must be self-contained in production mode. Local mode instead checks
  //    the merged override, which deliberately resets that production input.
  if (!localMode && existsSync(base)) {
    const lint = tryExec('docker', ['compose', '-f', base, 'config', '--quiet']);
    results.push(
      lint.status === 0
        ? { result: 'PASS', warnings: [], file: relative(ROOT, base) }
        : { result: 'FAIL', warnings: [lint.stderr.split('\n').slice(0, 3).join(' ')], file: relative(ROOT, base) },
    );
  }

  // 2. Lint base + explicit local overlay. It is intentionally not an
  //    automatically loaded docker-compose.override.yml.
  if (existsSync(localOverlay)) {
    const lint = tryExec('docker', ['compose', '-f', base, '-f', localOverlay, 'config', '--quiet']);
    results.push(
      lint.status === 0
        ? { result: 'PASS', warnings: [], file: 'docker-compose.yml + local overlay (merged)' }
        : { result: 'FAIL', warnings: [lint.stderr.split('\n').slice(0, 3).join(' ')], file: 'docker-compose.yml + local overlay (merged)' },
    );
    if (localMode && lint.status === 0) results.push(lintLocalOverlayIsolation(base, localOverlay));
  } else if (localMode) {
    results.push({
      result: 'FAIL',
      warnings: ['Local validation requires docker-compose.local.yml'],
      file: 'docker-compose.local.yml',
    });
  }

  return results;
}

/**
 * Extract a "project key" from a compose file path so collisions WITHIN a project
 * (e.g., docker-compose.yml + docker-compose.prod.yml in the same dir) aren't
 * misreported as cross-app collisions.
 *
 * Key = first identifying segment after a known workspace root.
 */
function projectKey(filePath: string): string {
  // The active checkout may itself live under Apps/worktrees. It is the same
  // FormulaeApps project as the canonical clone, not a cross-project router
  // collision.
  const home = process.env['HOME'] ?? '';
  if (filePath.startsWith(`${ROOT}/`)) return 'formulaeapps';
  const rootRelative = ROOT.replace(home, '~');
  if (filePath.startsWith(`${rootRelative}/`)) return 'formulaeapps';

  const rel = filePath.replace(home, '~');
  // Group by the top-level project dir:
  //   ~/Code/formulaeapps/...                           → "formulaeapps"
  //   ~/Documents/Apps/Formulae/monorepo/... or
  //   ~/Documents/Apps/FormulaeApps/formulaeapps-monorepo/...
  //     → "formulaeapps" (this is the zombie clone of canonical,
  //        same project — US1 will retire it)
  //   ~/Documents/Apps/<Foo>/...                        → "ws:<Foo>"
  if (rel.startsWith('~/Code/formulaeapps/')) return 'formulaeapps';
  if (rel.startsWith('~/Documents/Apps/Formulae/monorepo/')) return 'formulaeapps';
  if (rel.startsWith('~/Documents/Apps/FormulaeApps/formulaeapps-monorepo/')) return 'formulaeapps';
  const m = rel.match(/^~\/Documents\/Apps\/([^/]+)\//);
  if (m && m[1]) return `ws:${m[1]}`;
  return `other:${rel}`;
}

function isFormulaeRouter(name: string): boolean {
  return name.startsWith('formulae-') || name === 'formulae-www';
}

function scanRouterCollisions(): { collisions: RouterCollision[]; total: number } {
  // Workspace compose files (top-level Apps repos) + canonical clone composes
  const canonicalComposes = findComposeFiles(ROOT, 2);
  const workspaceComposes = findComposeFiles(WORKSPACE, 4);
  const allComposes = [...new Set([...canonicalComposes, ...workspaceComposes])];

  const routerToFiles = new Map<string, Set<string>>();
  for (const f of allComposes) {
    for (const router of extractRouterNames(f)) {
      let set = routerToFiles.get(router);
      if (!set) { set = new Set(); routerToFiles.set(router, set); }
      set.add(f);
    }
  }
  const collisions: RouterCollision[] = [];
  for (const [router, files] of routerToFiles) {
    if (files.size > 1) {
      collisions.push({
        router_name: router,
        files: [...files].map((p) => p.replace(process.env['HOME'] ?? '~', '~')),
      });
    }
  }
  return { collisions, total: routerToFiles.size };
}

async function corsPreflightLocal(): Promise<Report['cors_preflight_local']> {
  // Only attempt if a BFF appears to be listening locally
  const target = `${LOCAL_BFF_URL}/openai/chat`;
  try {
    const res = await fetch(target, {
      method: 'OPTIONS',
      headers: {
        'Origin': 'https://app.formulaeapps.com',
        'Access-Control-Request-Method': 'POST',
        'Access-Control-Request-Headers': 'content-type,authorization',
      },
      signal: AbortSignal.timeout(3000),
    });
    const allowOrigin = res.headers.get('access-control-allow-origin');
    const ok = res.ok && allowOrigin === 'https://app.formulaeapps.com';
    return {
      target,
      ok,
      reason: ok
        ? `200 + Access-Control-Allow-Origin matches https://app.formulaeapps.com`
        : `status=${res.status} allow-origin="${allowOrigin}"`,
    };
  } catch (err) {
    return {
      target,
      ok: null,
      reason: `BFF not reachable locally: ${err instanceof Error ? err.message : 'unknown'} (start with: make compose-up)`,
    };
  }
}

async function checkHostnames(): Promise<HostnameResult[]> {
  const out: HostnameResult[] = [];
  for (const { host, path, description } of PROD_HOSTS) {
    const result: HostnameResult = {
      host,
      http_status: null,
      tls_valid: null,
      tls_expires: null,
      tls_issuer: null,
      cors_allow_origin: null,
      cors_preflight_ok: null,
      cloudflare_proxied: null,
      notes: `${description} (${path})`,
    };
    try {
      const head = await fetch(`https://${host}${path}`, {
        method: 'HEAD',
        redirect: 'manual',
        signal: AbortSignal.timeout(8000),
      });
      result.http_status = head.status;
      // Cloudflare proxy detection
      const cfRay = head.headers.get('cf-ray');
      result.cloudflare_proxied = cfRay !== null;
    } catch (err) {
      result.notes = `${description} (${path}) — fetch failed: ${err instanceof Error ? err.message : 'unknown'}`;
    }

    // TLS expiry / issuer via openssl s_client
    const tls = tryExec(
      'bash',
      ['-c', `echo | openssl s_client -servername ${host} -connect ${host}:443 2>/dev/null | openssl x509 -noout -dates -issuer 2>/dev/null`],
      6000,
    );
    if (tls.status === 0 && tls.stdout) {
      const expMatch = tls.stdout.match(/notAfter=(.+)/);
      const issMatch = tls.stdout.match(/issuer=(.+)/);
      if (expMatch && expMatch[1]) {
        try {
          result.tls_expires = new Date(expMatch[1].trim()).toISOString();
          result.tls_valid = new Date(expMatch[1].trim()).getTime() > Date.now();
        } catch { /* leave nulls */ }
      }
      if (issMatch && issMatch[1]) {
        result.tls_issuer = issMatch[1].trim().replace(/^[^=]+=\s*/, '').slice(0, 80);
      }
    }

    // CORS preflight for api host only
    if (host === 'api.formulaeapps.com') {
      try {
        const res = await fetch(`https://${host}/openai/chat`, {
          method: 'OPTIONS',
          headers: {
            'Origin': 'https://app.formulaeapps.com',
            'Access-Control-Request-Method': 'POST',
          },
          signal: AbortSignal.timeout(5000),
        });
        const allow = res.headers.get('access-control-allow-origin');
        result.cors_allow_origin = allow;
        result.cors_preflight_ok = res.ok && allow === 'https://app.formulaeapps.com';
      } catch (err) {
        result.cors_preflight_ok = false;
        result.notes += ` (CORS preflight failed: ${err instanceof Error ? err.message : 'unknown'})`;
      }
    }
    out.push(result);
  }
  return out;
}

// ─── Main ──────────────────────────────────────────────────────────────────
async function main() {
  const compose_lint = lintComposes(LOCAL_MODE);
  const { collisions, total } = scanRouterCollisions();

  const cors_preflight_local = LOCAL_MODE ? await corsPreflightLocal() : null;
  const hostnames: HostnameResult[] = LOCAL_MODE ? [] : await checkHostnames();

  // Partition cross-project collisions into CRITICAL (involving formulae-*) and INFO (everything else).
  const crossProject = collisions.filter((c) => new Set(c.files.map(projectKey)).size > 1);
  const formulae_router_collisions: RouterCollision[] = [];
  const workspace_router_collisions: RouterCollision[] = [];
  for (const c of crossProject) {
    if (isFormulaeRouter(c.router_name)) {
      // formulae-* MUST be unique across non-formulaeapps projects. Same-project
      // (canonical vs zombie clone) is already filtered by projectKey.
      const involvesNonFormulae = c.files.some((f) => projectKey(f) !== 'formulaeapps');
      if (involvesNonFormulae) formulae_router_collisions.push(c);
      // else: only canonical + zombie clone — already same projectKey, won't reach here
    } else {
      workspace_router_collisions.push(c);
    }
  }

  // Determine exit status. Production hosts must have a reachable 2xx/3xx
  // endpoint, a valid certificate, and a working BFF preflight. A null result
  // is an unavailable/failed probe, never a passing production check.
  const composeFailed = compose_lint.some((c) => c.result === 'FAIL');
  const formulaeCollisionFailed = formulae_router_collisions.length > 0;
  const hostnameFailed = hostnames.some((h) =>
    h.http_status === null ||
    h.http_status < 200 ||
    h.http_status >= 400 ||
    h.tls_valid !== true ||
    (h.host === 'api.formulaeapps.com' && h.cors_preflight_ok !== true),
  );
  const corsFailed = cors_preflight_local !== null && cors_preflight_local.ok === false;

  const exit_status: 'PASS' | 'FAIL' =
    composeFailed || formulaeCollisionFailed || hostnameFailed || corsFailed ? 'FAIL' : 'PASS';

  const report: Report = {
    generated_at: new Date().toISOString(),
    mode: LOCAL_MODE ? 'local' : 'production',
    hostnames,
    compose_lint,
    formulae_router_collisions,
    workspace_router_collisions,
    traefik_routers_total: total,
    cors_preflight_local,
    exit_status,
  };

  process.stdout.write(JSON.stringify(report, null, 2) + '\n');
  process.exit(exit_status === 'PASS' ? 0 : 1);
}

main().catch((err) => {
  process.stderr.write(`infra-validate fatal: ${err instanceof Error ? err.message : String(err)}\n`);
  process.exit(2);
});
