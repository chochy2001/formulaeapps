#!/usr/bin/env bun

/**
 * Verifies the Formulae image delivery contract directly from the Dart URL
 * source of truth. It is deliberately independent of the prompt catalogue so
 * renamed or newly referenced image URLs cannot silently bypass validation.
 */
import { promises as fs } from 'node:fs';
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
const publicDirectory = path.join(repositoryRoot, 'landing', 'public');
const expectedNavy = [39, 40, 61, 255];

const scopeArgument = process.argv.find((argument) => argument.startsWith('--scope='));
const scope = scopeArgument?.split('=')[1] ?? 'all';
if (!['all', 'canonical'].includes(scope)) {
  throw new Error('Use --scope=all or --scope=canonical.');
}

function expectedAssets(source, app) {
  if (source.includes('/imagenes_ingles/')) {
    throw new Error(app + ' must not declare locale-specific image routes.');
  }
  const urls = [...source.matchAll(/https:\/\/formulaeapps\.com\/(imagenes\/[^']+)/g)].map(
    (match) => match[1]
  );

  const unique = [...new Set(urls)];
  if (urls.length !== unique.length || unique.length !== 176) {
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

function assertSameAssets(reference, candidate, candidateApp) {
  const referenceSet = new Set(reference);
  const candidateSet = new Set(candidate);
  const onlyReference = reference.filter((asset) => !candidateSet.has(asset));
  const onlyCandidate = candidate.filter((asset) => !referenceSet.has(asset));
  if (onlyReference.length === 0 && onlyCandidate.length === 0) return;

  throw new Error(
    candidateApp +
      ' must resolve exactly the canonical Formulae Pro asset set. Missing: ' +
      (onlyReference.join(', ') || 'none') +
      '. Unexpected: ' +
      (onlyCandidate.join(', ') || 'none') +
      '.'
  );
}

function pixelAt(data, info, x, y) {
  const offset = (y * info.width + x) * info.channels;
  return [
    data[offset],
    data[offset + 1],
    data[offset + 2],
    info.channels === 4 ? data[offset + 3] : 255,
  ];
}

function isNavy(pixel, tolerance) {
  return pixel.every((channel, index) => Math.abs(channel - expectedNavy[index]) <= tolerance);
}

async function imageFilesIn(directory) {
  const entries = await fs.readdir(directory, { withFileTypes: true });
  const files = [];

  for (const entry of entries) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      files.push(...(await imageFilesIn(entryPath)));
      continue;
    }
    if (entry.isFile() && ['.png', '.jpg'].includes(path.extname(entry.name).toLowerCase())) {
      files.push(entryPath);
    }
  }

  return files;
}

async function imageIssue(relativePath) {
  const filePath = path.join(publicDirectory, relativePath);
  try {
    await fs.access(filePath);
  } catch {
    return `${relativePath}: missing`;
  }

  const extension = path.extname(relativePath).toLowerCase();
  const metadata = await sharp(filePath, { animated: false }).metadata();
  const expectedFormat = extension === '.jpg' ? 'jpeg' : 'png';
  if (metadata.format !== expectedFormat) {
    return `${relativePath}: expected ${expectedFormat}, got ${metadata.format ?? 'unknown'}`;
  }

  if (!metadata.width || !metadata.height || metadata.width < 512 || metadata.height < 300) {
    return `${relativePath}: dimensions must be at least 512x300, got ${metadata.width ?? 0}x${metadata.height ?? 0}`;
  }

  const { data, info } = await sharp(filePath)
    .ensureAlpha()
    .raw()
    .toBuffer({ resolveWithObject: true });
  const corners = [
    pixelAt(data, info, 0, 0),
    pixelAt(data, info, info.width - 1, 0),
    pixelAt(data, info, 0, info.height - 1),
    pixelAt(data, info, info.width - 1, info.height - 1),
  ];
  const tolerance = extension === '.jpg' ? 14 : 0;
  if (!corners.every((corner) => isNavy(corner, tolerance))) {
    return `${relativePath}: all corners must be opaque navy #27283D, got ${corners
      .map((corner) => `rgba(${corner.join(',')})`)
      .join(', ')}`;
  }

  return undefined;
}

const sourceAssets = await Promise.all(
  urlSources.map(async ({ app, file }) => ({
    app,
    assets: expectedAssets(await fs.readFile(file, 'utf8'), app),
  }))
);
const [{ assets }, ...secondarySources] = sourceAssets;
for (const { app, assets: secondaryAssets } of secondarySources) {
  assertSameAssets(assets, secondaryAssets, app);
}
const expectedSet = new Set(assets);
const directories = ['imagenes'];
const candidateFiles = (
  await Promise.all(
    directories.map((directory) => imageFilesIn(path.join(publicDirectory, directory)))
  )
).flat();
const unexpected = candidateFiles
  .map((filePath) => path.relative(publicDirectory, filePath).split(path.sep).join('/'))
  .filter((relativePath) => !expectedSet.has(relativePath))
  .map((relativePath) => `${relativePath}: not referenced by the canonical app registries`);
const issues = [...(await Promise.all(assets.map(imageIssue))).filter(Boolean), ...unexpected];

if (issues.length > 0) {
  console.error(`Formulae image validation failed (${issues.length}/${assets.length}):`);
  for (const issue of issues) console.error(`- ${issue}`);
  process.exitCode = 1;
} else {
  console.log(`Formulae image validation passed (${assets.length} ${scope} assets).`);
}
