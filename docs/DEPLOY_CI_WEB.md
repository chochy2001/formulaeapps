# Deploy automatico de la web (landing + Pro) al mergear a main

El workflow `.github/workflows/deploy-web.yml` publica automaticamente a Hostinger
por FTP cuando `main` cambia bajo `landing/` o `pro/` (y tambien se puede correr a
mano con "Run workflow").

## Que despliega

- **Landing** (`formulaeapps.com`): build de Astro (`landing/dist/`) subido a la
  raiz del FTP, que esta chroot-eada a `public_html/`.
- **Pro web** (`app.formulaeapps.com`): `flutter build web` (via
  `pro/build_web.sh`, `--base-href "/"`) subido a `public_html/app/` (con `cd app`).

## Secretos de GitHub que hay que crear (una sola vez)

En el repo **`CAPDESIS/formulaeapps`** -> Settings -> Secrets and variables ->
Actions -> New repository secret. Crear estos DOS:

| Nombre del secreto | Valor |
|---|---|
| `FTP_PASSWORD` | La contrasena del FTP de Hostinger (la del panel hPanel -> FTP Accounts). |
| `FORMULAE_JWT_SHARED_SECRET` | El `JWT_SHARED_SECRET` REAL que usa el BFF en produccion (VPS `ancare`, `/opt/infrastructure/secrets/formulaeapps-docker/.env`). Debe ser IGUAL al que corre el BFF vivo, o el chat fallara la autenticacion. |

El host (`31.170.161.105`) y el usuario (`u226095507.formulaeapps.com`) van en el
propio workflow como `env` (el repo es privado). Si algun dia rotas el usuario o
el host, se editan ahi.

## Como probarlo (recomendado antes de confiar en el push)

1. Crear los dos secretos de arriba.
2. Actions -> "Deploy Web (landing + Pro)" -> Run workflow (rama `main`). Esto es
   `workflow_dispatch`: corre el mismo pipeline bajo demanda.
3. Si la contrasena FTP es correcta, el job `deploy` sube todo y termina verde. Si
   es incorrecta, falla limpio con error de autenticacion (no toca el sitio).
4. Verificar en vivo: `https://formulaeapps.com` (landing nueva) y
   `https://app.formulaeapps.com` (app Pro con las secciones nuevas). Un
   Cmd+Shift+R fuerza recarga si el service worker viejo sigue cacheado.

Despues de eso, cada merge a `main` que toque `landing/` o `pro/` despliega solo.

## Decisiones de seguridad del workflow

- **Sin `mirror --delete`**: solo sube y sobrescribe. Los nombres de archivo del
  build son estables (index.html, main.dart.js, flutter_service_worker.js), asi
  que el sitio se actualiza sin riesgo de borrar nada. Un path equivocado, en el
  peor caso, sube archivos de mas (recuperable), nunca borra el sitio.
- **`cd app` con `set cmd:fail-exit yes`**: si `cd app` fallara, lftp aborta antes
  de subir, evitando el footgun del chroot que borro la landing en R13.
- **Contrasena fuera de los argumentos de proceso**: se escribe en un `.netrc`
  temporal (modo 600) en un HOME temporal y se borra al terminar. GitHub Actions
  ademas enmascara el valor del secreto en los logs.
- Corre en runners self-hosted (`ci-runner-node`), sin depender del billing de
  runners de GitHub.

## Limitaciones / notas

- El deploy usa el build como gate: si `flutter build web` o `bun run build`
  fallan, no se sube nada. Los tests completos corren en el workflow `CI`
  aparte (no bloquean este deploy).
- iOS/Android (tiendas) es un flujo distinto y queda para despues.
- Si en el futuro se quiere limpiar archivos huerfanos del servidor, se puede
  anadir `--delete` a los `mirror`, pero solo tras confirmar los paths con una
  corrida manual.
