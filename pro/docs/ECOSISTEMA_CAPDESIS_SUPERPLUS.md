# Ecosistema Capdesis y suscripcion Super Plus (vision)

Documento de vision, no de implementacion. Registra la direccion de producto para
que cualquier agente o persona que continue sepa a donde vamos. Nada de esto esta
construido todavia; lo que si existe hoy se marca como tal.

## 1. Vision

Hoy cada app Pro de Capdesis se paga por separado (compra unica o suscripcion por
app). El objetivo es una **suscripcion unica mensual, "Capdesis Super Plus"**, que
da acceso a las versiones Pro de todas las apps del portafolio:

- Formulae Pro
- IngenieriaTracker (versiones Pro)
- CapMenu
- CapLiving
- CapGym
- Capdesis cursos (matematicas, programacion, etc.)

El usuario deja de pagar una sola vez por app; paga una mensualidad y obtiene todo.
Esto es un trabajo grande y multi-app: requiere identidad de usuario compartida,
un sistema de derechos (entitlements) central, y reconciliacion con las compras y
suscripciones actuales de cada app.

## 2. Cross-promocion (estrategia de ecosistema)

Cada app promociona a las demas para crecer el ecosistema:

- **IngenieriaTracker** ya promociona Formulae (hecho). A futuro promocionara los
  **cursos de programacion** y otras piezas del portafolio.
- **Formulae** promocionara los **cursos de matematicas** que se desarrollen mas
  adelante, y las demas apps Pro.
- El landing de Formulae (formulaeapps.com) y el menu lateral de la app (See App,
  Web Page, socials) son superficies naturales para estos enlaces cruzados.

La regla: la cross-promocion debe ser real y util (apps y cursos que existan), sin
contenido inventado.

## 3. Estado actual que YA existe (base para construir)

- **BFF `api.formulaeapps.com`** (Bun + Hono) ya emite **JWT de sesion de corta
  duracion** y ya tiene **validacion de recibos IAP** (Apple/Google). Es la base
  natural para identidad y derechos de Formulae.
- Las apps Flutter Pro ya consumen ese BFF (chat via OpenRouter, IAP).
- La separacion Pro/Community en Formulae es hoy **por carpeta** (pro/ vs
  community/), no por derechos en runtime.

## 4. Piezas que faltan para Super Plus (alto nivel)

1. **Identidad de usuario compartida (login/SSO)**: hoy no hay cuenta de usuario
   persistente cross-app. Ver `MODULARIZACION_Y_AUTH_FORMULAE.md`.
2. **Servicio central de entitlements**: una fuente de verdad que responda "este
   usuario tiene Super Plus activo" y "a que apps/tier tiene acceso". Debe
   reconciliar: suscripcion Super Plus, compras unicas historicas por app, e IAP
   de las tiendas (Apple/Google no permiten cobrar suscripciones cross-app fuera
   de su IAP en movil sin cumplir sus reglas; hay que disenar esto con cuidado).
3. **Gating por derechos en cada app**: cada app Pro consulta el entitlement y
   desbloquea el contenido/funciones Pro. En Formulae, migrar del gating por
   carpeta a un gating por entitlement (manteniendo el build Community para la
   tienda gratuita).
4. **Facturacion de suscripcion**: el fleet ya usa Polar para billing en otras
   apps; evaluar Polar para la suscripcion web y el flujo IAP para movil.

## 5. Riesgos y decisiones abiertas

- **Reglas de las tiendas**: Apple/Google exigen su IAP para desbloquear
  funcionalidad digital en sus apps. Una suscripcion cross-app cobrada por web
  (Polar/Stripe) puede desbloquear la version web, pero el desbloqueo en las apps
  moviles debe respetar las reglas de cada tienda. Requiere asesoria y diseno
  especifico por plataforma.
- **Reconciliacion con compras existentes**: los usuarios que ya compraron una app
  Pro no deben perder acceso. El entitlement central debe honrar compras previas.
- **Privacidad y datos de cuenta**: introducir cuentas implica manejar datos
  personales; alinear con la pagina de privacidad y la normativa aplicable.

## 6. Orden sugerido (multi-sesion)

1. Diseno del servicio de identidad + entitlements (contrato de API en el BFF).
2. Login en Formulae Pro (piloto) contra ese servicio, sin romper el flujo actual.
3. Gating por entitlement en Formulae Pro (feature flag, con fallback al gating por
   carpeta).
4. Extender el entitlement a una segunda app (IngenieriaTracker) para validar el
   modelo cross-app.
5. Facturacion Super Plus (web primero, luego reconciliacion IAP por plataforma).
6. Rollout gradual y comunicacion a usuarios con compras previas.

Relacionado: `MODULARIZACION_Y_AUTH_FORMULAE.md`, `PLAN_ACTUALIZACION_FUTURA.md`,
y el estandar de modularizacion del fleet en
`docs/fleet-modularization/` del workspace.
