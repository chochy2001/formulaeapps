#!/usr/bin/env bun
/**
 * Static guard for the BFF SQLite persistence topology.
 *
 * It intentionally does not require a Docker daemon: CI/local review can
 * catch a missing mount, an unstable volume name, or a non-writable runtime
 * directory before an operator deploys a container.
 */

import { readFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parse } from 'yaml';

const here = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(here, '..', '..');

type ComposeConfig = {
  services?: {
    bff?: {
      environment?: Record<string, unknown>;
      volumes?: unknown[];
    };
  };
  volumes?: Record<string, { name?: unknown }>;
};

function addIfMissing(errors: string[], condition: boolean, message: string): void {
  if (!condition) errors.push(message);
}

export function validatePersistenceConfig(root = ROOT): string[] {
  const errors: string[] = [];
  const dockerfile = readFileSync(resolve(root, 'bff', 'Dockerfile'), 'utf8');
  const compose = parse(
    readFileSync(resolve(root, 'docker-compose.yml'), 'utf8'),
  ) as ComposeConfig;
  const envExample = readFileSync(resolve(root, 'bff', '.env.example'), 'utf8');
  const gitignore = readFileSync(resolve(root, '.gitignore'), 'utf8');

  const userIndex = dockerfile.indexOf('USER bun');
  const mkdirIndex = dockerfile.indexOf('mkdir -p /app/.data');
  const chownIndex = dockerfile.indexOf('chown 1000:1000 /app/.data');
  const chmodIndex = dockerfile.indexOf('chmod 0700 /app/.data');
  addIfMissing(
    errors,
    userIndex >= 0 && mkdirIndex >= 0 && chownIndex >= 0 && chmodIndex >= 0 &&
      mkdirIndex < userIndex && chownIndex < userIndex && chmodIndex < userIndex,
    'bff/Dockerfile must create and chown /app/.data before USER bun',
  );
  addIfMissing(
    errors,
    dockerfile.includes('ENV ACCOUNTS_DB_PATH=/app/.data/accounts.sqlite'),
    'bff/Dockerfile must default ACCOUNTS_DB_PATH to /app/.data/accounts.sqlite',
  );
  addIfMissing(
    errors,
    dockerfile.includes('ENV ENTITLEMENTS_DB_PATH=/app/.data/mobile_entitlements.sqlite'),
    'bff/Dockerfile must default ENTITLEMENTS_DB_PATH to /app/.data/mobile_entitlements.sqlite',
  );

  const bff = compose.services?.bff;
  const bffVolumes = bff?.volumes ?? [];
  addIfMissing(
    errors,
    bffVolumes.includes('bff_data:/app/.data'),
    'docker-compose.yml bff service must mount bff_data at /app/.data',
  );
  addIfMissing(
    errors,
    bff?.environment?.['ACCOUNTS_DB_PATH'] === '/app/.data/accounts.sqlite',
    'docker-compose.yml bff must set ACCOUNTS_DB_PATH to its persistent mount',
  );
  addIfMissing(
    errors,
    bff?.environment?.['ENTITLEMENTS_DB_PATH'] === '/app/.data/mobile_entitlements.sqlite',
    'docker-compose.yml bff must set ENTITLEMENTS_DB_PATH to its persistent mount',
  );
  addIfMissing(
    errors,
    compose.volumes?.['bff_data']?.name === 'formulaeapps_bff_data',
    'docker-compose.yml must use the stable formulaeapps_bff_data volume name',
  );

  addIfMissing(
    errors,
    envExample.includes('ACCOUNTS_DB_PATH=.data/accounts.sqlite'),
    'bff/.env.example must document the local ACCOUNTS_DB_PATH default',
  );
  addIfMissing(
    errors,
    envExample.includes('ENTITLEMENTS_DB_PATH=.data/mobile_entitlements.sqlite'),
    'bff/.env.example must document the local ENTITLEMENTS_DB_PATH default',
  );
  addIfMissing(
    errors,
    gitignore.includes('bff/.data/'),
    '.gitignore must exclude local BFF SQLite state',
  );

  return errors;
}

if (import.meta.main) {
  const errors = validatePersistenceConfig();
  if (errors.length > 0) {
    for (const error of errors) console.error(`ERROR: ${error}`);
    process.exit(1);
  }
  console.log('BFF persistence configuration OK');
}
