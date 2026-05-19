#!/usr/bin/env bun
/**
 * probe-allowlist — Verify OPENROUTER_MODEL_ALLOWLIST entries still exist in
 * OpenRouter's live catalog (https://openrouter.ai/api/v1/models).
 *
 * Motivation: OpenRouter silently removes deprecated models from their catalog.
 * We hit this on 2026-05-19 when `google/gemini-2.0-flash-exp` returned 404 on
 * live POSTs after being on our allowlist for weeks. This probe is the
 * automated guardrail so we never catch drift by accident again.
 *
 * Source of truth for the allowlist (in order of precedence):
 *   1. process.env.OPENROUTER_MODEL_ALLOWLIST — comma-separated, if set.
 *   2. The default literal in ../src/lib/env.ts, parsed out of the source text.
 *
 * We deliberately do NOT `import { env }` from ../src/lib/env.ts because that
 * triggers Zod env validation requiring JWT_SHARED_SECRET / OPENROUTER_API_KEY,
 * which would force the probe to ship dummy secrets (see export-openapi.ts for
 * how this is normally worked around). Parsing the literal keeps the probe
 * decoupled and side-effect free, while still tracking env.ts changes.
 *
 * Output: markdown table to stdout + summary footer.
 * Exit:   0 if every allowlist entry is in the live catalog,
 *         1 if any entry is MISSING,
 *         2 on network / parse error (error message to stderr).
 *
 * Run locally: cd bff && bun run scripts/probe-allowlist.ts
 * Run negative-path sanity check:
 *   OPENROUTER_MODEL_ALLOWLIST=fake/nonexistent bun run scripts/probe-allowlist.ts
 */

import { resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { readFileSync, existsSync } from 'node:fs';

const here = dirname(fileURLToPath(import.meta.url));
const ENV_TS_PATH = resolve(here, '..', 'src', 'lib', 'env.ts');
const MODELS_URL = 'https://openrouter.ai/api/v1/models';
const FETCH_TIMEOUT_MS = 10_000;

function fatal(msg: string): never {
  process.stderr.write(`ERROR: ${msg}\n`);
  process.exit(2);
}

// ── 1. Resolve the allowlist ───────────────────────────────────────────────
function parseAllowlistFromEnvTs(): string[] {
  if (!existsSync(ENV_TS_PATH)) {
    fatal(`Cannot read env.ts at ${ENV_TS_PATH} — script must run from bff/.`);
  }
  const src = readFileSync(ENV_TS_PATH, 'utf8');
  // Match the .default('...,...') string passed to OPENROUTER_MODEL_ALLOWLIST.
  // The literal currently spans one quoted string (single quotes) inside a
  // `.default(...)` whose opening paren is followed by a multiline comment
  // block. We tolerate any non-quote chars between `.default(` and the opening
  // quote so reformats (e.g., removing the cost-rank comment) don't break us.
  // We accept either quote style for the literal.
  const re = /OPENROUTER_MODEL_ALLOWLIST[\s\S]*?\.default\([^'"`]*?(['"`])([^'"`]+)\1/;
  const m = src.match(re);
  if (!m || !m[2]) {
    fatal(`Could not find OPENROUTER_MODEL_ALLOWLIST default literal in env.ts. ` +
          `Did the schema move? Update probe-allowlist.ts.`);
  }
  return m[2]
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean);
}

function resolveAllowlist(): { source: string; models: string[] } {
  const fromEnv = process.env['OPENROUTER_MODEL_ALLOWLIST'];
  if (fromEnv !== undefined && fromEnv.trim().length > 0) {
    const models = fromEnv.split(',').map((s) => s.trim()).filter(Boolean);
    return { source: 'process.env.OPENROUTER_MODEL_ALLOWLIST', models };
  }
  return { source: 'src/lib/env.ts default literal', models: parseAllowlistFromEnvTs() };
}

const { source, models: allowlist } = resolveAllowlist();
if (allowlist.length === 0) {
  fatal('Resolved allowlist is empty.');
}

// ── 2. Fetch live catalog ──────────────────────────────────────────────────
type CatalogEntry = { id: string };
type CatalogPayload = { data?: CatalogEntry[] };

let payload: CatalogPayload;
try {
  const res = await fetch(MODELS_URL, {
    method: 'GET',
    headers: { 'Accept': 'application/json' },
    signal: AbortSignal.timeout(FETCH_TIMEOUT_MS),
  });
  if (!res.ok) {
    fatal(`GET ${MODELS_URL} → HTTP ${res.status} ${res.statusText}`);
  }
  payload = (await res.json()) as CatalogPayload;
} catch (err) {
  fatal(`Network/parse error fetching ${MODELS_URL}: ${err instanceof Error ? err.message : String(err)}`);
}

if (!Array.isArray(payload.data)) {
  fatal(`Unexpected payload shape from ${MODELS_URL}: data[] missing.`);
}

const catalog = payload.data;
const catalogIndex = new Map<string, number>();
catalog.forEach((entry, idx) => {
  if (typeof entry?.id === 'string') catalogIndex.set(entry.id, idx);
});

// ── 3. Compare + render markdown table ─────────────────────────────────────
type Row = { model_id: string; status: 'OK' | 'MISSING'; catalog_pos: string };
const rows: Row[] = allowlist.map((id) => {
  const pos = catalogIndex.get(id);
  return pos === undefined
    ? { model_id: id, status: 'MISSING', catalog_pos: '-' }
    : { model_id: id, status: 'OK', catalog_pos: String(pos) };
});

const okCount = rows.filter((r) => r.status === 'OK').length;
const missingCount = rows.length - okCount;

const header = '| model_id | status | catalog_pos |';
const sep =    '| --- | --- | --- |';
const body = rows.map((r) => `| ${r.model_id} | ${r.status} | ${r.catalog_pos} |`).join('\n');
const footer = `\nFound ${okCount}/${rows.length} allowlist models in OpenRouter catalog of ${catalog.length} total.`;
const meta = `\n(allowlist source: ${source})`;

process.stdout.write(`${header}\n${sep}\n${body}${footer}${meta}\n`);

if (missingCount > 0) {
  process.stderr.write(
    `\n${missingCount} model(s) MISSING from OpenRouter catalog. ` +
    `Update OPENROUTER_MODEL_ALLOWLIST in bff/src/lib/env.ts.\n`,
  );
  process.exit(1);
}

process.exit(0);
