# syntax=docker/dockerfile:1.7
#
#  Dockerfile productivo para landing/ (sitio Astro 5 estático).
#
#  Build context esperado: ESTA carpeta (landing/).
#  En tu docker-compose.yml de la raíz del monorepo, declara:
#
#     services:
#       landing:
#         build:
#           context: ./landing
#           dockerfile: Dockerfile
#         labels:
#           - traefik.enable=true
#           - traefik.http.routers.landing.rule=Host(`formulaeapps.com`)
#           - traefik.http.services.landing.loadbalancer.server.port=80
#
#  El contenedor expone el puerto 80 internamente; Traefik termina TLS
#  y enruta por Host. No publiques 80 al host (-p 80:80) si Traefik ya
#  está delante en la misma red docker.

# ──────────── Stage 1 — builder ────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Capa de dependencias separada para aprovechar el cache cuando solo
# cambia el código fuente y no package.json.
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --no-audit --no-fund

# Resto del código
COPY . .

# Variables públicas inyectadas en build-time. Se sobreescriben con
# `args:` desde docker-compose si el dominio cambia (staging, etc.).
ARG PUBLIC_SITE_URL=https://formulaeapps.com
ARG PUBLIC_APP_URL=https://app.formulaeapps.com
ENV PUBLIC_SITE_URL=$PUBLIC_SITE_URL
ENV PUBLIC_APP_URL=$PUBLIC_APP_URL

# Type-check estricto (astro check) + build estático → /app/dist.
# Si el type-check falla, la imagen NO se construye → no hay deploy roto.
RUN npm run check \
 && npm run build \
 && test -f dist/index.html


# ──────────── Stage 2 — runtime ────────────
FROM nginx:1.27-alpine AS runtime

LABEL org.opencontainers.image.title="formulae-landing" \
      org.opencontainers.image.description="Landing oficial de formulaeapps.com (Astro 5 + nginx)" \
      org.opencontainers.image.vendor="CAPDESIS S.A. de C.V." \
      org.opencontainers.image.source="https://github.com/CAPDESIS/formulaeapps" \
      org.opencontainers.image.url="https://formulaeapps.com" \
      org.opencontainers.image.licenses="UNLICENSED"

# Reemplaza la default.conf de nginx por la nuestra (clean URLs, gzip,
# security headers, cache estratégico por tipo de recurso).
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Sitio compilado (sin Node, sin node_modules — solo HTML/CSS/imágenes)
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ > /dev/null 2>&1 || exit 1
