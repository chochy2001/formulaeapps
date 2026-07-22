/**
 * Checks the built landing, not source text, for translated English
 * navigation/structured data and that the home gallery ships real app screenshots.
 */
import { readFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

const root = path.resolve(fileURLToPath(import.meta.url), '../..');

async function readBuiltPage(relativePath) {
  try {
    return await readFile(path.join(root, 'dist', relativePath), 'utf8');
  } catch {
    throw new Error(`Missing built page dist/${relativePath}. Run bun run build first.`);
  }
}

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

const [spanishHome, englishHome, englishPro, englishCommunity] = await Promise.all([
  readBuiltPage('index.html'),
  readBuiltPage('en/index.html'),
  readBuiltPage('en/pro/index.html'),
  readBuiltPage('en/free/index.html'),
]);

for (const [name, html] of [
  ['es home', spanishHome],
  ['en home', englishHome],
]) {
  assert(html.includes('screenshot-'), `${name} is missing real screenshot assets.`);
}

assert(englishHome.includes('href="/en/support"'), 'English home is missing the /en/support link.');
assert(
  !englishHome.includes('/en/soporte'),
  'English home still links to the Spanish support slug.'
);
assert(
  !englishHome.includes('youtube-nocookie.com'),
  'English home embeds the Spanish-language video.'
);
assert(
  (englishHome.match(/Formulae screenshot:/g) ?? []).length === 10,
  'English home must render ten real feature screenshots.'
);
assert(
  englishPro.includes('An ad-free app for studying mathematics and science'),
  'English Pro JSON-LD is not localized.'
);
assert(
  englishCommunity.includes('A free, ad-supported app for studying mathematics and science'),
  'English Community JSON-LD is not localized.'
);

console.log('Localized marketing output is valid.');
