# Formulae Flavors

FormulaePro is the unified repository. Build the paid app with the `pro`
flavor and the free app with the `community` flavor.

## Web

```sh
flutter build web --release -t lib/main_pro.dart --dart-define=FLAVOR=pro
flutter build web --release -t lib/main_community.dart --dart-define=FLAVOR=community
```

For VPS deploys, use the root script:

```sh
JWT_SHARED_SECRET="$JWT_SHARED_SECRET" ./build_web.sh
```

## Android

```sh
flutter build appbundle --release --flavor pro -t lib/main_pro.dart --dart-define=FLAVOR=pro
flutter build appbundle --release --flavor community -t lib/main_community.dart --dart-define=FLAVOR=community
```

## Runtime Secrets

```sh
flutter build web --release -t lib/main_pro.dart \
  --dart-define=FLAVOR=pro \
  --dart-define=JWT_SHARED_SECRET="$JWT_SHARED_SECRET" \
  --dart-define=FORMULAE_BFF_CHAT_URL="https://api.formulaeapps.com/openai/chat"
```

Never commit `android/key.properties`, keystores, OpenAI keys, or AdMob
production IDs. Provide them from CI/CD secrets or local untracked files.

`build_web.sh` fails fast if `JWT_SHARED_SECRET` is missing. OpenAI API keys must
stay only on the BFF.
