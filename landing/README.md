# Formulae Landing

Landing page oficial de [formulaeapps.com](https://formulaeapps.com) — apps **Formulae Pro** y **Formulae Community** publicadas por CAPDESIS.

Reemplaza el sitio actual hecho con Hostinger Website Builder (Zyro) por un proyecto **Astro 5 + Tailwind v4** estático, optimizado para SEO y desplegado por FTP a Hostinger.

---

## Stack

| Capa | Herramienta | Por qué |
| --- | --- | --- |
| Framework | Astro 5 | Genera HTML estático puro, 0 KB de JS por defecto |
| Estilos | Tailwind CSS v4 (Vite plugin) | Tokens en CSS, sin `tailwind.config.js`, bundle ~5 KB |
| i18n | Built-in de Astro 5 | Routing nativo `/` (ES) + `/en/` |
| SEO | Componentes propios `SEO.astro` y `JsonLd.astro` | Meta + OG + Twitter + JSON-LD `MobileApplication` |
| Sitemap | `@astrojs/sitemap` | XML automático con hreflang |
| Tipos | TypeScript strict | Aliases `@/*`, `@components/*` |
| Deploy | Docker multi-stage → nginx en VPS propio | Imagen ~50 MB, portátil entre proveedores |

---

## Comandos

```bash
# Instalar dependencias
npm install

# Servidor de desarrollo (puerto 4321)
npm run dev

# Type-check sin construir
npm run check

# Build para producción → dist/
npm run build

# Previsualizar el build
npm run preview

# Generar imágenes OG (1200x630) desde src/assets/og/*.svg
npm run og
```

---

## Estructura

```
formulae-landing/
├── public/                          # Servidos tal cual: favicon, manifest, OG estáticas
│   ├── favicon.svg
│   ├── manifest.webmanifest
│   ├── robots.txt                   # Respaldo (el real es dinámico, ver más abajo)
│   └── og/default.png               # 1200x630 — TODO: reemplazar con imagen real
├── src/
│   ├── assets/images/               # Imágenes optimizadas por astro:assets
│   │   ├── hero/                    # TODO: descargar de zyrosite y subir aquí
│   │   ├── features/
│   │   └── store-badges/
│   ├── components/
│   │   ├── seo/
│   │   │   ├── SEO.astro            # Meta tags, OG, Twitter, hreflang, canonical
│   │   │   └── JsonLd.astro         # MobileApplication + Organization schema
│   │   ├── layout/
│   │   │   ├── Header.astro
│   │   │   ├── Footer.astro
│   │   │   └── LanguageSwitcher.astro
│   │   ├── home/
│   │   │   ├── Hero.astro
│   │   │   ├── Features.astro
│   │   │   ├── FeatureCard.astro
│   │   │   ├── AppComparison.astro
│   │   │   └── DownloadCTA.astro
│   │   └── ui/
│   │       ├── Container.astro
│   │       ├── StoreBadge.astro
│   │       └── FeatureIcon.astro
│   ├── i18n/ui.ts                   # Diccionario ES/EN
│   ├── layouts/BaseLayout.astro
│   ├── pages/
│   │   ├── index.astro              # /
│   │   ├── pro.astro                # /pro
│   │   ├── gratuita.astro           # /gratuita
│   │   ├── soporte.astro            # /soporte
│   │   ├── privacidad.astro         # /privacidad
│   │   ├── terminos.astro           # /terminos
│   │   ├── 404.astro
│   │   ├── robots.txt.ts            # Endpoint dinámico que genera robots.txt
│   │   └── en/                      # Mirrors EN: /en/, /en/pro, /en/free, ...
│   ├── styles/global.css            # Tailwind v4 + tokens en @theme
│   └── consts.ts                    # SITE, SOCIAL, STORES, FEATURES
├── astro.config.mjs                 # Astro + i18n + sitemap + Tailwind
├── tsconfig.json                    # strict + paths
├── Dockerfile                       # Multi-stage: node build → nginx serve
├── nginx.conf                       # Clean URLs, gzip, security headers, cache
├── .dockerignore                    # Excluye node_modules, dist, .git del build
└── scripts/generate-og.mjs          # Convierte src/assets/og/*.svg → public/og/*.png
```

---

## Datos extraídos del sitio actual (verificados 2026-04-30)

Todas las URLs y copy provienen del landing actual en producción **excepto las correcciones documentadas en `src/consts.ts`**:

- 🔧 **Play Store de Pro y Community estaban swappeadas** en el sitio actual (apuntaban al `applicationId` del otro). Corregido aquí.
- 🔧 **El subtítulo EN del hero quedó en español** en el sitio actual. Traducido en `src/i18n/ui.ts`.
- 🚫 **`formulaeweb.online`** queda fuera (dominio sin DNS).
- 🚫 **APK directo desde `assets.zyrosite.com`** queda fuera (mala práctica + cambio de host).

### Capturas de pantalla

Ya descargadas en `src/assets/images/screenshots/screenshot-01.png` … `screenshot-10.png` (PNG 1215×2160 originales). Para usarlas en componentes:

```astro
---
import { Image } from 'astro:assets';
import shot01 from '@/assets/images/screenshots/screenshot-01.png';
---
<Image src={shot01} alt="Captura de Formulae mostrando el catálogo de fórmulas" />
```

`astro:assets` las optimiza automáticamente a WebP/AVIF en el build.

### Imágenes OG

Generadas a `public/og/{default,pro,community}.png` (1200×630) desde plantillas SVG en `src/assets/og/`. Para regenerarlas:

```bash
npm run og
```

Edita los `.svg` en cualquier editor vectorial y vuelve a correr el comando.

---

## SEO checklist incorporado

- ✅ Title único por página + meta description
- ✅ Open Graph (og:title, og:description, og:image 1200x630, og:locale)
- ✅ Twitter Cards (`summary_large_image`)
- ✅ Canonical URL en cada página
- ✅ hreflang ES/EN/x-default automático
- ✅ JSON-LD `Organization` + `MobileApplication` (Pro y Community)
- ✅ Sitemap XML con i18n (`/sitemap-index.xml`)
- ✅ robots.txt dinámico (excluye crawlers de IA por defecto)
- ✅ HTML semántico (h1 único por página, landmarks)
- ✅ "Skip to content" link para accesibilidad
- ✅ `prefers-reduced-motion` y `prefers-color-scheme` respetados
- ✅ `<Image>` de `astro:assets` exige `alt` obligatorio

---

## Deploy con Docker en tu VPS

### Construir la imagen localmente (opcional, para verificar)

```bash
docker build -t formulae-landing:latest .

# Probar antes de subir al VPS
docker run --rm -p 8080:80 formulae-landing:latest
# → http://localhost:8080
```

El build hace dos stages:

1. `node:20-alpine` → instala deps (con cache de capas), `astro build`.
2. `nginx:1.27-alpine` → copia `dist/` a `/usr/share/nginx/html` y monta nuestro `nginx.conf`.

Imagen final ~50-60 MB.

### Deploy en el VPS

Tres opciones según prefieras flujo manual, compose o gitops.

#### A) Build local + push a un registry

```bash
# En tu máquina:
docker build -t registry.tudominio.com/formulae-landing:$(git rev-parse --short HEAD) .
docker push registry.tudominio.com/formulae-landing:$(git rev-parse --short HEAD)

# En el VPS:
docker pull registry.tudominio.com/formulae-landing:<tag>
docker stop formulae-landing 2>/dev/null; docker rm formulae-landing 2>/dev/null
docker run -d --name formulae-landing --restart unless-stopped \
  -p 8080:80 \
  registry.tudominio.com/formulae-landing:<tag>
```

#### B) Docker Compose (recomendado si ya tienes traefik/caddy en el VPS)

`docker-compose.yml` en el VPS:

```yaml
services:
  landing:
    image: registry.tudominio.com/formulae-landing:latest
    restart: unless-stopped
    networks: [web]
    labels:
      # Ejemplo Traefik con TLS automático
      - traefik.enable=true
      - traefik.http.routers.landing.rule=Host(`formulaeapps.com`)
      - traefik.http.routers.landing.entrypoints=websecure
      - traefik.http.routers.landing.tls.certresolver=le
      - traefik.http.services.landing.loadbalancer.server.port=80
networks:
  web:
    external: true
```

Luego: `docker compose pull && docker compose up -d`.

#### C) Build directo en el VPS

Si no quieres registry, clona el repo en el VPS y construye allí:

```bash
git clone https://github.com/CAPDESIS/formulae-landing /opt/formulae-landing
cd /opt/formulae-landing
docker build -t formulae-landing:latest .
docker stop formulae-landing 2>/dev/null; docker rm formulae-landing 2>/dev/null
docker run -d --name formulae-landing --restart unless-stopped \
  -p 8080:80 formulae-landing:latest
```

### TLS y reverse proxy

El contenedor expone HTTP plano en `:80`. Pon delante:

- **Traefik** o **Caddy**: TLS automático con Let's Encrypt y enrutado por host.
- **nginx en el host** (proxy_pass a `http://127.0.0.1:8080`).
- **Cloudflare Tunnel**: cero puertos abiertos en el VPS.

### Rollback

```bash
# Mantén dos versiones etiquetadas
docker tag formulae-landing:latest formulae-landing:previous
# Si la nueva falla:
docker stop formulae-landing && docker rm formulae-landing
docker run -d --name formulae-landing --restart unless-stopped \
  -p 8080:80 formulae-landing:previous
```

### Purgar cache de Cloudflare tras deploy

```bash
curl -X POST \
  "https://api.cloudflare.com/client/v4/zones/<ZONE_ID>/purge_cache" \
  -H "Authorization: Bearer <API_TOKEN>" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
```

---

## DNS recomendado en Cloudflare

| Tipo | Nombre | Destino | Proxy |
| --- | --- | --- | --- |
| A | `@` | IP del hosting (Hostinger) | sí |
| CNAME | `www` | `formulaeapps.com` | sí |
| CNAME | `app` | (a definir cuando suba el build Flutter Web) | sí |
| TXT | `@` | verificación de Google Search Console | — |

---

## TODO antes del primer deploy

- [x] Descargar capturas de Zyrosite → `src/assets/images/screenshots/`
- [x] Generar imágenes OG (`public/og/{default,pro,community}.png`)
- [x] Verificar que `npm run build` pasa (1.1 MB en `dist/`)
- [ ] Insertar las capturas reales en `Hero.astro` y donde haga falta (ahora hay un placeholder con gradiente)
- [ ] Generar `public/favicon.svg`, `favicon-32x32.png`, `apple-touch-icon.png`, `icon-192.png`, `icon-512.png`
- [ ] Verificar el número real de WhatsApp (`SOCIAL.whatsapp` actualmente apunta a `https://wa.me/5561869139` extraído del sitio actual — el formato parece incompleto)
- [ ] Confirmar `STORES.pro.huawei` y `STORES.community.huawei` (URLs heredadas del sitio anterior)
- [ ] Construir y probar el contenedor: `docker build -t formulae-landing . && docker run --rm -p 8080:80 formulae-landing`
- [ ] Configurar Cloudflare DNS apuntando al VPS
- [ ] Si quieres analytics, añadir GA4 o Cloudflare Web Analytics en `BaseLayout.astro`
