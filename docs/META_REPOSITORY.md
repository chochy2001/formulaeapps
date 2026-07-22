# Formulae meta-repository

`CAPDESIS/formulaeapps` es el meta-repositorio canónico de Formulae. El SHA
verificado de `origin/main` el 2026-07-22 es
`1bd67426930a64d954d02bc3a44a0134263526f0`.

| Directorio | Responsabilidad | Validación mínima |
|---|---|---|
| `landing/` | Astro/Bun, sitio público y assets canónicos | `bun run lint`, `bun run test`, `bun run build` |
| `pro/` | Flutter Formulae Pro | `flutter analyze`, tests y build dirigido |
| `community/` | Flutter Community vendorizado para paridad | análisis/tests y paridad de assets |
| `bff/` | Bun/Hono/Zod, sesiones y contrato OpenAPI | `bun run typecheck`, `bun test`, build |
| `contracts/` | Contratos generados y cobertura de rutas | scripts de paridad y route coverage |
| `scripts/` | Validadores reproducibles del meta-repo | scripts sin secretos y gates fail-closed |

Cada directorio forma parte de una sola entrega coherente: los contratos se
generan desde el BFF, los clientes se validan contra ellos y los builds de web
usan el mismo SHA. El deploy de producción sigue el workflow del meta-repo,
con CI verde, SHA exacto de `main`, ventana lunes–jueves en
`America/Mexico_City`, environment `production`, smoke y rollback. La
migración JWT/BFF que aún conserva workflow técnico de staging queda como
excepción documentada hasta completar su cutover y no se considera evidencia
de producción.

No se agregan submódulos internos: Formulae ya es un monorepo real y cambiar
su layout rompería los contratos de build y los paths de los clientes.
