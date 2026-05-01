/**
 * Genera todos los favicons rasterizados desde un PNG fuente.
 *
 * Fuente:    src/assets/og/favicon-source.png  (512x512 del icono app)
 * Salida:    public/favicon-16x16.png
 *            public/favicon-32x32.png
 *            public/apple-touch-icon.png   (180x180, iOS home screen)
 *            public/icon-192.png           (PWA Android)
 *            public/icon-512.png           (PWA Android, splash)
 *
 * El SVG vectorial se copia a mano a public/favicon.svg
 * y los browsers modernos lo prefieren.
 *
 * Uso:  npm run favicons
 */
import sharp from 'sharp';
import { readFile, mkdir } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

const root = path.resolve(fileURLToPath(import.meta.url), '../..');
const source = path.join(root, 'src/assets/og/favicon-source.png');
const outDir = path.join(root, 'public');

const VARIANTS = [
  { name: 'favicon-16x16.png', size: 16 },
  { name: 'favicon-32x32.png', size: 32 },
  { name: 'apple-touch-icon.png', size: 180 },
  { name: 'icon-192.png', size: 192 },
  { name: 'icon-512.png', size: 512 },
];

await mkdir(outDir, { recursive: true });

const sourceBuffer = await readFile(source);
console.log(`Generando favicons desde ${path.relative(root, source)}...`);

for (const { name, size } of VARIANTS) {
  const png = await sharp(sourceBuffer)
    .resize(size, size, { fit: 'cover' })
    .png({ compressionLevel: 9 })
    .toBuffer();

  await sharp(png).toFile(path.join(outDir, name));

  const sizeKB = (png.length / 1024).toFixed(1);
  console.log(`  ✓ public/${name}  (${size}×${size}, ${sizeKB} KB)`);
}

console.log('\n  ✓ public/favicon.svg ya está copiado a mano (vector master).');
