# syntax=docker/dockerfile:1.7

ARG FLUTTER_IMAGE=ghcr.io/cirruslabs/flutter:3.41.1

FROM ${FLUTTER_IMAGE} AS build

WORKDIR /app

ENV CI=true

COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .

ARG BASE_HREF=/
ARG JWT_SHARED_SECRET
ARG FORMULAE_BFF_BASE_URL=https://api.formulaeapps.com
ARG FORMULAE_BFF_CHAT_URL=https://api.formulaeapps.com/openai/chat

RUN if [ -z "${JWT_SHARED_SECRET}" ] || [ -z "${FORMULAE_BFF_BASE_URL}" ] || [ -z "${FORMULAE_BFF_CHAT_URL}" ]; then \
      echo "ERROR: JWT_SHARED_SECRET, FORMULAE_BFF_BASE_URL, and FORMULAE_BFF_CHAT_URL build args are required."; \
      exit 1; \
    fi; \
    flutter build web \
      --release \
      -t lib/main_pro.dart \
      --base-href "${BASE_HREF}" \
      --dart-define=FLAVOR=pro \
      --dart-define=JWT_SHARED_SECRET="${JWT_SHARED_SECRET}" \
      --dart-define=FORMULAE_BFF_BASE_URL="${FORMULAE_BFF_BASE_URL}" \
      --dart-define=FORMULAE_BFF_CHAT_URL="${FORMULAE_BFF_CHAT_URL}" \
      --optimization-level=4 \
      --no-source-maps \
      --no-wasm-dry-run \
      --no-web-resources-cdn; \
    if grep -R -E "google_mobile_ads|MobileAds|AdMobConfig|ca-app-pub-" build/web; then \
      echo "ERROR: AdMob symbols found in Pro web build."; \
      exit 1; \
    fi

FROM nginx:1.27-alpine AS runtime

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget -qO- http://127.0.0.1/ >/dev/null || exit 1

CMD ["nginx", "-g", "daemon off;"]
