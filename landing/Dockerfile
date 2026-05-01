# syntax=docker/dockerfile:1.7

# ─────────────────────────────────────────────────────────────────────
#  Stage 1 — builder
#  Instala deps con cache de capas, type-checkea y ejecuta `astro build`.
# ─────────────────────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Copia primero los manifiestos para aprovechar el cache de capas:
# si ni package.json ni package-lock.json cambian, npm ci se salta.
COPY package.json package-lock.json* ./
RUN npm ci --no-audit --no-fund

# Copia el resto del código fuente
COPY . .

# Variables públicas inyectadas en build-time. Override con --build-arg.
ARG PUBLIC_SITE_URL=https://formulaeapps.com
ARG PUBLIC_APP_URL=https://app.formulaeapps.com
ENV PUBLIC_SITE_URL=$PUBLIC_SITE_URL
ENV PUBLIC_APP_URL=$PUBLIC_APP_URL

# Type-check + build estático → /app/dist
RUN npm run check && npm run build && \
    test -f dist/index.html || (echo "ERROR: dist/index.html no generado" && exit 1) && \
    echo "Build OK — tamaño:" && du -sh dist


# ─────────────────────────────────────────────────────────────────────
#  Stage 2 — runtime (nginx alpine sirviendo dist/)
# ─────────────────────────────────────────────────────────────────────
FROM nginx:1.27-alpine AS runtime

LABEL org.opencontainers.image.title="formulae-landing" \
      org.opencontainers.image.description="Landing page de formulaeapps.com (Astro 5 + nginx)" \
      org.opencontainers.image.vendor="CAPDESIS" \
      org.opencontainers.image.source="https://github.com/CAPDESIS/formulae-landing"

# Sustituye la config por defecto por la nuestra (clean URLs, gzip, headers)
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia el sitio compilado
COPY --from=builder /app/dist /usr/share/nginx/html

# nginx:alpine ya incluye usuario "nginx" sin privilegios y ejecuta
# nginx -g "daemon off;" como ENTRYPOINT por defecto.

EXPOSE 80

# Healthcheck básico — wget viene con busybox en alpine
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ > /dev/null 2>&1 || exit 1
