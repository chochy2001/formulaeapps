/**
 * Convierte src/assets/og/*.svg → public/og/*.png a 1200x630.
 *
 * Uso:
 *   npm run og
 *
 * Sharp viene como dependencia transitiva de Astro 5 (vía astro:assets),
 * así que después de `npm install` está disponible sin paso extra.
 *
 * Si quieres editar las plantillas, abre los .svg en Figma/Inkscape/un
 * editor de texto y vuelve a correr este script.
 */
import { readFile, writeFile, mkdir, readdir } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import sharp from 'sharp';

const root = path.resolve(fileURLToPath(import.meta.url), '../..');
const srcDir = path.join(root, 'src/assets/og');
const outDir = path.join(root, 'public/og');

const WIDTH = 1200;
const HEIGHT = 630;

async function main() {
  await mkdir(outDir, { recursive: true });

  const entries = await readdir(srcDir);
  const svgs = entries.filter((f) => f.endsWith('.svg'));

  if (svgs.length === 0) {
    console.error(`✗ No se encontraron .svg en ${srcDir}`);
    process.exit(1);
  }

  console.log(`Generando ${svgs.length} imágenes OG (${WIDTH}x${HEIGHT})...`);

  for (const svgFile of svgs) {
    const name = path.basename(svgFile, '.svg');
    const inPath = path.join(srcDir, svgFile);
    const outPath = path.join(outDir, `${name}.png`);

    const svgBuffer = await readFile(inPath);

    const png = await sharp(svgBuffer, { density: 96 })
      .resize(WIDTH, HEIGHT, { fit: 'cover', position: 'center' })
      .png({ compressionLevel: 9, palette: false })
      .toBuffer();

    await writeFile(outPath, png);

    const sizeKB = (png.length / 1024).toFixed(1);
    console.log(`  ✓ public/og/${name}.png  (${sizeKB} KB)`);
  }

  console.log('\nReferéncialas en SEO con `image="/og/<nombre>.png"`.');
}

main().catch((err) => {
  console.error('✗ Error generando OG:', err);
  process.exit(1);
});
