#!/usr/bin/env bun

/**
 * Rebuilds Formulae's canonical image delivery directory from matching
 * historic Community assets without modifying Community itself.
 *
 * Each output is normalized to a 1024x768 opaque #27283D canvas so it blends
 * into Formulae Pro's dark background and never exposes a transparency grid.
 * Three UI icons and two RC variants are reconstructed locally because they do
 * not exist in Community's asset directory.
 */
import { promises as fs } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import sharp from 'sharp';

const scriptDirectory = path.dirname(fileURLToPath(import.meta.url));
const repositoryRoot = path.resolve(scriptDirectory, '..', '..');
const urlsSource = path.join(repositoryRoot, 'pro', 'lib', 'constantes', 'urls_imagenes.dart');
const communitySourceDirectory = path.join(repositoryRoot, 'community', 'assets', 'images');
const destinationDirectory = path.join(repositoryRoot, 'landing', 'public', 'imagenes');

const navy = { r: 39, g: 40, b: 61, alpha: 1 };
const colors = {
  navy: '#27283D',
  ink: '#E8E8F0',
  gold: '#F3A73D',
  red: '#FF6B6B',
  blue: '#6BA9FF',
};

const width = 1024;
const height = 768;
const contentWidth = 900;
const contentHeight = 640;

function svgDocument(body) {
  return Buffer.from(`<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${width} ${height}">
  <defs>
    <marker id="arrow-red" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M 0 0 L 10 5 L 0 10 z" fill="${colors.red}"/>
    </marker>
    <style>
      .line { fill: none; stroke: ${colors.ink}; stroke-width: 6; stroke-linecap: round; stroke-linejoin: round; }
      .thin { fill: none; stroke: ${colors.ink}; stroke-width: 3; stroke-linecap: round; stroke-linejoin: round; }
      .label { fill: ${colors.ink}; font-family: Arial, Helvetica, sans-serif; font-size: 32px; font-weight: 500; }
      .formula { fill: ${colors.ink}; font-family: Arial, Helvetica, sans-serif; font-size: 34px; font-weight: 600; }
      .small { fill: ${colors.ink}; font-family: Arial, Helvetica, sans-serif; font-size: 25px; }
    </style>
  </defs>
  <rect width="100%" height="100%" fill="${colors.navy}"/>
  ${body}
</svg>`);
}

function plusIcon() {
  return svgDocument(`
    <circle cx="512" cy="384" r="210" fill="none" stroke="${colors.gold}" stroke-width="20"/>
    <path d="M512 258 V510 M386 384 H638" stroke="${colors.ink}" stroke-width="34" stroke-linecap="round"/>
  `);
}

function favoriteIcon() {
  return svgDocument(`
    <path d="M512 166 L578 314 L740 330 L618 436 L654 596 L512 516 L370 596 L406 436 L284 330 L446 314 Z"
      fill="${colors.gold}" stroke="${colors.ink}" stroke-width="12" stroke-linejoin="round"/>
  `);
}

function cartIcon() {
  return svgDocument(`
    <path d="M240 222 H310 L370 518 H698 L758 312 H340" class="line"/>
    <path d="M390 398 H720" class="thin"/>
    <circle cx="436" cy="596" r="30" fill="${colors.gold}" stroke="${colors.ink}" stroke-width="8"/>
    <circle cx="650" cy="596" r="30" fill="${colors.gold}" stroke="${colors.ink}" stroke-width="8"/>
  `);
}

function resistorPath(x, y, length = 170) {
  const step = length / 8;
  const points = Array.from({ length: 9 }, (_, index) => {
    const offsetY = index === 0 || index === 8 ? 0 : index % 2 === 0 ? -24 : 24;
    return `${x + index * step},${y + offsetY}`;
  });
  return `<polyline points="${points.join(' ')}" class="line"/>`;
}

function chargeCircuitSvg() {
  return svgDocument(`
    <path d="M218 214 H410 M580 214 H740 V540 H218 V214" class="line"/>
    ${resistorPath(410, 214)}
    <path d="M314 164 V264 M350 182 V246" class="line"/>
    <text x="282" y="144" class="label">V</text>
    <text x="380" y="178" class="label">R</text>
    <path d="M740 328 H660 M740 398 H660" class="line"/>
    <path d="M700 328 V398" class="thin" stroke-dasharray="8 10"/>
    <text x="766" y="370" class="label">C</text>
    <text x="670" y="304" class="label" style="fill:${colors.red}">+q</text>
    <text x="670" y="438" class="label" style="fill:${colors.blue}">-q</text>
    <path d="M326 176 H650" stroke="${colors.red}" stroke-width="7" fill="none" marker-end="url(#arrow-red)"/>
    <text x="500" y="152" class="label" style="fill:${colors.red}">i</text>
    <text x="512" y="650" class="formula" text-anchor="middle">V = iR + q/C</text>
  `);
}

function dischargeCircuitSvg() {
  return svgDocument(`
    <path d="M252 214 H410 M580 214 H748 V540 H252 V214" class="line"/>
    ${resistorPath(410, 214)}
    <text x="470" y="178" class="label">R</text>
    <path d="M748 328 H668 M748 398 H668" class="line"/>
    <path d="M708 328 V398" class="thin" stroke-dasharray="8 10"/>
    <text x="774" y="370" class="label">C</text>
    <text x="678" y="304" class="label" style="fill:${colors.red}">+q</text>
    <text x="678" y="438" class="label" style="fill:${colors.blue}">-q</text>
    <path d="M666 538 H348" stroke="${colors.red}" stroke-width="7" fill="none" marker-end="url(#arrow-red)"/>
    <text x="512" y="520" class="label" style="fill:${colors.red}">i</text>
    <text x="512" y="650" class="formula" text-anchor="middle">Ri + q/C = 0</text>
    <text x="512" y="704" class="formula" text-anchor="middle">q(t) = Q<tspan baseline-shift="sub" font-size="24">0</tspan> e<tspan baseline-shift="super" font-size="24">-t/RC</tspan>, τ = RC</text>
  `);
}

const generatedAssets = new Map([
  ['agregar_tarea.png', plusIcon],
  ['formulas_favoritas.png', favoriteIcon],
  ['carrito_comprar.png', cartIcon],
  ['electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo_1.png', chargeCircuitSvg],
  ['electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo_2.png', dischargeCircuitSvg],
]);

function expectedCanonicalPaths(source) {
  const matches = [...source.matchAll(/https:\/\/formulaeapps\.com\/imagenes\/([^']+)/g)].map(
    (match) => match[1]
  );
  const unique = [...new Set(matches)];

  if (unique.length !== 176 || matches.length !== unique.length) {
    throw new Error(
      `Expected 176 unique canonical asset URLs, found ${unique.length} unique / ${matches.length} total.`
    );
  }

  if (unique.some((relativePath) => relativePath.includes('..'))) {
    throw new Error('Asset URL list includes an unsafe relative path.');
  }

  return unique;
}

async function exists(filePath) {
  try {
    await fs.access(filePath);
    return true;
  } catch {
    return false;
  }
}

async function writeSourceAsset(sourcePath, destinationPath, extension) {
  const normalized = sharp(sourcePath)
    .resize({
      width: contentWidth,
      height: contentHeight,
      fit: 'contain',
      background: navy,
      withoutEnlargement: false,
    })
    .flatten({ background: navy })
    .png();

  const content = await normalized.toBuffer();
  const canvas = sharp({
    create: { width, height, channels: 4, background: navy },
  }).composite([{ input: content, gravity: 'center' }]);

  if (extension === '.jpg') {
    await canvas.jpeg({ quality: 94, mozjpeg: true }).toFile(destinationPath);
    return;
  }

  await canvas.png({ compressionLevel: 9, palette: false }).toFile(destinationPath);
}

async function writeGeneratedAsset(svg, destinationPath) {
  await sharp(svg).png({ compressionLevel: 9, palette: false }).toFile(destinationPath);
}

const force = process.argv.includes('--force');
const source = await fs.readFile(urlsSource, 'utf8');
const relativePaths = expectedCanonicalPaths(source);

const report = {
  copiedFromCommunity: [],
  reconstructed: [],
  skipped: [],
  missing: [],
};

for (const relativePath of relativePaths) {
  const destinationPath = path.join(destinationDirectory, relativePath);
  const extension = path.extname(relativePath).toLowerCase();

  if (!['.png', '.jpg'].includes(extension)) {
    throw new Error(`Unsupported target extension for ${relativePath}.`);
  }

  if (!force && (await exists(destinationPath))) {
    report.skipped.push(relativePath);
    continue;
  }

  await fs.mkdir(path.dirname(destinationPath), { recursive: true });

  const sourcePath = path.join(communitySourceDirectory, relativePath);
  if (await exists(sourcePath)) {
    await writeSourceAsset(sourcePath, destinationPath, extension);
    report.copiedFromCommunity.push(relativePath);
    continue;
  }

  const generator = generatedAssets.get(relativePath);
  if (generator) {
    await writeGeneratedAsset(generator(), destinationPath);
    report.reconstructed.push(relativePath);
    continue;
  }

  report.missing.push(relativePath);
}

if (report.missing.length > 0) {
  throw new Error(
    `No Community source or deterministic reconstruction for:\n${report.missing
      .map((relativePath) => `- ${relativePath}`)
      .join('\n')}`
  );
}

console.log(
  JSON.stringify(
    {
      copiedFromCommunity: report.copiedFromCommunity.length,
      reconstructed: report.reconstructed.length,
      skipped: report.skipped.length,
      outputDirectory: destinationDirectory,
    },
    null,
    2
  )
);
