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

// Calls made through the generated Dart client do not repeat the HTTP path in
// application code. Keep their contract-level signal explicit so coverage is
// based on the real invocation rather than a documentation comment mentioning
// the endpoint. Add a signal here whenever a generated client operation is
// introduced without a literal path at its call site.
const GENERATED_CLIENT_CALLS: Record<string, RegExp> = {
  '/auth/register': /\bgetAuthApi\s*\(\s*\)\s*\.\s*authRegisterPost\s*\(/,
  '/auth/login': /\bgetAuthApi\s*\(\s*\)\s*\.\s*authLoginPost\s*\(/,
  '/auth/oauth': /\bgetAuthApi\s*\(\s*\)\s*\.\s*authOauthPost\s*\(/,
  '/iap/validate': /\bgetIapApi\s*\(\s*\)\s*\.\s*iapValidatePost\s*\(/,
  '/entitlement': /\bgetEntitlementApi\s*\(\s*\)\s*\.\s*entitlementGet\s*\(/,
};

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
type FeFileContent = { file: string; codeLines: string[] };

// The route contract is about executable client code. A line comment that
// merely documents `/iap/validate` must not satisfy it. This intentionally
// keeps strings intact (literal BFF URLs are valid consumers) while discarding
// line comments and block comments before the scanner evaluates a line.
function withoutDartComments(source: string): string {
  let result = '';
  let quote: "'" | '"' | null = null;
  let escaped = false;
  let inBlockComment = false;

  for (let index = 0; index < source.length; index += 1) {
    const current = source[index];
    const next = source[index + 1];

    if (inBlockComment) {
      if (current === '*' && next === '/') {
        inBlockComment = false;
        index += 1;
      } else if (current === '\n') {
        // Preserve line numbers in the generated coverage report.
        result += '\n';
      }
      continue;
    }

    if (quote !== null) {
      result += current;
      if (escaped) {
        escaped = false;
      } else if (current === '\\') {
        escaped = true;
      } else if (current === quote) {
        quote = null;
      }
      continue;
    }

    if (current === '/' && next === '*') {
      inBlockComment = true;
      index += 1;
      continue;
    }

    if (current === '/' && next === '/') {
      while (index < source.length && source[index] !== '\n') index += 1;
      if (index < source.length) result += '\n';
      continue;
    }

    result += current;
    if (current === "'" || current === '"') quote = current;
  }

  return result;
}

const feContents: FeFileContent[] = feFiles.map((file) => {
  const source = readFileSync(file, 'utf8');
  return {
    file: relative(ROOT, file),
    codeLines: withoutDartComments(source).split('\n'),
  };
});

// Build the BFF-URL match index for dead-call detection
const BFF_DOMAIN_RE = /https?:\/\/api\.formulaeapps\.com(\/[a-zA-Z0-9_/-]+)/g;
// Also catch explicit HTTP method calls with literal paths:
//   dio.post('/path', ...) | http.get(Uri.parse('/path')) | client.post('/path')
const HTTP_METHOD_RE = /\b(?:dio|http|client|_client|api)\s*\.\s*(?:get|post|put|patch|delete)\s*\(\s*['"`](\/[a-z][a-z0-9_/-]*)/gi;

type FeMatch = { file: string; line: number; path: string };
const bffUrlMatches: FeMatch[] = [];

for (const fc of feContents) {
  fc.codeLines.forEach((lineText, idx) => {
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
type InfraReport = { method: string; path: string; status: 'INFRASTRUCTURE' };
type DeadCallReport = { file: string; line: number; called_path: string; reason: string };

const routes: RouteReport[] = [];
const orphan_routes: OrphanReport[] = [];
const infrastructure_routes: InfraReport[] = [];

for (const r of contractRoutes) {
  if (INFRA_ROUTES.has(r.path)) {
    infrastructure_routes.push({ method: r.method, path: r.path, status: 'INFRASTRUCTURE' });
    continue;
  }

  // COVERED: executable non-generated FE code contains the path (literal or
  // embedded BFF URL), or invokes the matching generated-client operation.
  const consumers: Array<{ file: string; line: number }> = [];
  const generatedCall = GENERATED_CLIENT_CALLS[r.path];
  for (const fc of feContents) {
    fc.codeLines.forEach((lineText, idx) => {
      if (lineText.includes(r.path) || generatedCall?.test(lineText)) {
        consumers.push({ file: fc.file, line: idx + 1 });
      }
    });
  }

  if (consumers.length === 0) {
    orphan_routes.push({ method: r.method, path: r.path, status: 'ORPHAN' });
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
const exit_status: 'PASS' | 'FAIL' = orphan_routes.length === 0 && dead_calls.length === 0 ? 'PASS' : 'FAIL';

const report = {
  generated_at: new Date().toISOString(),
  contract_version: CONTRACT_VERSION,
  infrastructure_routes,
  routes,
  orphan_routes,
  dead_calls,
  exit_status,
};

process.stdout.write(JSON.stringify(report, null, 2) + '\n');
process.exit(exit_status === 'PASS' ? 0 : 1);
