#!/usr/bin/env bun

/**
 * Verifies the published Formulae image URLs after a controlled Hostinger
 * promotion. It bypasses intermediary caches and validates the real HTTP body,
 * MIME type, and decodable image format for every URL declared by the app.
 */
import { readFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import sharp from 'sharp';

const scriptDirectory = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.resolve(scriptDirectory, '..', '..');
const urlSources = [
  {
    app: 'Formulae Pro',
    file: path.join(repositoryRoot, 'pro', 'lib', 'constantes', 'urls_imagenes.dart'),
  },
  {
    app: 'Formulae Community',
    file: path.join(repositoryRoot, 'community', 'lib', 'constantes', 'urls_imagenes.dart'),
  },
];
const scopeArgument = process.argv.find((argument) => argument.startsWith('--scope='));
const scope = scopeArgument?.split('=')[1] ?? 'all';
if (!['all', 'canonical'].includes(scope)) {
  throw new Error('Use --scope=all or --scope=canonical.');
}

function urlsFromSource(source, app) {
  if (source.includes('/imagenes_ingles/')) {
    throw new Error(app + ' must not declare locale-specific image routes.');
  }
  const urls = [...source.matchAll(/https:\/\/formulaeapps\.com\/(imagenes\/[^']+)/g)].map(
    (match) => 'https://formulaeapps.com/' + match[1]
  );
  const unique = [...new Set(urls)];

  if (unique.length !== 176 || unique.length !== urls.length) {
    throw new Error(
      app +
        ' must declare 176 unique canonical image URLs, found ' +
        unique.length +
        ' unique / ' +
        urls.length +
        ' total.'
    );
  }

  return unique;
}

function assertSameUrls(reference, candidate, candidateApp) {
  const referenceSet = new Set(reference);
  const candidateSet = new Set(candidate);
  const onlyReference = reference.filter((url) => !candidateSet.has(url));
  const onlyCandidate = candidate.filter((url) => !referenceSet.has(url));
  if (onlyReference.length === 0 && onlyCandidate.length === 0) return;

  throw new Error(
    candidateApp +
      ' must resolve exactly the canonical Formulae Pro URL set. Missing: ' +
      (onlyReference.join(', ') || 'none') +
      '. Unexpected: ' +
      (onlyCandidate.join(', ') || 'none') +
      '.'
  );
}

async function inspectUrl(url, cacheToken) {
  const target = new URL(url);
  target.searchParams.set('asset_check', cacheToken);

  try {
    const response = await fetch(target, {
      headers: {
        'Cache-Control': 'no-cache',
        Pragma: 'no-cache',
      },
      signal: AbortSignal.timeout(20_000),
    });
    const contentType = response.headers.get('content-type') ?? '';
    if (response.status !== 200) {
      return `${url}: expected HTTP 200, got ${response.status} (${contentType || 'no content type'})`;
    }
    if (!/^image\/(png|jpeg)(?:;|$)/i.test(contentType)) {
      return `${url}: expected image/png or image/jpeg MIME, got ${contentType || 'missing'}`;
    }

    const body = Buffer.from(await response.arrayBuffer());
    if (body.length === 0) return `${url}: empty response body`;
    const metadata = await sharp(body, { animated: false }).metadata();
    const expectedFormat = target.pathname.endsWith('.jpg') ? 'jpeg' : 'png';
    if (metadata.format !== expectedFormat) {
      return `${url}: expected ${expectedFormat}, decoded ${metadata.format ?? 'unknown'}`;
    }
    return undefined;
  } catch (error) {
    return `${url}: ${error instanceof Error ? error.message : String(error)}`;
  }
}

async function mapWithConcurrency(items, limit, mapper) {
  const results = [];
  let index = 0;
  const workers = Array.from({ length: Math.min(limit, items.length) }, async () => {
    while (index < items.length) {
      const currentIndex = index++;
      results[currentIndex] = await mapper(items[currentIndex], currentIndex);
    }
  });
  await Promise.all(workers);
  return results;
}

const sourceUrls = await Promise.all(
  urlSources.map(async ({ app, file }) => ({
    app,
    urls: urlsFromSource(await readFile(file, 'utf8'), app),
  }))
);
const [{ urls }, ...secondarySources] = sourceUrls;
for (const { app, urls: secondaryUrls } of secondarySources) {
  assertSameUrls(urls, secondaryUrls, app);
}
const cacheToken = `${Date.now()}-${Math.random().toString(16).slice(2)}`;
const issues = (await mapWithConcurrency(urls, 6, (url) => inspectUrl(url, cacheToken))).filter(
  Boolean
);

if (issues.length > 0) {
  console.error(`Published Formulae image check failed (${issues.length}/${urls.length}):`);
  for (const issue of issues) console.error(`- ${issue}`);
  process.exitCode = 1;
} else {
  console.log(`Published Formulae image check passed (${urls.length} ${scope} assets).`);
}
