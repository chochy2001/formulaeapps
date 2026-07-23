# Formulae meta-repository

`CAPDESIS/formulaeapps` es el meta-repositorio canónico de Formulae. El SHA
verificado de `origin/main` el 2026-07-22 es
`7250dc2c151d318e3fc94f8f84b32196d89478aa`.

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
con CI verde, SHA exacto de `main`, cadencia semanal manual, environment
`production`, smoke y rollback. El workflow técnico de staging/JWT queda
archivado y no participa en la ruta de release ni debe usarse para provisionar
dominios o credenciales.

No se agregan submódulos internos: Formulae ya es un monorepo real y cambiar
su layout rompería los contratos de build y los paths de los clientes.
