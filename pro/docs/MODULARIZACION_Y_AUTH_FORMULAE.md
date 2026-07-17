# Modularizacion Free/Pro y autenticacion en Formulae (plan)

Plan de diseno, no implementacion. Objetivo: que Formulae Free (Community) y
Formulae Pro compartan modulos comunes sin duplicar codigo, y preparar el login
que habilitara la suscripcion Super Plus (ver `ECOSISTEMA_CAPDESIS_SUPERPLUS.md`).

## 1. Situacion actual (verificada)

- Dos apps Flutter distintas: `pro/` y `community/`, con contenido y widgets
  duplicados que han divergido (misma app forkeada). El gating Pro-only es por
  carpeta: lo que no se copia a `community/` no aparece en la app gratuita.
- El monorepo tambien tiene una variante `community` compilable dentro de `pro/`
  (`pro/lib/main_community.dart`, flavor community), pensada como base de una
  unificacion futura, pero no es la app Community publicada hoy.
- Regla de producto actual: **la Pro es la app buena y la que se actualiza ahora**.
  La Free se tocara despues, cuando la Pro este solida.

## 2. Objetivo de modularizacion

Extraer los modulos verdaderamente comunes a paquetes compartidos, y dejar en cada
app solo su capa especifica. Candidatos a modulo compartido:

- **Motor de contenido de formulas**: el patron de pantalla (Latex, titulos,
  favoritos, export PDF) y el registro de secciones/rutas/busqueda.
- **Render de LaTeX y export a PDF** (ya arreglado en Pro: captura de formulas
  como imagen). Debe vivir en un paquete comun para que Free lo herede si algun
  dia se decide.
- **Localizacion base ES/EN** y componentes de UI (BotonesMenu, AppBarHome,
  FondoDegradado, ZoomPersonalizado).
- **Cliente del BFF** (ya es un paquete path-dep: `packages/formulaeapps_bff_client`).
- **Identidad/entitlements** (nuevo, ver seccion 4).

Lo que NO se comparte: contenido exclusivo Pro, AdMob (solo Free), y las
diferencias de flavor (titulo, ads, funciones de pago).

## 3. Estrategia (alineada al estandar del fleet)

Seguir el estandar de modularizacion del workspace
(`docs/fleet-modularization/21-AGENT-OPERATING-STANDARD.md` y el ciclo de vida de
modulos con SemVer, tags inmutables, matriz de consumidores, piloto en staging,
validacion por app, rollout y rollback). En concreto para Formulae:

1. Empezar por un modulo de bajo riesgo y alto reuso (por ejemplo el paquete de
   widgets de presentacion de formulas o el export PDF) como paquete versionado.
2. Consumirlo primero en Pro (que es la que se actualiza), verificar analyze +
   tests + build, y solo despues evaluar migrar Community.
3. No unificar Pro y Community de golpe: la variante community-en-pro es el camino
   futuro, pero requiere migrar Community de su base vieja; es trabajo aparte.

## 4. Autenticacion / login (preparacion para Super Plus)

Hoy Formulae no tiene cuenta de usuario persistente. Para la suscripcion unica se
necesita login. Diseno propuesto (a validar):

- **Fuente de identidad**: extender el BFF (`api.formulaeapps.com`), que ya emite
  JWT de sesion y valida IAP, para soportar cuentas de usuario y consultar
  entitlements. Evaluar un proveedor de auth (por ejemplo el que ya use el fleet)
  en vez de construir auth desde cero.
- **Prohibido en el cliente**: nunca manejar contrasenas en texto ni credenciales
  sensibles fuera de un flujo seguro; el login debe ir por el proveedor/BFF.
- **Gating por entitlement con fallback**: introducir un servicio de derechos que
  Pro consulte; mientras no exista, mantener el gating por carpeta como fallback
  (feature flag). Asi el login se puede introducir sin romper el flujo actual.
- **Cross-app**: el mismo login/entitlement debe poder servir a IngenieriaTracker
  y las demas apps (SSO del ecosistema). Disenar el contrato de API pensando en
  multi-app desde el principio.
- **Reglas de tiendas**: respetar IAP de Apple/Google para desbloqueo en movil
  (ver riesgos en el doc de ecosistema).

## 5. Riesgos

- Unificar Free/Pro sin cuidado puede romper la app publicada; hacerlo por modulos
  versionados y validados, no de un solo golpe.
- Introducir login toca datos personales: alinear con privacidad/terminos.
- El gating por entitlement no debe degradar la experiencia offline de la app de
  formulas (que hoy funciona sin cuenta).

## 6. Primeros pasos concretos (cuando se priorice)

1. Inventariar que codigo es identico entre `pro/` y `community/` (candidatos a
   modulo) y medir la divergencia real.
2. Extraer un primer paquete compartido versionado y consumirlo en Pro.
3. Definir el contrato de API de identidad+entitlements en el BFF (OpenAPI), sin
   implementarlo aun, para acordar la forma.
4. Prototipo de login en Pro detras de un feature flag, con fallback al gating por
   carpeta.

Relacionado: `ECOSISTEMA_CAPDESIS_SUPERPLUS.md`, `PLAN_ACTUALIZACION_FUTURA.md`.
