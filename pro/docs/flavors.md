# Formulae Flavors

FormulaePro is the unified repository. Build the paid app with the `pro`
flavor and the free app with the `community` flavor.

## Web

Los builds de release no aceptan un `JWT_SHARED_SECRET` vacío o placeholder.
Para Pro, usa el script que valida los tres defines antes de construir; las
variables reales deben llegar desde el entorno protegido de promoción, nunca
desde este archivo ni desde Git.

```sh
JWT_SHARED_SECRET="$JWT_SHARED_SECRET" \
FORMULAE_BFF_BASE_URL="https://api.formulaeapps.com" \
FORMULAE_BFF_CHAT_URL="https://api.formulaeapps.com/openai/chat" \
./build_web.sh
```

Si se necesita construir Community desde este repositorio, proporciona el mismo
contrato BFF de forma explícita:

```sh
: "${JWT_SHARED_SECRET:?exporta un JWT_SHARED_SECRET aprobado antes del build}"
flutter build web --release -t lib/main_community.dart \
  --dart-define=FLAVOR=community \
  --dart-define=JWT_SHARED_SECRET="$JWT_SHARED_SECRET" \
  --dart-define=FORMULAE_BFF_BASE_URL=https://api.formulaeapps.com \
  --dart-define=FORMULAE_BFF_CHAT_URL=https://api.formulaeapps.com/openai/chat
```

## Android

```sh
: "${JWT_SHARED_SECRET:?exporta un JWT_SHARED_SECRET aprobado antes del build}"
flutter build appbundle --release --flavor pro -t lib/main_pro.dart \
  --dart-define=FLAVOR=pro \
  --dart-define=JWT_SHARED_SECRET="$JWT_SHARED_SECRET" \
  --dart-define=FORMULAE_BFF_BASE_URL=https://api.formulaeapps.com \
  --dart-define=FORMULAE_BFF_CHAT_URL=https://api.formulaeapps.com/openai/chat
```

El bundle Community se construye con el mismo patrón y con su firma de tienda
aprobada. No ejecutar una publicación de tienda sólo desde esta guía: requiere
los secretos, IDs de AdMob y controles de promoción descritos en la auditoría.

## Runtime Secrets

```sh
: "${JWT_SHARED_SECRET:?exporta un JWT_SHARED_SECRET aprobado antes del build}"
flutter build web --release -t lib/main_pro.dart \
  --dart-define=FLAVOR=pro \
  --dart-define=JWT_SHARED_SECRET="$JWT_SHARED_SECRET" \
  --dart-define=FORMULAE_BFF_BASE_URL="https://api.formulaeapps.com" \
  --dart-define=FORMULAE_BFF_CHAT_URL="https://api.formulaeapps.com/openai/chat"
```

Never commit `android/key.properties`, keystores, OpenAI keys, or AdMob
production IDs. Provide them from CI/CD secrets or local untracked files.

`build_web.sh` fails fast if `JWT_SHARED_SECRET` is missing. OpenAI API keys must
stay only on the BFF.
