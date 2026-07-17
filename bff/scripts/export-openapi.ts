#!/usr/bin/env bun
/**
 * Export the OpenAPI 3.1 document from the BFF Zod schemas to YAML.
 *
 * Output: ../contracts/bff.openapi.yaml (canonical monorepo root contracts/)
 *
 * Spec §FR-007 + Plan § OpenAPI export. Run via: `bun run build:openapi`.
 *
 * NOTE: importing src/index.ts triggers env validation. Set dummy export-time
 * env values BEFORE the import so the script can run without real secrets.
 */

// Dummy env for export-only — never used at runtime, only at import-time of env.ts.
process.env['BFF_ENV'] ??= 'development';
process.env['JWT_SHARED_SECRET'] ??= 'export-time-dummy-secret';
process.env['OPENROUTER_API_KEY'] ??= 'sk-or-v1-export-time-dummy';

import { stringify as toYaml } from 'yaml';
import { resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const outputPath = resolve(here, '..', '..', 'contracts', 'bff.openapi.yaml');

// Dynamic import so the dummy env above is set BEFORE env.ts validates.
const { app } = await import('../src/index');
const { CONTRACT_VERSION } = await import('../src/lib/openapi');

const doc = app.getOpenAPI31Document({
  openapi: '3.1.0',
  info: {
    title: 'FormulaeApps BFF',
    version: CONTRACT_VERSION,
    description:
      'Backend-for-Frontend for FormulaeApps. Generated from bff/src/schemas/*.ts ' +
      'by @hono/zod-openapi. DO NOT EDIT — drift fails scripts/verify-parity.sh in CI.',
  },
  servers: [
    { url: 'https://api.formulaeapps.com', description: 'Production (VPS Contabo)' },
    { url: 'http://localhost:3000', description: 'Local dev' },
  ],
});

const yaml = toYaml(doc, { lineWidth: 0, sortMapEntries: false });
await Bun.write(outputPath, yaml);

console.log(`✓ Wrote OpenAPI contract to ${outputPath} (${yaml.length} bytes)`);
