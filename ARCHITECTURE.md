# Formulae Apps — Arquitectura y operaciones

**Fecha del análisis original:** 2026-05-01
**Última actualización topológica:** 2026-05-19 (R13)
**Documento autoritativo.** Cualquier decisión operativa parte de aquí.
Actualiza este archivo cada vez que cambie la topología.

---

## ⚡ STATUS UPDATE 2026-05-19 (R13) — supersedes stale claims below

The 2026-05-01 body that follows describes the **pre-feature-002 state**. Read it for *historical context*, not current truth. Today's reality:

| Layer | Pre-feat-002 (2026-05-01) | **Now (2026-05-19 R13)** |
|---|---|---|
| BFF code location | "lives elsewhere, probably another team's repo" | ✅ Lives at `bff/` in this monorepo (commits `3b26d08`, `c30a3dc`, `e5a4bdd` on `main`) |
| BFF deployment | "VPS Contabo paused — Deploy 0 Flutter bug" | ✅ Live on Contabo `ancare` (212.28.180.4) at `https://api.formulaeapps.com` — Bun + Hono container; current branch validates 110/110 tests across 19 files (see `bff/README.md` for the live count) |
| BFF routes | "compose declares 4 routes, none implemented" | ✅ All 4 routes implemented + tested: `/health`, `/auth/token` (HMAC-validated), `/openai/chat` (OpenRouter proxy with 6-model allowlist), `/iap/validate` (R12 hardening returns clean 503 when secrets missing) |
| Pro Web | "shipped with PLACEHOLDER_DEV_NOT_FOR_PROD JWT — chat broken" | ✅ Re-deployed R13 with real `JWT_SHARED_SECRET` + `FORMULAE_BFF_CHAT_URL=https://api.formulaeapps.com/openai/chat`. End-to-end chat live (Gemini Flash Lite, ~1.16 s) |
| `api.formulaeapps.com` DNS | "Hostinger proxy, no content" | ✅ Cloudflare → Traefik (ancare VPS), TLS via Let's Encrypt R12 DNS-01, valid through Aug 17 2026 |
| `JWT_SHARED_SECRET` | "PLACEHOLDER" | ✅ Real 64-hex secret in `/opt/infrastructure/formulaeapps/.env` on ancare |
| OpenAI key | "still in `community/lib/chat_gpt/api_consts.dart`" | ✅ Removed; community uses `String.fromEnvironment(...)`. BFF holds the real OpenRouter key in `.env`. Probe-allowlist CI gate detects future model drift |
| `/iap/validate` IAP secrets | "compose mounts apple_p8.txt + google_sa.json, files don't exist" | 🟡 Directory `/opt/infrastructure/secrets/formulaeapps-docker/` created with empty placeholder files; R12 hardening returns 503 + `E_IAP_VALIDATION_UNAVAILABLE` until user drops real Apple p8 + Google SA (sole remaining T061) |
| `Deploy 0` Flutter bug | "blocks VPS resume" | ✅ Isolated — BFF deploy doesn't invoke Flutter on VPS. Image built on VPS via `docker compose build bff` (Bun runtime only) |
| UI structs `ChatModel` + `ModelsModel` | "hand-rolled files in `pro/lib/chat_gpt/`" | ✅ Files deleted (R13); types inlined into `api_service.dart` with re-export chain preserved |
| Local zombie clones (`FormulaePro/`, `FormulaeCommunity/`) | "27+ and 14+ uncommitted files" | Same WIP still in working trees (US1 deferred per spec); not blocking |

Feature 002 phase progress: **132 / 133 done (99.2 %)**. Only T061 (Apple + Google IAP secrets drop) remains; verification runbook in `specs/002-formulae-fe-be-sync/audit/deploy-handoff-2026-05-19.md` Step 7.

Related session memories: [[project-formulae-2026-05-19]] (full state), [[handoff-session-20260519]] (session handoff), [[hostinger-ftp-chroot]] (R13 FTP deploy lesson), [[flutter-ipa-vs-ios-release-build]] (T086 alternate path), [[openrouter-silent-model-drift]] (R12 probe-gate rationale).

The pre-2026-05-19 body below remains for historical context. Update individual section claims as they're touched in future work.

---

## TL;DR — respuestas directas a tus preguntas

| Pregunta | Respuesta |
|---|---|
| ¿Se sigue usando el VPS Contabo? | **NO actualmente.** El VPS sigue contratado y el código Docker está listo en el monorepo, pero no hay nada deployado ahí. La producción real corre en **Hostinger vía FTP**. El VPS quedó en pausa por un bug de Flutter durante el Deploy 0. |
| ¿Tenemos `FormulaePro` y `FormulaeCommunity` repetidos? | **Sí, hay duplicación con drift.** Los repos independientes en GitHub (`CAPDESIS/FormulaePro`, `CAPDESIS/FormulaeCommunity`) son **zombies**: hace 2 semanas y 6 meses sin push respectivamente. La copia activa vive en el monorepo `CAPDESIS/formulaeapps` en las carpetas `pro/` y `community/`. Adicionalmente tienes copias locales en `~/Documents/Apps/FormulaeApps/FormulaePro/` y `~/Documents/Apps/FormulaeApps/FormulaeCommunity/` con **trabajo no committeado que NO está en el monorepo** — es trabajo en riesgo de perderse. |
| ¿Los repos independientes siguen en uso? | **No.** Funcionan como archivos históricos. Todo nuevo desarrollo debe ir al monorepo. |
| ¿Cómo mantengo todo sincronizado? | Una sola fuente de verdad: `CAPDESIS/formulaeapps` (monorepo). Trabajas en local clonando ese repo. Los repos viejos los archivas en GitHub para preservar su historial. Detalle al final del documento. |

---

## 1. Topología actual de repositorios

### 1.1 Monorepo — fuente de verdad activa

**`git@github.com:CAPDESIS/formulaeapps.git`** (privado)

```
formulaeapps/
├── landing/      Astro 5 + Tailwind v4 — sitio público formulaeapps.com
├── pro/          Flutter 3.41 (Dart 3) — Formulae Pro (sin ads, IAP, ChatGPT)
├── community/    Flutter (Dart 2) — Formulae Community (con ads AdMob)
├── docker-compose.yml    config para deploy en VPS Contabo (no activa)
├── README.md     descripción del monorepo
└── DEPLOY_0_HANDOFF.md (en working tree local, sin push aún)
```

**Estado del repo en GitHub:** activo. Último commit `2eca1b6 fix(landing): always show full 'Abrir App Web' label on mobile` (2026-05-01).

**Estado de la copia local** en `~/Documents/Apps/FormulaeApps/formulaeapps-monorepo/`:
- ⚠️ **9 commits ATRÁS de origin/main** — necesita `git pull`.
- ⚠️ Modificaciones sin commit en `pro/lib/Favorites/favorites_pdf_generator.dart`, `pro/pubspec.lock`, `pro/pubspec.yaml`. Son cambios pequeños (-26 líneas neto en favorites_pdf_generator). Probablemente experimentos locales o WIP — debes decidir si los committeas o los descartas.
- 📄 `DEPLOY_0_HANDOFF.md` (untracked) — documento del Agente VPS sobre el deploy 0. Vale la pena committearlo al monorepo para que el contexto quede versionado.

### 1.2 Repos independientes — zombies con trabajo en riesgo

#### `git@github.com:CAPDESIS/FormulaePro.git`

- **Último push a GitHub:** 2026-04-16 (hace 15 días)
- **Último commit en GitHub:** `5ac6552 fix(gitleaks): anchor path regexes to prevent substring false matches (#21)`
- **Estado:** congelado en GitHub desde la unificación al monorepo el 30 de abril.
- **Estado local en `~/Documents/Apps/FormulaeApps/FormulaePro/`:**
  - 1 commit local **NO pusheado**: `00f4ded security: remove Android signing credentials` (solo agrega 3 líneas a `.gitignore` — trivial pero no aplicado en monorepo).
  - 27+ archivos modificados sin commit: `build.gradle`, `AndroidManifest.xml`, `l10n.yaml`, `lib/Favorites/favorite.dart` (+234), `lib/Favorites/favorites_screen.dart` (+775 líneas — cambio grande), `lib/chat_gpt/api_service.dart` (+92), `lib/chat_gpt/chat_gpt_button.dart`, `lib/constantes/constantes_imagenes.dart`, `lib/l10n/app_en.arb` (+12). **Esto es trabajo significativo en riesgo de perderse.**

#### `git@github.com:CAPDESIS/FormulaeCommunity.git`

- **Último push a GitHub:** 2025-10-29 (hace ~6 meses)
- **Último commit en GitHub:** `ced5030 Merge pull request #11 ... centralize-version-and-upgrade-deps`
- **Estado:** abandonado en GitHub hace medio año.
- **Estado local en `~/Documents/Apps/FormulaeApps/FormulaeCommunity/`:**
  - 1 commit local **NO pusheado**: `5b4d76e security: remove hardcoded OpenAI API key` — el commit que removió la clave `sk-Axkm...`. **Este fix YA está reflejado en el monorepo** (`community/lib/chat_gpt/api_consts.dart` ahora usa `String.fromEnvironment`), pero el commit como tal vive solo en el clon local.
  - 14+ archivos modificados sin commit: `build.gradle`, `AndroidManifest`, configs de iOS, Favorites, api_service, constantes_codigo (+95/-95). **Trabajo significativo no sincronizado.**

### 1.3 Working tree huérfano — `formulae-landing/`

`~/Documents/Apps/FormulaeApps/formulae-landing/` **no es un repo git** (sin `.git/`). Es solo el árbol de archivos donde inicialmente desarrollé la landing en Astro antes de pushearla al monorepo. Ya no se usa. Su contenido fue absorbido por `monorepo/landing/`.

### 1.4 Resumen visual del estado (2026-05-01, post-cleanup)

```
GitHub                                  Local (~/Documents/Apps/FormulaeApps/)
──────                                  ──────────────────────────────────────

CAPDESIS/formulaeapps    ←──→  formulaeapps-monorepo/   (clon, 9 commits atrás)
  (ACTIVO)                        ⚠ pull pendiente cuando termines tu sesión
                                  ⚠ cambios uncommitted en pro/ por revisar

CAPDESIS/FormulaePro     ←─×─  FormulaePro/             (clon huérfano)
  🔒 ARCHIVED                     ⚠ commits locales rebasados (mismo contenido
  read-only                          que ya está en monorepo, distintos hashes)
                                  ⚠ 27+ archivos uncommitted (WIP a auditar)

CAPDESIS/FormulaeCommunity ←×─ FormulaeCommunity/        (clon huérfano)
  🔒 ARCHIVED                     ⚠ commit local cuyo contenido YA está en
  read-only                          monorepo + 14+ archivos uncommitted
                                  ⚠ WIP a auditar

(no en GitHub)            ─×─   formulae-landing/         (deprecated, no es git)
                                  contenido absorbido en monorepo
```

**Acción ejecutada el 2026-05-01:**
- ✅ `gh repo archive CAPDESIS/FormulaePro` — archivado, todo el historial preservado.
- ✅ `gh repo archive CAPDESIS/FormulaeCommunity` — archivado, todo el historial preservado.
- ✅ Verificado que las correcciones de seguridad de los commits locales (`.gitignore`
  para keystore en Pro, `String.fromEnvironment` para OpenAI key en Community)
  **YA están reflejadas en el monorepo**, así que no quedaron pendientes de migrar.
- ⏸️ Las copias locales de los zombies se dejan intactas para que tú audites
  las modificaciones uncommitted antes de borrarlas. Comandos en sección 5.

**Lo que hace `archived` en GitHub:**
- El repo queda visible para siempre en el historial de la organización.
- Cualquiera con permisos sigue pudiendo `git clone` y leer todo el historial.
- No se aceptan PRs, issues nuevos, ni `git push`.
- Aparece un banner amarillo "This repository has been archived".
- Se puede des-archivar en cualquier momento desde Settings.

---

## 2. Estado de producción

### 2.1 Hosting actual

**Hostinger** (vía FTP). Servidor: `31.170.161.105`. Plan con LiteSpeed.

| URL | Sirve |
|---|---|
| `formulaeapps.com` | landing (Astro build estático en `public_html/`) |
| `formulaeapps.com/pro` `/gratuita` `/soporte` `/privacidad` `/terminos` `/en/...` | sub-páginas de la landing |
| `formulaeapps.com/app/*` | 301 redirect a `app.formulaeapps.com` (Flutter Pro construido con `--base-href "/"`) |
| `app.formulaeapps.com` | Flutter Pro Web (subdominio Hostinger mapeado a `public_html/app/`) |
| `app.formulaeapps.com/main.dart.js`, `/canvaskit/canvaskit.wasm`, etc. | assets del bundle Flutter |

**TLS:** Let's Encrypt (R13) emitido por Hostinger para apex + subdominio `app`. Cloudflare está delante en modo "Full (strict)".

**DNS:** Cloudflare. Records relevantes:
- A `@` (apex) → `31.170.161.105` proxied
- A `www` → `31.170.161.105` proxied
- A `app` → `31.170.161.105` proxied
- A `api` → `31.170.161.105` proxied (sin uso real todavía — backend BFF no deployado)

### 2.2 VPS Contabo — pausado, NO en producción

- El monorepo tiene `docker-compose.yml`, `pro/Dockerfile`, `landing/Dockerfile`, `landing/nginx.conf` listos para deploy via Docker.
- El Deploy 0 al VPS se inició y se detuvo por un bug en Flutter Pro (no se llegó a finalizar la construcción de imágenes en el server).
- Mientras se resuelve, producción se sirve por FTP en Hostinger. El VPS sigue contratado pero ocioso.
- **Acceso SSH**: tu `~/.ssh/config` tiene aliases `vps-old`, `ancare`, `capmenu-vps` pero **no `vps`** (el de Contabo donde corre el Agente VPS). Esa gestión vive solo en tu máquina/sesión — los agentes IA no tenemos acceso. Cuando quieras shutdown, cleanup o resume del VPS, tienes que entrar tú directamente con tu SSH config personalizada o las credenciales de Contabo.
- **Para retomar VPS algún día**: pull del monorepo, `docker compose up --build`, ajustar Cloudflare DNS apex de `31.170.161.105` (Hostinger) a la IP del VPS, y purgar cache CF.
- **Para apagarlo permanentemente** (si decides quedarte solo con Hostinger): cancela el contrato Contabo, borra la IP del DNS Cloudflare, elimina `docker-compose.yml` del monorepo (pero el repo conserva el historial). Reversible si después cambias de opinión.

### 2.3 BFF (api.formulaeapps.com) — no deployado

El `docker-compose.yml` declara el servicio `bff` con `build: ./bff`, secrets de Apple/Google, `JWT_SHARED_SECRET`, etc. **`bff/` no existe en el monorepo.** El código del BFF vive en otro lugar (probablemente otro repo del PM/Codex). Hasta que el BFF esté:
- El chat ChatGPT en Pro Web no funciona (el JWT del cliente no tiene contra qué autenticarse).
- Las compras IAP no se validan server-side.
- El subdomain `api.formulaeapps.com` apunta a Hostinger pero no tiene contenido relevante.

### 2.4 Build de Pro Web actual en producción

Compilado con dart-defines como **placeholder dev**:
- `JWT_SHARED_SECRET="PLACEHOLDER_DEV_NOT_FOR_PROD"` ⚠️
- `FORMULAE_BFF_CHAT_URL="https://api.formulaeapps.com/openai/chat"` (URL inalcanzable hasta que BFF exista)
- `FLAVOR=pro`
- `--base-href "/"` (configurado para subdominio)

Funciona la UI completa, navegación, fórmulas, búsqueda, favoritos. NO funciona el chat AI ni la validación de IAP. Imágenes y PDF con LaTeX requieren auditoría aparte (mencionado en TODO).

---

## 3. Stack técnico por componente

### 3.1 Landing (`landing/`)

| Capa | Tecnología |
|---|---|
| Framework | Astro 5.7 |
| Estilos | Tailwind CSS v4 (vía `@tailwindcss/vite`) |
| Tipos | TypeScript strict + path aliases |
| i18n | Routing nativo de Astro (ES default, EN en `/en/`) |
| Imágenes | `astro:assets` con WebP/AVIF responsive (Sharp) |
| SEO | Componentes propios `SEO.astro` + `JsonLd.astro` (Organization + MobileApplication + VideoObject) |
| Sitemap | `@astrojs/sitemap` con hreflang ES/EN |
| Robots | endpoint dinámico `src/pages/robots.txt.ts` que bloquea GPTBot/ClaudeBot/Google-Extended |
| Build output | `format: 'directory'` → `pro/index.html`, `gratuita/index.html`, etc. (compatible LiteSpeed nativo) |
| Server config Hostinger | `landing/public/.htaccess` (deflate, expires, headers, ErrorDocument 404) |
| Server config Docker (alternativa) | `landing/Dockerfile` multi-stage + `landing/nginx.conf` (clean URLs, gzip, security headers) |

### 3.2 Pro (`pro/`)

| Capa | Tecnología |
|---|---|
| Framework | Flutter 3.41 estable (Dart 3.0+) |
| Entry point flavor | `lib/main_pro.dart` (con `FLAVOR=pro` dart-define) |
| Estado | Provider (5 ChangeNotifier globales) |
| Routing | Navigator 1.0 con rutas estáticas en `routes.dart` (533 líneas) |
| i18n | `flutter_localizations` + `app_es.arb` / `app_en.arb` |
| IAP | `in_app_purchase` v3.x (validación server-side pendiente) |
| Chat | OpenAI vía BFF JWT-firmado (BFF no deployado todavía) |
| PDF | `pdf` + `flutter_math_fork` (calidad LaTeX revisión pendiente) |
| Build web | Dockerfile en `pro/Dockerfile` con `ghcr.io/cirruslabs/flutter:3.41.1` y check anti-AdMob |
| Server config Hostinger | `pro/web/.htaccess` (SPA fallback + redirect apex→subdominio) |

### 3.3 Community (`community/`)

| Capa | Tecnología |
|---|---|
| Framework | Flutter (Dart 2 — `>=2.12.0 <3.0.0`) ⚠️ deuda técnica grave |
| Entry point | `lib/main.dart` (sin flavor, app legado) |
| Monetización | `google_mobile_ads` (banner + intersticial + app_open) |
| Versión publicada | 2.2.9+74 |
| Estado | igual que Pro, código casi idéntico con drift |
| TODO | migrar a Dart 3, unificar con Pro como flavor |

### 3.4 Stack común (monorepo)

| Aspecto | Detalle |
|---|---|
| `.gitignore` raíz | excluye `.env`, `node_modules`, `.dart_tool`, `build/`, `.idea`, `.vscode`, secretos Android (keystore, key.properties), iOS Pods, etc. |
| `README.md` raíz | breve descripción del monorepo |
| CI/CD | sin pipelines formales — deploys manuales vía FTP por ahora |

---

## 4. Operaciones — cómo trabajar y deployar

### 4.1 Setup inicial (una sola vez)

```bash
# 1. Clona el monorepo (si todavía no lo tienes)
mkdir -p ~/Code && cd ~/Code
git clone git@github.com:CAPDESIS/formulaeapps.git
cd formulaeapps

# 2. Instala deps de la landing
cd landing && npm install && cd ..

# 3. Instala deps de Flutter Pro
cd pro && flutter pub get && cd ..

# 4. (Si quieres tocar Community algún día) Flutter Community
cd community && flutter pub get && cd ..
```

> **Recomendación**: la copia local "canónica" del monorepo conviene tenerla en `~/Code/formulaeapps` o similar, NO en `~/Documents/Apps/FormulaeApps/formulaeapps-monorepo/` para evitar confundirla con los repos viejos. Después de migrar el trabajo, los zombies van a desaparecer.

### 4.2 Desarrollo local

```bash
# Landing
cd landing && npm run dev      # http://localhost:4321

# Flutter Pro
cd pro && flutter run          # device/emulador conectado, usa lib/main.dart por defecto
flutter run -t lib/main_pro.dart --dart-define=FLAVOR=pro    # con flavor pro

# Community
cd community && flutter run
```

### 4.3 Deploy a producción (Hostinger FTP)

**Landing:**
```bash
cd landing
PUBLIC_SITE_URL=https://formulaeapps.com PUBLIC_APP_URL=https://app.formulaeapps.com npm run build
# dist/ tiene el sitio listo
lftp -u 'u226095507.formulaeapps.com,<TU_PASSWORD>' 31.170.161.105 -e "
set ftp:passive on
set ftp:ssl-allow yes
set ssl:verify-certificate no
mirror --reverse --verbose=0 --delete --parallel=4 \\
  --exclude '^cgi-bin/' --exclude '^\\.well-known/' \\
  --exclude '^\\.user\\.ini\$' --exclude '^error_log\$' \\
  --exclude '^app/' \\
  ./dist/ ./
bye"
```

> ⚠️ **`--exclude '^app/'` es crítico** para no borrar el build de Pro al redeployar landing.

**Pro Web:**
```bash
cd pro
flutter build web \
  --release \
  -t lib/main_pro.dart \
  --base-href "/" \
  --dart-define=FLAVOR=pro \
  --dart-define=JWT_SHARED_SECRET="$JWT_SHARED_SECRET" \
  --dart-define=FORMULAE_BFF_CHAT_URL="https://api.formulaeapps.com/openai/chat" \
  --no-source-maps \
  --no-web-resources-cdn

lftp -u 'u226095507.formulaeapps.com,<TU_PASSWORD>' 31.170.161.105 -e "
set ftp:passive on
set ftp:ssl-allow yes
set ssl:verify-certificate no
cd app
mirror --reverse --verbose=0 --delete --parallel=4 \\
  ./build/web/ ./
bye"
```

> ⚠️ **`--base-href "/"` es crítico** para que funcione en `app.formulaeapps.com`. Si lo cambias, todos los assets se rompen.

**Cloudflare cache purge (opcional, después del deploy):**
```bash
curl -X POST "https://api.cloudflare.com/client/v4/zones/<ZONE_ID>/purge_cache" \
  -H "Authorization: Bearer <CF_TOKEN>" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
```

### 4.4 Deploy futuro a VPS Contabo (cuando se retome)

`docker-compose.yml` ya está en el monorepo. El Agente VPS lo regenera dinámicamente en cada deploy (servicios actuales: `landing`, `pro`, `bff`). Cuando esté listo:

```bash
# En el VPS:
cd /opt/formulaeapps
git pull
docker compose pull   # si usas registry privado
docker compose up -d --build
```

Switchear DNS Cloudflare apex de `31.170.161.105` (Hostinger) a la IP del VPS y mantener `--exclude` en futuros FTP por si quieres mantener Hostinger como fallback.

---

## 5. Plan de consolidación — preservar historia + eliminar drift

Quieres mantener el historial Y resolver la duplicación. Esto es lo que hay que hacer:

### Paso 1 — Auditar el trabajo no-pusheado en los repos zombies

```bash
# Local FormulaePro: ¿qué cambios uncommitted hay?
cd ~/Documents/Apps/FormulaeApps/FormulaePro
git diff > /tmp/formulaepro-uncommitted.diff
git log origin/main..HEAD --oneline    # commits locales no en GitHub

# Local FormulaeCommunity: igual
cd ~/Documents/Apps/FormulaeApps/FormulaeCommunity
git diff > /tmp/formulaecommunity-uncommitted.diff
git log origin/main..HEAD --oneline
```

Decide para cada cambio: **¿es WIP útil?** Si sí, se replica en el monorepo `pro/` o `community/` como un commit nuevo. Si no, se descarta.

### Paso 2 — Sincronizar tu copia local del monorepo con origin

```bash
cd ~/Documents/Apps/FormulaeApps/formulaeapps-monorepo
git stash   # guarda los cambios uncommitted que tengas
git pull origin main
git stash pop   # recupera los cambios; resuelve conflictos si los hay
```

(O mejor: muévelo a `~/Code/formulaeapps` y trabaja desde ahí.)

### Paso 3 — Archivar repos zombies en GitHub ✅ HECHO 2026-05-01

Ambos repos ya están marcados como `archived=true` en la API de GitHub.
Cualquiera de la organización CAPDESIS puede seguir leyendo el historial completo;
nadie puede hacer commits/PRs/issues nuevos sin des-archivar primero.

```bash
# Para reabrir (si algún día lo necesitas):
gh repo unarchive CAPDESIS/FormulaePro
gh repo unarchive CAPDESIS/FormulaeCommunity
```

### Paso 4 — Limpiar el árbol local

Una vez que todo el trabajo útil esté en el monorepo y los repos viejos estén archivados:

```bash
# Mueve los zombies a una carpeta de archivo (NO los borres aún, por seguridad)
mkdir -p ~/Archive/formulaeapps-pre-monorepo-2026-04-30
mv ~/Documents/Apps/FormulaeApps/FormulaePro ~/Archive/formulaeapps-pre-monorepo-2026-04-30/
mv ~/Documents/Apps/FormulaeApps/FormulaeCommunity ~/Archive/formulaeapps-pre-monorepo-2026-04-30/
mv ~/Documents/Apps/FormulaeApps/formulae-landing ~/Archive/formulaeapps-pre-monorepo-2026-04-30/

# Mueve el monorepo a su ubicación canónica si todavía no está
mv ~/Documents/Apps/FormulaeApps/formulaeapps-monorepo ~/Code/formulaeapps
```

Después de unas semanas trabajando solo desde `~/Code/formulaeapps` y confirmar que no necesitas volver a los archivos, puedes borrar el `~/Archive/...` (o dejarlo indefinidamente — son ~150 MB, irrelevantes).

### Paso 5 — Documenta el corte

Ya está hecho con este archivo y con `DEPLOY-NOTES-2026-04-30.md`. Solo asegúrate de pushear la documentación al monorepo:

```bash
cp ~/Documents/Apps/FormulaeApps/ARCHITECTURE.md ~/Code/formulaeapps/
cd ~/Code/formulaeapps
git add ARCHITECTURE.md
git commit -m "docs: add architecture & operations reference"
git push origin main
```

---

## 6. Backlog vivo (pendientes priorizados)

### Producto / contenido
- 🔴 **Imágenes en Pro Web no se ven** — investigar si es por placeholder JWT o paths hardcoded.
- 🔴 **PDFs con LaTeX mal formateado** — auditar `pro/lib/widgets_personalizados/ver_pdf.dart` y la rama de generación.
- 🟡 **Menú hamburguesa en mobile** — landing tiene CTAs accesibles pero los nav links están ocultos abajo de 768px.
- 🟡 **Dark mode real** — actualmente forzamos `color-scheme: light`.

### Infra / seguridad
- 🔴 **JWT_SHARED_SECRET real** — generar (alta entropía, ej: `openssl rand -base64 64`) y rebuildar Pro web.
- 🔴 **BFF deploy en `api.formulaeapps.com`** — sin esto el chat ChatGPT no funciona y las IAP no se validan server-side.
- 🟡 **Bug Flutter del Deploy 0 en Contabo VPS** — investigar y resolver para retomar deploy con Docker.
- 🟡 **OpenAI key rotation** — el `5b4d76e` la quitó del código local de Community pero el monorepo ya lo tiene migrado a env. Verificar que la clave histórica leakeada (`sk-Axkm...`) **fue revocada** en `platform.openai.com/api-keys`. Si no, revocar.
- 🟡 **Cambiar contraseña FTP** de Hostinger (la actual quedó en chats anteriores).
- 🟢 **Migrar Community de Dart 2 → Dart 3** (paso previo a unificar con Pro como flavor).
- 🟢 **Force-push para limpiar `Co-Authored-By: Claude`** en commits `1563d52`, `4846a65`, etc. (esperando luz verde).

### Documentación
- ✅ `ARCHITECTURE.md` (este archivo).
- ✅ `DEPLOY-NOTES-2026-04-30.md` (log de eventos del MVP, 406+ líneas).
- 🟡 Mover/copiar este archivo al monorepo y commitearlo para versionarlo.
- 🟡 Que el README del monorepo apunte aquí.
