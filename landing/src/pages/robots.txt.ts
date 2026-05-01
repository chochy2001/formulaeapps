import type { APIRoute } from 'astro';
import { SITE } from '../consts';

/**
 * robots.txt dinámico. Apunta al sitemap-index generado por @astrojs/sitemap.
 * Si en el futuro creas paneles de administración, bloquéalos aquí.
 */
export const GET: APIRoute = () => {
  const body = `User-agent: *
Allow: /

# Sitemap
Sitemap: ${SITE.url}/sitemap-index.xml

# Bloqueo crawlers de IA si NO quieres entrenamiento sobre este contenido.
# Comenta estas líneas si prefieres permitir indexación por LLMs.
User-agent: GPTBot
Disallow:

User-agent: ClaudeBot
Disallow:

User-agent: Google-Extended
Disallow:
`;
  return new Response(body, {
    headers: { 'Content-Type': 'text/plain; charset=utf-8' },
  });
};
