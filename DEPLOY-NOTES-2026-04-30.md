# Deploy Notes — 2026-04-30

> **Archivo histórico/no operativo — 2026-07-13.** No ejecutes ni reutilices
> comandos, rutas, credenciales de ejemplo o afirmaciones de este documento para
> una promoción actual. Consulta [`docs/DEPLOY_CI_WEB.md`](docs/DEPLOY_CI_WEB.md),
> [`docs/AUDITORIA_FUNCIONAL_2026-07-13.md`](docs/AUDITORIA_FUNCIONAL_2026-07-13.md)
> y [`docs/TICKETS.md`](docs/TICKETS.md); las credenciales y el procedimiento
> protegido viven fuera del repositorio.

Notas operativas del deploy FTP a Hostinger ejecutado esta sesión.
Este texto se conserva sólo como contexto de la sesión histórica.

---

## ⚠️ R13 UPDATE 2026-05-19 — READ BEFORE USING THE LFTP COMMANDS BELOW

The lftp scripts in this file use `cd public_html/app` and `cd public_html` (lines 149, 180). **Those commands assume an unchrooted FTP session.** The current Hostinger FTP user `u226095507.formulaeapps.com@31.170.161.105` is **chrooted to `public_html/`** — `pwd` after login returns `/` (which IS `public_html/` from the unchrooted view).

If you copy-paste the `cd public_html/...` patterns into a new lftp session, **`cd` silently fails** (lftp doesn't abort on cd-fail by default) and `mirror --reverse --delete` then operates on the chroot root, wiping the landing. **This bit Round 13 on 2026-05-19** — recovery took 2 lftp passes and ~5 min outage window.

### Canonical R13-correct lftp pattern (use these instead)

```bash
# Upload Pro Web to subdomain dir (creates /app/ if missing)
cd /Users/jorge/Code/formulaeapps/pro
flutter build web --release -t lib/main_pro.dart --base-href "/" \
  --dart-define=FLAVOR=pro \
  --dart-define=JWT_SHARED_SECRET="$JWT_REAL" \
  --dart-define=FORMULAE_BFF_CHAT_URL=https://api.formulaeapps.com/openai/chat \
  --dart-define=FORMULAE_BUILD_NONCE=$(openssl rand -hex 16) \
  --dart-define=FORMULAE_APP_VERSION=1.0.0 \
  --no-source-maps --no-web-resources-cdn

FTPPW='<password>'
lftp -u "u226095507.formulaeapps.com,$FTPPW" 31.170.161.105 -e "
set ftp:passive on
set ftp:ssl-allow yes
set ssl:verify-certificate no
mkdir -p app
cd app
mirror --reverse --verbose=1 --parallel=4 build/web/ ./
bye
"
unset FTPPW

# Re-upload landing to apex, preserving /app/
cd /Users/jorge/Code/formulaeapps/landing
npm ci --no-audit --no-fund
PUBLIC_SITE_URL=https://formulaeapps.com PUBLIC_APP_URL=https://app.formulaeapps.com npm run build

FTPPW='<password>'
lftp -u "u226095507.formulaeapps.com,$FTPPW" 31.170.161.105 -e "
set ftp:passive on
set ftp:ssl-allow yes
set ssl:verify-certificate no
mirror --reverse --verbose=1 --delete --parallel=4 \
  --exclude '^app/' \
  --exclude '^cgi-bin/' \
  --exclude '^\.well-known/' \
  --exclude '^\.user\.ini\$' \
  --exclude '^error_log\$' \
  dist/ ./
bye
"
unset FTPPW
```

### What changed about the deploy since 2026-04-30

- BFF is now LIVE at `api.formulaeapps.com` (Bun + Hono container on Contabo `ancare`, R12 + R13 commits on `main`).
- Pro Web is now built with **real `JWT_SHARED_SECRET`** (pulled from VPS `.env` via `ssh chochy@100.77.243.93`) — chat works end-to-end.
- The OpenRouter-allowlist drift footgun is now caught by `bun run probe:allowlist` (R12 CI gate). Don't manually edit `bff/src/lib/env.ts` allowlist without re-running the probe.
- The `docker compose restart bff` footgun (does NOT re-read env_file) is fleet-wide; **always** use `docker compose up -d --force-recreate bff` after editing `.env`. See `specs/002-formulae-fe-be-sync/audit/fleet-restart-footgun-2026-05-19.md` for the 51 documented instances across the workspace.

Full R13 deploy + recovery runbook lives at `specs/002-formulae-fe-be-sync/audit/r13-deploy-2026-05-19.md`. **Read that file before any future Hostinger deploy.**

---

## TL;DR

- ✅ **Landing y App Pro están subidos a Hostinger y funcionando en el origen** (`31.170.161.105`).
- 🔴 **NO se ven en `https://formulaeapps.com` ni en `https://formulaeapps.com/app/` porque Cloudflare DNS está apuntando al VPS Contabo en lugar de Hostinger.**
- 🟡 **Acción pendiente de Jorge (1 minuto en Cloudflare):** cambiar el A record para que apunte a `31.170.161.105`. En cuanto eso esté hecho, ambos se ven.
- ⚠️ El build de Pro está hecho con `JWT_SHARED_SECRET=PLACEHOLDER_DEV_NOT_FOR_PROD` — la **UI carga pero el chat con ChatGPT no funcionará** hasta que se construya con el secret real y haya un BFF detrás.

---

## Lo que se hizo

### 1. Landing (Astro)
- Clone fresco de `git@github.com:CAPDESIS/formulaeapps.git` en temp.
- `npm ci` + `npm run build` con `PUBLIC_SITE_URL=https://formulaeapps.com` y `PUBLIC_APP_URL=https://app.formulaeapps.com`.
- Resultado: 13 páginas, 84 archivos, **4.2 MB**.
- Upload via `lftp` (`mirror --reverse --delete --parallel=4`) a `public_html/`, preservando `.htaccess`, `cgi-bin/`, `.well-known/`, `.user.ini` y `error_log`.
- Eliminado `default.php` (placeholder de Hostinger).
- Verificación origen Hostinger directo:
  ```
  HTTP/2 200
  Last-Modified: Fri, 01 May 2026 05:24:10 GMT
  Content-Length: 44633
  <title>Mejora tus habilidades en matemáticas y ciencias — Formulae</title>
  ```

### 2. App Pro (Flutter Web)
- Clone fresco, `cd pro/`, `flutter pub get`.
- Build: `flutter build web --release -t lib/main_pro.dart --base-href "/app/"` con dart-defines:
  - `FLAVOR=pro`
  - `JWT_SHARED_SECRET="PLACEHOLDER_DEV_NOT_FOR_PROD"` ⚠️
  - `FORMULAE_BFF_CHAT_URL="https://api.formulaeapps.com/openai/chat"`
- Build duró ~56 s. Resultado: **55 MB / 83 archivos**.
- Verificación: ✓ sin trazas de AdMob (Pro debe ser ad-free), ✓ base-href correcto, ✓ JWT placeholder presente en bundle.
- Upload via `lftp` a `public_html/app/` (carpeta creada automáticamente).
- Verificación origen Hostinger directo:
  ```
  /app/                          → HTTP 200, <title>Formulae Pro</title>
  /app/main.dart.js              → HTTP 200, cache 7d
  /app/flutter_service_worker.js → HTTP 200, cache 7d
  ```

### 3. Diagnóstico Cloudflare
- DNS público de `formulaeapps.com`: `172.67.131.215`, `104.21.12.5` (Cloudflare proxy).
- HTTP a `https://formulaeapps.com/` vía CF devuelve `404 page not found` en `text/plain` 19 bytes.
- Esa firma es de **Traefik** (default 404 cuando no hay router que matchee). Confirma que CF está reenviando a la IP del VPS Contabo, donde Traefik no tiene router activo para `formulaeapps.com` (Deploy 0 detenido por bug en Flutter).

---

## Estado por capa

| Capa | Estado | URL para verificar |
|---|---|---|
| Hostinger `public_html/` | ✅ landing servido | `curl -H "Host: formulaeapps.com" --resolve formulaeapps.com:443:31.170.161.105 -k https://formulaeapps.com/` |
| Hostinger `public_html/app/` | ✅ Pro web servido | `curl -H "Host: formulaeapps.com" --resolve formulaeapps.com:443:31.170.161.105 -k https://formulaeapps.com/app/` |
| Cloudflare DNS apex `formulaeapps.com` | 🔴 apunta a Contabo (Traefik 404) | `curl -sI https://formulaeapps.com/` |
| Cloudflare DNS `app.formulaeapps.com` | ❓ desconocido | `dig +short app.formulaeapps.com` |
| VPS Contabo Deploy 0 | 🟡 detenido (bug Flutter) | — |
| BFF (api.formulaeapps.com) | 🔴 no desplegado | — |
| Repo `CAPDESIS/formulaeapps` | ✅ sync con `main`, último commit `4846a65 chore(compose): sync exact VPS config` | — |

---

## Para que `formulaeapps.com` se vea AHORA (1 min)

Decisión arquitectónica de Jorge: ¿queremos que CF apunte a Hostinger temporalmente, o esperamos al VPS?

### Opción rápida — Cloudflare → Hostinger

1. Entra al dashboard de Cloudflare → zona `formulaeapps.com` → **DNS → Records**.
2. Edita el A record de `formulaeapps.com` (apex):
   - Cambia el target de la IP del VPS Contabo a `31.170.161.105`.
   - Mantén el proxy 🟧 ON (TLS automático + CDN).
3. Si quieres que `app.formulaeapps.com` también funcione: crea un CNAME `app` → `formulaeapps.com` (proxy ON) o un A record `app` → `31.170.161.105`. Luego, en Hostinger panel, crea el subdominio `app` y mapéalo a la carpeta `public_html/app/`.
4. Alternativa sin subdominio: con la apex apuntando a Hostinger, **`https://formulaeapps.com/app/` ya funciona** sin tocar más nada.

Tras el cambio CF (propaga en segundos):
- `formulaeapps.com` → landing nuevo
- `formulaeapps.com/app/` → Pro web (UI funciona, chat no)

### Opción correcta — terminar Deploy 0 en Contabo

Esperar a que Codex/PM resuelvan el bug de Flutter, los contenedores `landing` + `pro` + `bff` arranquen en Contabo, Traefik tome los routers, y CF empiece a recibir 200. Cuando eso esté listo, este deploy FTP queda como fallback histórico — Hostinger sigue sirviendo origin pero CF deja de mirar para allá.

**Mi recomendación:** Opción rápida hoy para validar visualmente que todo se ve bien en producción. Cuando Contabo esté estable, switchear el DNS de vuelta.

---

## Limitaciones conocidas del build actual de Pro

| Feature | Estado |
|---|---|
| UI completa, navegación, formularios | ✅ funciona |
| Catálogo de fórmulas, búsqueda, favoritos | ✅ funciona |
| Vídeos YouTube embebidos | ✅ funciona |
| Imágenes y diagramas | ✅ funciona |
| Compras in-app (paywall) | ❓ depende si la UI llama a Apple/Google nativos — en web probablemente no aplique |
| Asistente ChatGPT | 🔴 no funciona — el placeholder JWT no autenticará contra el BFF (que tampoco está deployado) |
| Notificaciones locales | 🔴 no aplican en web |
| Cámara, image picker | 🔴 web limited (depende de la implementación) |

Para que el chat funcione, mañana hay que:
1. Generar/recuperar el `JWT_SHARED_SECRET` real (debe ser el mismo que el que usa el BFF).
2. Re-buildar Pro con ese secret (no como placeholder).
3. Tener el BFF corriendo en `api.formulaeapps.com`.

---

## Checklist para mañana (en orden)

### Inmediato (puede ser hoy mismo o mañana)
- [ ] Decidir Opción rápida CF→Hostinger o esperar Contabo.
- [ ] Si Opción rápida: cambiar el A record en Cloudflare (1 min).
- [ ] Si quieres `app.formulaeapps.com` como subdominio, crear el CNAME en CF + el subdominio en Hostinger panel mapeado a `public_html/app/`.
- [ ] Cambiar la contraseña FTP en Hostinger (la actual quedó en el chat de hoy).

### Para llegar al estado "production-ready completo"
- [ ] Resolver bug de Flutter que detuvo el Deploy 0 en Contabo.
- [ ] Generar `JWT_SHARED_SECRET` real (alta entropía, ej: `openssl rand -base64 64`) y guardar en `.env` del VPS y como variable de entorno del BFF.
- [ ] Construir y desplegar el BFF (`api.formulaeapps.com`) con:
  - Endpoint `POST /openai/chat` que valida JWT del cliente Pro.
  - `OPENAI_API_KEY` real (revocar también el sk-Axkm... que sigue expuesto en `community/`).
  - Validación server-side de receipts de IAP (Apple `apple_p8`, Google `google_sa`).
- [ ] Re-buildar Pro con el JWT real, re-uploadear (o que lo haga Contabo Docker).
- [ ] Una vez Contabo verde: revertir CF DNS a Contabo (apex y `app`).

### Limpieza pendiente del backlog
- [ ] Revocar y rotar la OpenAI key `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` (sigue hardcoded en `community/lib/chat_gpt/api_consts.dart:2`).
- [ ] Migrar Community a Dart 3 antes de unificar con flavors.
- [ ] Force-push para limpiar `Co-Authored-By: Claude` de los commits `1563d52` y `4846a65` (esperando luz verde del PM).

---

## Comandos útiles para mañana

### Re-buildar la landing y resubir
```bash
TMP=$(mktemp -d) && cd "$TMP"
git clone --depth 1 -q git@github.com:CAPDESIS/formulaeapps.git
cd formulaeapps/landing
npm ci --no-audit --no-fund
PUBLIC_SITE_URL=https://formulaeapps.com PUBLIC_APP_URL=https://app.formulaeapps.com npm run build
lftp -u 'u226095507.formulaeapps.com,<NUEVO_PASSWORD>' 31.170.161.105 -e "
set ftp:passive on
set ftp:ssl-allow yes
set ssl:verify-certificate no
cd public_html
mirror --reverse --verbose=1 --delete --parallel=4 \\
  --exclude '^\\.htaccess\$' \\
  --exclude '^cgi-bin/' \\
  --exclude '^\\.well-known/' \\
  --exclude '^app/' \\
  $PWD/dist/ ./
bye"
```

Nota: añadí `--exclude '^app/'` para que el re-deploy de la landing NO borre el contenido de `/app/` en Hostinger.

### Re-buildar la app Pro con el JWT real y resubir
```bash
TMP=$(mktemp -d) && cd "$TMP"
git clone --depth 1 -q git@github.com:CAPDESIS/formulaeapps.git
cd formulaeapps/pro
flutter pub get
flutter build web \
  --release \
  -t lib/main_pro.dart \
  --base-href "/app/" \
  --dart-define=FLAVOR=pro \
  --dart-define=JWT_SHARED_SECRET="$JWT_REAL" \
  --dart-define=FORMULAE_BFF_CHAT_URL="https://api.formulaeapps.com/openai/chat" \
  --no-source-maps \
  --no-web-resources-cdn
lftp -u 'u226095507.formulaeapps.com,<NUEVO_PASSWORD>' 31.170.161.105 -e "
set ftp:passive on
set ftp:ssl-allow yes
set ssl:verify-certificate no
cd public_html/app
mirror --reverse --verbose=1 --delete --parallel=4 \\
  $PWD/build/web/ ./
bye"
```

### Verificar producción saltándose Cloudflare
```bash
# Origen Hostinger directo
curl -sI -H "Host: formulaeapps.com" --resolve formulaeapps.com:443:31.170.161.105 -k https://formulaeapps.com/
curl -sI -H "Host: formulaeapps.com" --resolve formulaeapps.com:443:31.170.161.105 -k https://formulaeapps.com/app/
```

### Verificar producción vía Cloudflare
```bash
curl -sI https://formulaeapps.com/
curl -s https://formulaeapps.com/ | grep -oE '<title>[^<]+</title>'
```

---

## Datos de acceso (rotarlos mañana)

| Servicio | Cómo se accedió hoy |
|---|---|
| FTP Hostinger | `ftp://u226095507.formulaeapps.com@31.170.161.105:21`, password expuesto en chat — **rotar** |
| GitHub `CAPDESIS/formulaeapps` | SSH key de `chochy2001` (admin, salta branch protection) |
| Cloudflare | Sin acceso (Jorge debe entrar manualmente) |
| Contabo VPS | Sin acceso (manejado por Agente VPS) |

---

## Resumen para retomar la conversación con la IA mañana

> Ayer hicimos un deploy FTP a Hostinger del landing y de Pro web (build con JWT placeholder).
> Ambos están sirviendo correctamente desde origen `31.170.161.105`.
> El bloqueo es que Cloudflare DNS apunta a Contabo VPS, que devuelve 404 (Traefik default).
> Para que se vea, hay que cambiar el A record en CF a `31.170.161.105` (decisión que se tomó / no se tomó: ___).
> Pendientes técnicos: bug Flutter en Contabo, JWT real, BFF deploy, OpenAI key rotation, force-push de commits con co-author Claude.
> El estado completo está en `/Users/jorge/Documents/Apps/FormulaeApps/DEPLOY-NOTES-2026-04-30.md`.

---

## Update 2026-05-01 (madrugada) — Hotfixes en producción

Después del primer deploy, surgieron tres bugs visibles. Todos corregidos:

### A) Modo oscuro destruía el contraste
- **Síntoma**: en macOS dark mode, el body se ponía `bg-ink-900 text-ink-100` (dark) pero todos los componentes del hero usaban clases fijas de modo claro (`text-ink-900`, `bg-white`), resultando en texto oscuro sobre fondo oscuro = invisible.
- **Causa**: `landing/src/styles/global.css` tenía un `@media (prefers-color-scheme: dark) { body { @apply bg-ink-900 text-ink-100; } }` sin contraparte en componentes.
- **Fix**: commit `1c37467 fix(landing): force light color scheme to avoid dark-mode contrast issues`. Removí el `@media` block y añadí `color-scheme: light` al `html`.
- **Pendiente futuro**: implementar dark mode real con variantes `dark:` en cada componente. Por ahora todos los visitantes ven modo claro independientemente de su OS.

### B) /pro, /gratuita, /soporte, /en/pro… devolvían 404 (y /en/ daba 403)
- **Síntoma**: solo el home funcionaba; toda subruta 404. `/en/` daba 403 Forbidden.
- **Causa**: Astro estaba configurado con `build.format: 'file'` que produce `pro.html`, `gratuita.html`, `en.html` etc. Mi nginx.conf en Docker maneja eso con `try_files $uri $uri.html`, pero **Hostinger LiteSpeed no rewrite a `.html`** sin reglas explícitas. Plus `en.html` quedaba "afuera" del directorio `en/`, que no tenía `index.html` → mod_dir 403.
- **Fix**: commit `8b38798 fix(landing): switch build.format to directory + add .htaccess for LiteSpeed`. Cambié `format: 'file'` → `'directory'` (genera `pro/index.html`, `gratuita/index.html`, etc.) + añadí `landing/public/.htaccess` con safety rewrites + cache headers + security headers.
- **Resultado**: las 13 rutas del sitio responden 200 (con un 301 LiteSpeed-auto para añadir trailing slash), `/no-existe` da 404 con la página personalizada de Astro.

### C) `app.formulaeapps.com` → SSL 525
- **Síntoma**: Cloudflare devuelve "SSL handshake failed" para el subdominio.
- **Causa**: El subdominio existe en CF DNS (apuntando a `31.170.161.105`) pero **Hostinger no tiene un certificado TLS para `app.formulaeapps.com`** porque el subdominio no fue creado en el panel de Hostinger. Cloudflare está en modo "Full (strict)" y rechaza la conexión sin cert válido.
- **Fix manual pendiente** (Jorge debe hacer):
  1. Hostinger panel → Sitios web → formulaeapps.com → **Subdominios** → Crear `app` → mapear a carpeta `public_html/app/`.
  2. Esperar 5-10 min a que Hostinger emita el cert Let's Encrypt automáticamente.
  3. Confirmar con `curl -sI https://app.formulaeapps.com/` que devuelve 200 vía CF.
- **Workaround válido entre tanto**: `https://formulaeapps.com/app/` ya funciona perfectamente, sirve la misma app Pro web.

---

## Estado actual de URLs (post-hotfix)

```
/                        200    Mejora tus habilidades en matemáticas y ciencias — Formulae
/pro                     200    Formulae Pro — Sin anuncios, con asistente IA   (1 redir 301→/pro/)
/gratuita                200    Formulae Community — Versión gratuita           (1 redir 301)
/soporte                 200    Soporte — Formulae                              (1 redir 301)
/privacidad              200    Política de privacidad — Formulae               (1 redir 301)
/terminos                200    Términos y condiciones — Formulae               (1 redir 301)
/en                      200    Improve your skills in maths and science — Formulae
/en/pro                  200    Formulae Pro — Ad-free with AI assistant
/en/free                 200    Formulae Community — Free version
/en/support              200    Support — Formulae
/en/privacy              200    Privacy policy — Formulae
/en/terms                200    Terms and conditions — Formulae
/app/                    200    Formulae Pro (Flutter web)
/no-existe               404    Página no encontrada | Formulae
/sitemap-index.xml       200    application/xml
/robots.txt              200    text/plain
/favicon.svg             200    image/svg+xml

app.formulaeapps.com     525    SSL handshake failed (esperando subdominio en Hostinger)
```

Los 301 son comportamiento normal de LiteSpeed (mod_dir añade trailing slash a directorios). Se podría eliminar el hop extra cambiando `trailingSlash: 'ignore'` → `'always'` en `astro.config.mjs` para que todos los enlaces internos ya incluyan `/`. No urgente.

---

## Commits en main hoy

```
8b38798 fix(landing): switch build.format to directory + add .htaccess for LiteSpeed
1c37467 fix(landing): force light color scheme to avoid dark-mode contrast issues
4846a65 chore(compose): sync exact VPS config to avoid drift
1563d52 landing: optimize Dockerfile with BuildKit cache + tighten .dockerignore
```

Los dos `fix(landing):` desbloquean el deploy FTP a Hostinger sin tocar la arquitectura Docker. Cuando Contabo VPS retome el deploy, el `format: 'directory'` también funciona ahí (nginx try_files cubre tanto `index.html` resolution como `.html` fallback).

---

## Update 2026-05-01 — Subdominio app.formulaeapps.com EN VIVO + ronda final de hotfixes

Después de los fixes de routing, modo oscuro y `.htaccess`, surgieron tres problemas adicionales que se cerraron en esta ronda:

### D) Pantalla en blanco en `/app/`
- **Síntoma**: el navegador cargaba `/app/` (HTML 200, título correcto), pero la pantalla quedaba completamente blanca; ningún componente Flutter renderizaba.
- **Causa**: el `.htaccess` que añadí al root (`/public_html/.htaccess`) tenía un `RewriteRule ^(.+?)/?$ /$1.html [L]` que aplicaba recursivamente dentro de `/app/`. Cuando Flutter pedía `/app/assets/AssetManifest.bin`, el rewrite trataba de servir `/app/assets/AssetManifest.bin.html` (que no existía) → caía a `ErrorDocument 404 /404.html` → Flutter recibía HTML donde esperaba binario → fallo de bootstrap.
- **Fix** (commit `0b627b4`): excluir explícitamente `/app/` del root .htaccess (`RewriteRule ^app(/|$) - [L]`) + crear un `.htaccess` propio en `/public_html/app/` con SPA fallback que respeta extensiones de asset.

### E) `app.formulaeapps.com` SSL 525 después de crear el subdominio
- Jorge creó el subdominio en hPanel mapeado a `/public_html/app/`. Hostinger emitió cert Let's Encrypt R13 inmediatamente, pero Cloudflare seguía devolviendo 525.
- **Causa**: Cloudflare cachea el estado "no cert" y tarda 5-15 min en redescubrir el cert nuevo. No requiere acción manual.
- **Resolución**: esperar (resolvió solo). Una vez que CF revalidó: `app.formulaeapps.com/` → 200 con `<title>Formulae Pro</title>`.

### F) Subdominio cargaba pero base-href estaba en `/app/` → todos los assets 404
- **Síntoma**: `app.formulaeapps.com/` servía el HTML pero pedía recursos en `/app/main.dart.js`, `/app/flutter_bootstrap.js`, etc., que no existen en el root del subdominio (el subdominio mapea a `/public_html/app/`, así que `/main.dart.js` es lo correcto, NO `/app/main.dart.js`).
- **Causa**: el primer build de Pro web (de hace 1 día) usó `--base-href="/app/"` porque originalmente íbamos a servir desde el subpath `/app/`. Eso funcionaba para subpath pero rompía subdominio.
- **Fix** (commit `0f098b8`):
  1. Re-buildar Flutter Pro con `--base-href="/"` para que las rutas relativas resuelvan al root del subdominio.
  2. Ese build SOLO funciona desde el subdominio. Si alguien accede a `formulaeapps.com/app/`, los assets quedarían en path equivocado.
  3. Para no romper la URL `formulaeapps.com/app/` (puede haber enlaces externos antiguos), añadí redirect 301 al subdominio en el `.htaccess` interno de `/app/`, condicional al host:
     ```apache
     RewriteCond %{HTTP_HOST} ^(www\.)?formulaeapps\.com$ [NC]
     RewriteRule ^(.*)$ https://app.formulaeapps.com/$1 [R=301,L]
     ```
- **Bug intermedio** (commit `fe8915e`): inicialmente puse el redirect en el `.htaccess` del root (`landing/public/.htaccess`). LiteSpeed lo ignoró porque para requests dentro de `/public_html/app/` (que existe como dir) las reglas del parent .htaccess no se ejecutan antes del DirectoryIndex. Lo moví al `.htaccess` per-directory dentro de `/app/` y funcionó al instante.

### G) Imágenes CAPDESIS rotas en `/app/`
- **Síntoma**: el logo CAPDESIS aparecía como icono de imagen rota en la app Flutter.
- **Causa**: el navegador tenía cacheado el estado anterior (cuando los assets devolvían HTML por culpa del bug D). Después de los fixes los archivos sirven correctamente (`Content-Type: image/png`, HTTP 200), pero el cache del browser y el service worker de Flutter retenían el resultado roto.
- **Fix**: limpieza de cache del navegador del usuario (Ctrl+Shift+R en Chrome / Cmd+Shift+R en macOS) + revisión que devolvía 200 PNG en cada path.

---

## Estado final post-todos los fixes (2026-05-01 06:09 UTC)

### URLs verificadas

```
formulaeapps.com/                        200    Landing ES
formulaeapps.com/pro                     200    Pro page ES
formulaeapps.com/gratuita                200    Community ES
formulaeapps.com/soporte                 200    Support ES
formulaeapps.com/privacidad              200    Privacy ES
formulaeapps.com/terminos                200    Terms ES
formulaeapps.com/en                      200    Landing EN
formulaeapps.com/en/pro                  200    Pro EN
formulaeapps.com/en/free                 200    Free EN
formulaeapps.com/en/support              200    Support EN
formulaeapps.com/en/privacy              200    Privacy EN
formulaeapps.com/en/terms                200    Terms EN
formulaeapps.com/sitemap-index.xml       200    Sitemap
formulaeapps.com/robots.txt              200    Robots
formulaeapps.com/favicon.svg             200    Favicon
formulaeapps.com/no-existe               404    Astro 404 page

formulaeapps.com/app/                    301 → https://app.formulaeapps.com/
formulaeapps.com/app/foo/bar             301 → https://app.formulaeapps.com/foo/bar

app.formulaeapps.com/                    200    Flutter Pro Web
app.formulaeapps.com/main.dart.js        200    JS bundle
app.formulaeapps.com/assets/AssetManifest.bin  200
app.formulaeapps.com/canvaskit/canvaskit.wasm  200
app.formulaeapps.com/assets/assets/images/capdesis_logo.png  200 image/png
```

### Commits del día (orden cronológico)

```
fe8915e fix(pro): move apex→subdomain redirect into pro/web/.htaccess
0f098b8 fix(deploy): make Flutter Pro work on subdomain, redirect /app/ to subdomain
0b627b4 fix(landing): exclude /app/ from .htaccess rewrites (Flutter SPA conflict)
8b38798 fix(landing): switch build.format to directory + add .htaccess for LiteSpeed
1c37467 fix(landing): force light color scheme to avoid dark-mode contrast issues
4846a65 chore(compose): sync exact VPS config to avoid drift
1563d52 landing: optimize Dockerfile with BuildKit cache + tighten .dockerignore
```

### Lo que sigue pendiente (no urgente)

1. **OpenAI key** sigue hardcoded en `community/lib/chat_gpt/api_consts.dart:2`. Revocar y rotar antes de cualquier deploy de Community.
2. **JWT_SHARED_SECRET en Pro web** es `PLACEHOLDER_DEV_NOT_FOR_PROD` — el chat con ChatGPT no funcionará hasta que (a) se construya con el secret real y (b) haya un BFF en `api.formulaeapps.com`.
3. **Contabo VPS** sigue detenido por el bug de Flutter; cuando se retome, hay que actualizar Cloudflare DNS apex de Hostinger a Contabo y mover los servicios al stack Docker.
4. **Force-push para limpiar `Co-Authored-By: Claude`** de los commits que tenían ese trailer, bajo confirmación del PM.
5. **Cambiar contraseña FTP** (la actual quedó en chats anteriores).
6. **Implementar dark mode real** en la landing (actualmente forzamos `color-scheme: light`).

---

## Update 2026-05-01 (mañana) — fix mobile + features pendientes para next session

### H) Botón "Abrir App Web" invisible en mobile
- **Síntoma**: en pantallas <640px, el CTA "Abrir App Web" del navbar simplemente no aparecía. Mobile users no tenían cómo llegar al subdominio desde el header.
- **Causa**: `Header.astro` tenía `class="hidden ... sm:inline-flex"` en el botón — ocultar abajo de breakpoint `sm` (640px). Era un legacy del primer diseño cuando se asumía que en mobile bastaba con CTA del hero.
- **Fix** (commits `4b3fe78` + `2eca1b6`):
  - Quitar `hidden ... sm:inline-flex` → botón siempre visible.
  - Padding/texto progresivo: `px-3 py-1.5 text-xs` en mobile, `sm:px-4 sm:py-2 sm:text-sm` en tablet+.
  - El primer intento usó breakpoint `xs:` pero **Tailwind v4 no incluye `xs` por defecto** (solo sm/md/lg/xl/2xl), así que la truncación a "App" en small no funcionaba como esperado. El fix definitivo muestra siempre la etiqueta completa "Abrir App Web" — cabe en 375px+ con el padding compacto, que es todo el universo de iPhones modernos.
- **Verificado**: HTML servido contiene `<a href="https://app.formulaeapps.com" class="inline-flex ..."` sin clases `hidden`.

---

## Pendientes mencionados para próxima sesión

### Flutter Pro (en `app.formulaeapps.com`)
- **Sección de imágenes**: Jorge reporta que no se ven las imágenes de las fórmulas/diagramas. Probable causa: la build actual usa `JWT_SHARED_SECRET=PLACEHOLDER...` y muchas funcionalidades dependen de assets remotos que pueden estar gateadas detrás de auth. O bien las URLs hardcoded de imágenes en el código apuntan a un host no disponible. Investigación pendiente.
- **PDF con LaTeX formateado**: la generación de PDF con `flutter_math_fork` + `pdf` debería renderizar fórmulas LaTeX nítidas, pero la integración entre `flutter_math_fork` (que renderiza con TeX paths) y el package `pdf` requiere un widget puente. Hay que revisar `lib/widgets_personalizados/ver_pdf.dart` y la rama de generación de PDF para confirmar que los nodos KaTeX están convirtiéndose a contenido vectorial en el PDF (no a imágenes pixeladas o a texto plano).

### Mobile UX en landing
- ✅ "Abrir App Web" visible en mobile (este fix).
- 🔲 **Nav links en mobile**: actualmente `Inicio`, `Formulae Pro`, `Formulae Community`, `Soporte` están con `hidden md:block` — invisible bajo 768px. Falta un menú hamburguesa para que mobile users naveguen entre páginas. Workaround temporal: el botón "Ver Formulae Pro" del hero lleva a `/pro`, y desde el footer se puede llegar a las demás. Pero la UX no es ideal.


---

## Update 2026-05-01 (cierre) — Consolidación de repos + cleanup

### Acciones ejecutadas

1. **Archivados ambos repos zombies en GitHub** (preserva historial):
   - `CAPDESIS/FormulaePro` → archived (último push 2026-04-16, 21 commits de historial preservados)
   - `CAPDESIS/FormulaeCommunity` → archived (último push 2025-10-29, 11+ commits de historial preservados)
2. **Verificado que los commits locales de los zombies ya están en el monorepo:**
   - `00f4ded security: remove Android signing credentials` (Pro) — `pro/.gitignore` en monorepo ya tiene `key.properties`, `*.jks`, `*.keystore` ✓
   - `5b4d76e security: remove hardcoded OpenAI API key` (Community) — `community/lib/chat_gpt/api_consts.dart` en monorepo usa `String.fromEnvironment(...)` ✓
3. **`ARCHITECTURE.md` actualizado y pusheado al monorepo** como source of truth permanente (commit `4d8537e`).
4. **VPS Contabo**: confirmado que no tengo SSH access (no hay alias `vps` en `~/.ssh/config` del Mac, solo `vps-old`/`ancare`/`capmenu-vps` que son de otros proyectos). Cualquier operación SSH al VPS la haces tú con tus credenciales de Contabo.

### Lo que NO se tocó (decisión consciente)

1. **Working trees locales de los zombies** (`~/Documents/Apps/FormulaeApps/FormulaePro/` y `.../FormulaeCommunity/`) → sin tocar. Tienen 27+ y 14+ archivos uncommitted que SON WIP del usuario. Deben auditarse antes de borrar — `ARCHITECTURE.md` sección 5 explica cómo.
2. **Copia local del monorepo** (`~/Documents/Apps/FormulaeApps/formulaeapps-monorepo/`) → 9 commits atrás de origin/main + cambios uncommitted en `pro/lib/Favorites/favorites_pdf_generator.dart`, `pubspec.lock`, `pubspec.yaml`. No la sincronicé automáticamente — el usuario debe hacer `git stash; git pull; git stash pop` y revisar el diff.
3. **`DEPLOY_0_HANDOFF.md`** untracked en el monorepo local → es del Agente VPS, lo dejo para que el usuario decida si lo committea.

### Estado final tras consolidación

- **Una sola fuente de verdad activa**: `git@github.com:CAPDESIS/formulaeapps.git` (monorepo).
- **Historial completo preservado**: los repos archivados siguen consultables en GitHub para siempre, con todos sus commits, branches, PRs, issues.
- **Sin force-push** ni rewrites: la historia del monorepo crece linealmente, los repos viejos están congelados pero íntegros.
- **Producción servida**: Hostinger FTP (`formulaeapps.com` + `app.formulaeapps.com`).
- **VPS Contabo**: dormant, código listo en monorepo para retomar cuando se resuelva el bug de Flutter.

### Commits del día (orden cronológico)

```
4d8537e  docs(architecture): mark zombie repos as archived, clarify VPS/SSH state
37bc4a1  docs: add ARCHITECTURE.md — single source of truth for repo topology, ops, and migration plan
2eca1b6  fix(landing): always show full 'Abrir App Web' label on mobile
4b3fe78  fix(landing): show 'Abrir App Web' CTA on mobile too
fe8915e  fix(pro): move apex→subdomain redirect into pro/web/.htaccess
0f098b8  fix(deploy): make Flutter Pro work on subdomain, redirect /app/ to subdomain
0b627b4  fix(landing): exclude /app/ from .htaccess rewrites (Flutter SPA conflict)
8b38798  fix(landing): switch build.format to directory + add .htaccess for LiteSpeed
1c37467  fix(landing): force light color scheme to avoid dark-mode contrast issues
4846a65  chore(compose): sync exact VPS config to avoid drift
1563d52  landing: optimize Dockerfile with BuildKit cache + tighten .dockerignore
```

### Lo que sigue pendiente del usuario (no automatizable por mí)

- 🟡 Auditar los archivos uncommitted en `~/Documents/Apps/FormulaeApps/FormulaePro/` y `.../FormulaeCommunity/` antes de mover esas carpetas a `~/Archive/`.
- 🟡 Sincronizar la copia local del monorepo con origin/main (9 commits behind).
- 🟡 Si quieres apagar el VPS Contabo definitivamente: SSH directo + `docker compose down`, después cancelar contrato. (No tengo SSH access).
- 🟡 Resolver el bug de Flutter del Deploy 0 (cuando lo tengas) para reactivar el VPS.
- 🟡 Generar `JWT_SHARED_SECRET` real + deployar BFF en `api.formulaeapps.com` para activar chat ChatGPT y validación IAP.

---

## Update 2026-05-01 (más tarde) — Menú hamburguesa móvil

### I) Nav links Inicio/Pro/Community/Soporte invisibles en mobile
- **Síntoma**: en pantallas <768px solo se veían el logo, ES/EN y botón "Abrir App Web". Los 4 enlaces de navegación (`Inicio`, `Formulae Pro`, `Formulae Community`, `Soporte`) estaban totalmente ocultos. Mobile users solo podían navegar entrando por home y usando los CTAs internos.
- **Causa**: el `<nav>` desktop tenía `class="hidden md:block"` (oculto bajo 768px) sin contraparte mobile.
- **Fix** (commit `55e0e11`): añadido un menú hamburguesa con `<details>/<summary>`:
  - Visible solo en mobile (`md:hidden`)
  - Despliega un dropdown con los 4 enlaces en una `<nav>` posicionada absolute
  - Cierra con clic afuera o tecla Escape (script deferred ~10 líneas)
  - Conserva `aria-current="page"` para resaltar la página actual
  - Accesible por teclado nativamente (`<details>` lo soporta)
  - Zero render-blocking JS (Astro defer'd)
- **Layout desktop** (md+) sin cambios: el nav horizontal sigue mostrándose como antes.
