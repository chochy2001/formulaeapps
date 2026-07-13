# Deploy automatico de la web (landing + Pro) con gates

El workflow `.github/workflows/deploy-web.yml` construye candidatos inmutables
desde el SHA exacto de `main` y, cuando estan los dos secretos, los despliega a
Hostinger por FTPS con verificacion de certificado, referencia de rollback y
smoke test posterior. Se dispara en push a `main` bajo `landing/` o `pro/` y
tambien a mano con "Run workflow".

Esta version reemplaza el path FTP sin gates que el PR #55 deshabilito. Ahora
cumple el estandar de release de la flota.

## Que despliega

- **Landing** (`formulaeapps.com`): build de Astro a la raiz del FTP
  (chroot-eada a `public_html/`).
- **Pro web** (`app.formulaeapps.com`): `flutter build web` (`build_web.sh`,
  `--base-href "/"`) a `public_html/app/` (con `cd app`).

## Secretos de GitHub (repo `CAPDESIS/formulaeapps`)

Settings -> Secrets and variables -> Actions -> New repository secret:

| Nombre | Valor |
|---|---|
| `FTP_PASSWORD` | Contrasena del FTP de Hostinger (hPanel -> FTP Accounts). |
| `FORMULAE_JWT_SHARED_SECRET` | `JWT_SHARED_SECRET` REAL del BFF en produccion (VPS `ancare`). Debe coincidir con el BFF vivo o el chat fallara la autenticacion. |

El host y el usuario del FTP van en el workflow como `env` (repo privado).

## Environment protegido

El job de deploy corre en el GitHub Environment **`production`**. Ahi puedes
anadir reviewers requeridos o un wait-timer (Settings -> Environments ->
production) si quieres una aprobacion manual antes de cada publicacion; sin eso,
el deploy es automatico tras un push a `main`.

## Gates de seguridad

1. **Preflight de main exacto**: el candidato debe ser el SHA actual de
   `origin/main`.
2. **Build como gate**: landing corre lint + test + build; Pro corre el build con
   guard anti-AdMob. Si algo falla, no se sube nada.
3. **FTPS forzado + verificacion de certificado**: control y datos cifrados; la
   contrasena y los archivos nunca viajan en claro.
4. **Sin `mirror --delete`**: solo sobrescribe (nombres de archivo estables). Un
   path equivocado nunca puede borrar el sitio; en el peor caso sube de mas.
5. **`cd app` con `cmd:fail-exit`**: aborta antes de subir si `cd app` falla
   (evita el footgun del chroot que borro la landing en R13).
6. **Contrasena via `.netrc` modo 600** en un HOME temporal, fuera de argumentos
   de proceso; GitHub la enmascara en logs.
7. **Smoke test**: tras subir, verifica que `formulaeapps.com` y
   `app.formulaeapps.com` respondan 200 y sirvan una landing/app validas. Si
   falla, el workflow queda rojo (el sitio no se borro; se investiga y se
   re-despliega el SHA bueno anterior).

## Como probarlo antes de confiar en el push

1. Crear los dos secretos.
2. Actions -> "Deploy Web (landing + Pro)" -> Run workflow (`main`).
3. Verifica que el job `deploy` termine verde (subida + smoke). Si la contrasena
   es incorrecta, o el certificado FTPS no valida, falla limpio sin tocar el
   sitio de forma destructiva.
4. Verifica en vivo `formulaeapps.com` y `app.formulaeapps.com`.

Despues, cada merge a `main` que toque `landing/` o `pro/` despliega solo.

## Rollback

Los candidatos (`landing-<sha>`, `pro-web-<sha>`) se retienen 14 dias. Para
revertir, corre "Run workflow" apuntando al commit bueno anterior: reconstruye e
sube ese candidato, sobrescribiendo por nombre de archivo. Como nunca se usa
`--delete`, no hay borrado que deshacer.

## Nota sobre el certificado FTPS

La verificacion de certificado (`ssl:verify-certificate true`) valida el cert
contra el host al que se conecta. Si Hostinger presenta un certificado que no
valida contra la IP `31.170.161.105`, la primera corrida fallara con un error de
TLS claro; en ese caso hay que conectar por el hostname FTPS que Hostinger
provea (cuyo cert si valida) cambiando `FTP_HOST` en el workflow. El cifrado
FTPS se mantiene en cualquier caso.

## Limitaciones

- El deploy usa el build como gate; la suite de tests completa corre en el
  workflow `CI` aparte.
- iOS/Android (tiendas) es un flujo distinto, pendiente.
