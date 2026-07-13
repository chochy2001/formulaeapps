#!/usr/bin/env bun
/**
 * route-coverage — Map BFF contract routes to FE consumers; flag orphans / dead-calls.
 *
 * Per specs/002-formulae-fe-be-sync/tasks.md T113 + data-model.md § E12 + Principle VI.
 *
 * Output: JSON to stdout matching data-model.md § E12 shape.
 * Exit:   0 if PASS (no orphans, no dead-calls), 1 if FAIL, 2 on setup error.
 *
 * Invoked via the top-level `scripts/route-coverage.sh` wrapper.
 */

import { parse as parseYaml } from 'yaml';
import { resolve, dirname, relative } from 'node:path';
import { fileURLToPath } from 'node:url';
import { readFileSync, readdirSync, statSync, existsSync } from 'node:fs';

const here = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(here, '..', '..'); // bff/scripts → bff → monorepo root
const CONTRACT_PATH = resolve(ROOT, 'contracts', 'bff.openapi.yaml');

// Routes considered infrastructure — no FE consumer required.
const INFRA_ROUTES = new Set<string>(['/health']);

// Routes that are deliberately uncovered today per spec § Edge Cases. The
// report still surfaces them (under intentional_orphan_routes) so they're
// visible, but they don't fail the exit code. Each entry MUST have a rationale
// in `audit/route-coverage-post.md` so the gate isn't quietly weakened.
const INTENTIONAL_ORPHAN_ROUTES = new Set<string>([
  '/iap/validate', // pending product decision: wire FE IAP server-validation OR remove from contract
  '/entitlement', // WP5 step 1 store+route; FE EntitlementService is step 3 (no consumer yet)
]);

function fatal(msg: string): never {
  process.stderr.write(`ERROR: ${msg}\n`);
  process.exit(2);
}

if (!existsSync(CONTRACT_PATH)) {
  fatal(`${CONTRACT_PATH} missing. Run 'cd bff && bun run build:openapi'.`);
}

// ── 1. Parse routes from contract ─────────────────────────────────────────
type RouteEntry = { method: string; path: string };
const contractDoc = parseYaml(readFileSync(CONTRACT_PATH, 'utf8')) as {
  info?: { version?: string };
  paths?: Record<string, Record<string, unknown>>;
};
const CONTRACT_VERSION = contractDoc.info?.version ?? 'unknown';

const contractRoutes: RouteEntry[] = [];
const contractPathSet = new Set<string>();
for (const [path, methodsObj] of Object.entries(contractDoc.paths ?? {})) {
  contractPathSet.add(path);
  for (const method of Object.keys(methodsObj)) {
    if (['get', 'post', 'put', 'patch', 'delete', 'options', 'head'].includes(method.toLowerCase())) {
      contractRoutes.push({ method: method.toUpperCase(), path });
    }
  }
}

// ── 2. Walk FE source trees (excluding lib/generated/) ─────────────────────
type FileLine = { file: string; line: number; content: string };

function* walkDartFiles(root: string): Generator<string> {
  if (!existsSync(root)) return;
  const stack: string[] = [root];
  while (stack.length) {
    const dir = stack.pop()!;
    const segs = dir.split('/');
    // Skip lib/generated subtrees — they mirror the contract, not consume it.
    if (segs.includes('generated')) continue;
    for (const entry of readdirSync(dir)) {
      const full = resolve(dir, entry);
      const st = statSync(full);
      if (st.isDirectory()) stack.push(full);
      else if (st.isFile() && entry.endsWith('.dart')) yield full;
    }
  }
}

const feFiles: string[] = [];
for (const f of walkDartFiles(resolve(ROOT, 'pro', 'lib'))) feFiles.push(f);
for (const f of walkDartFiles(resolve(ROOT, 'community', 'lib'))) feFiles.push(f);

// ── 3. Index FE code by line ───────────────────────
// Two scan passes:
//   (a) Substring match per contract route — used to detect COVERED.
//       Matches the path appearing anywhere in non-generated FE code.
//   (b) BFF-URL match — for DEAD-CALL detection, only scan strings containing
//       `api.formulaeapps.com/<path>`. This avoids false-positives from
//       Flutter Navigator route names like `/chatGPT` defined in app-routes
//       constants files.
type FeFileContent = { file: string; lines: string[] };
const feContents: FeFileContent[] = feFiles.map((file) => ({
  file: relative(ROOT, file),
  lines: readFileSync(file, 'utf8').split('\n'),
}));

// Build the BFF-URL match index for dead-call detection
const BFF_DOMAIN_RE = /https?:\/\/api\.formulaeapps\.com(\/[a-zA-Z0-9_/-]+)/g;
// Also catch explicit HTTP method calls with literal paths:
//   dio.post('/path', ...) | http.get(Uri.parse('/path')) | client.post('/path')
const HTTP_METHOD_RE = /\b(?:dio|http|client|_client|api)\s*\.\s*(?:get|post|put|patch|delete)\s*\(\s*['"`](\/[a-z][a-z0-9_/-]*)/gi;

type FeMatch = { file: string; line: number; path: string };
const bffUrlMatches: FeMatch[] = [];

for (const fc of feContents) {
  fc.lines.forEach((lineText, idx) => {
    BFF_DOMAIN_RE.lastIndex = 0;
    let m: RegExpExecArray | null;
    while ((m = BFF_DOMAIN_RE.exec(lineText)) !== null) {
      if (m[1]) bffUrlMatches.push({ file: fc.file, line: idx + 1, path: m[1] });
    }
    HTTP_METHOD_RE.lastIndex = 0;
    while ((m = HTTP_METHOD_RE.exec(lineText)) !== null) {
      if (m[1]) bffUrlMatches.push({ file: fc.file, line: idx + 1, path: m[1] });
    }
  });
}

// ── 4. Build the per-route coverage list + orphans ─────────────────────────
type RouteReport = { method: string; path: string; status: 'COVERED'; consumers: Array<{ file: string; line: number }> };
type OrphanReport = { method: string; path: string; status: 'ORPHAN' };
type IntentionalOrphanReport = { method: string; path: string; status: 'INTENTIONAL_ORPHAN' };
type InfraReport = { method: string; path: string; status: 'INFRASTRUCTURE' };
type DeadCallReport = { file: string; line: number; called_path: string; reason: string };

const routes: RouteReport[] = [];
const orphan_routes: OrphanReport[] = [];
const intentional_orphan_routes: IntentionalOrphanReport[] = [];
const infrastructure_routes: InfraReport[] = [];

for (const r of contractRoutes) {
  if (INFRA_ROUTES.has(r.path)) {
    infrastructure_routes.push({ method: r.method, path: r.path, status: 'INFRASTRUCTURE' });
    continue;
  }

  // COVERED: any non-generated FE file contains the path as a substring (catches
  // both literal '/openai/chat' usage and embedded `api.formulaeapps.com/openai/chat`
  // URLs in defaultValue strings).
  const consumers: Array<{ file: string; line: number }> = [];
  for (const fc of feContents) {
    fc.lines.forEach((lineText, idx) => {
      if (lineText.includes(r.path)) {
        consumers.push({ file: fc.file, line: idx + 1 });
      }
    });
  }

  if (consumers.length === 0) {
    if (INTENTIONAL_ORPHAN_ROUTES.has(r.path)) {
      intentional_orphan_routes.push({ method: r.method, path: r.path, status: 'INTENTIONAL_ORPHAN' });
    } else {
      orphan_routes.push({ method: r.method, path: r.path, status: 'ORPHAN' });
    }
  } else {
    routes.push({ method: r.method, path: r.path, consumers, status: 'COVERED' });
  }
}

// ── 5. Detect dead-calls: BFF-URL or HTTP-method paths NOT in contract ─────
// Only flag dead-calls where the FE code clearly references an API URL (via
// api.formulaeapps.com host OR HTTP method invocation with literal path).
// This avoids false-positives from Flutter Navigator route names.
const dead_calls: DeadCallReport[] = [];
const seenDead = new Set<string>();
for (const m of bffUrlMatches) {
  if (contractPathSet.has(m.path)) continue;
  const key = `${m.file}:${m.line}:${m.path}`;
  if (seenDead.has(key)) continue;
  seenDead.add(key);
  dead_calls.push({
    file: m.file,
    line: m.line,
    called_path: m.path,
    reason: `path not declared in contract ${CONTRACT_VERSION}`,
  });
}

// ── 6. Emit report + exit ───────────────────────────────────────────────────
// Only "real" orphans (NOT in INTENTIONAL_ORPHAN_ROUTES) and dead-calls fail the gate.
// Intentional orphans are surfaced in the report but never fail CI; they exist as
// documented exceptions per audit/route-coverage-post.md.
const exit_status: 'PASS' | 'FAIL' = orphan_routes.length === 0 && dead_calls.length === 0 ? 'PASS' : 'FAIL';

const report = {
  generated_at: new Date().toISOString(),
  contract_version: CONTRACT_VERSION,
  infrastructure_routes,
  routes,
  intentional_orphan_routes,
  orphan_routes,
  dead_calls,
  exit_status,
};

process.stdout.write(JSON.stringify(report, null, 2) + '\n');
process.exit(exit_status === 'PASS' ? 0 : 1);
