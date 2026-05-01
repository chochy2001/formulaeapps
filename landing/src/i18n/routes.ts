/**
 * Mapeo de rutas equivalentes entre ES y EN.
 * Cuando una página existe con nombre distinto en cada idioma
 * (p.ej. /gratuita ↔ /free), se registra aquí. Las rutas
 * compartidas (/, /pro) NO necesitan entrada.
 *
 * Usado por LanguageSwitcher.astro para que el toggle ES/EN
 * mantenga al usuario en la página equivalente.
 */
import type { Locale } from '../consts';

export const ROUTE_MAP: Record<string, Partial<Record<Locale, string>>> = {
  free: { es: '/gratuita', en: '/free' },
  support: { es: '/soporte', en: '/support' },
  privacy: { es: '/privacidad', en: '/privacy' },
  terms: { es: '/terminos', en: '/terms' },
};

/** Devuelve la entrada del mapa que matchea el path actual, o null. */
function findEntry(path: string): { es: string; en: string } | null {
  for (const entry of Object.values(ROUTE_MAP)) {
    if (entry.es === path || entry.en === path) {
      return { es: entry.es!, en: entry.en! };
    }
  }
  return null;
}

/**
 * Devuelve la URL equivalente en el `target` locale para una página
 * dada, conservando paths que no están traducidos (/, /pro, /404).
 */
export function translatePath(currentPath: string, target: Locale): string {
  const stripped = stripLocale(currentPath);
  const entry = findEntry(stripped);
  const localised = entry ? entry[target] : stripped;
  return target === 'es' ? localised : `/en${localised === '/' ? '' : localised}`;
}

function stripLocale(pathname: string): string {
  if (pathname === '/en' || pathname === '/en/') return '/';
  if (pathname.startsWith('/en/')) return pathname.replace('/en', '') || '/';
  return pathname || '/';
}
