# Formulae Apps

Monorepo oficial de **Formulae Apps** (CAPDESIS). Reúne en un solo repositorio la
landing page y las dos aplicaciones Flutter del producto.

## Estructura

```
formulaeapps/
├── landing/      # Landing page pública (Astro) — formulaeapps.com
├── pro/          # Formulae Pro (Flutter) — versión sin anuncios
└── community/    # Formulae Community (Flutter) — versión con anuncios
```

| Carpeta      | Stack                | Descripción                                         |
| ------------ | -------------------- | --------------------------------------------------- |
| `landing/`   | Astro + Tailwind     | Sitio público que presenta Pro y Community          |
| `pro/`       | Flutter (Dart)       | App de pago / sin ads. `pubspec`: `formulae 1.0.0+1` |
| `community/` | Flutter (Dart)       | App gratuita con ads. `pubspec`: `formulae 2.2.9+74` |

> Pro y Community comparten el `name: formulae` en su `pubspec.yaml` porque
> son dos *flavors* del mismo producto, distribuidos como apps separadas en las
> stores.

## Desarrollo local

### Landing (Astro)

```bash
cd landing
npm install
npm run dev        # http://localhost:4321
npm run build
```

### Pro / Community (Flutter)

```bash
cd pro          # o: cd community
flutter pub get
flutter run     # corre en el dispositivo/emulador conectado
```

Requisitos: Flutter SDK estable, Xcode (iOS) y/o Android Studio.

## Despliegue

- **Landing** se contenedoriza con `landing/Dockerfile` y se publica en el VPS
  (Contabo) vía el script `deploy.sh` del PM (no incluido aquí — vive en el VPS).
- **Pro** y **Community** se publican en App Store y Google Play como apps
  separadas.

## Notas

- `community/android/app/google-services.json` está commiteado a propósito:
  es config de cliente Firebase (no es un secreto). La seguridad real vive en
  las Firebase Security Rules.
- El repo es **privado** dentro de la organización `CAPDESIS` en GitHub.
- Variables sensibles (`.env`, `.env.production`, keystores Android, etc.) están
  ignoradas globalmente — ver `.gitignore`.
