# BFF Contracts

Este directorio contiene el artefacto OpenAPI generado en runtime desde los
schemas Zod de `bff/src/schemas/`. Es el contrato entre el BFF y los clientes
Flutter.

## No editar a mano

`bff.openapi.yaml` se produce con:

```bash
cd bff && bun run build:openapi
```

Los tipos Dart derivados se escriben en:

- `pro/packages/formulaeapps_bff_client/`
- `community/packages/formulaeapps_bff_client/`

Para cambiar el contrato, edita Zod, vuelve a generar y valida el resultado:

```bash
bash scripts/generate-bff-types.sh
bash scripts/verify-parity.sh
```

Una edición manual del YAML o de esos paquetes será reemplazada por el
generador o detectada como drift por `verify-parity.sh`.

## Versionado

La versión se define en `bff/src/lib/openapi.ts`.

- MAJOR: cambio incompatible, como retirar una ruta o renombrar un campo.
- MINOR: adición compatible, como un campo opcional o ruta nueva.
- PATCH: cambios no semánticos, como descripciones y ejemplos.

## Estado auditado

El 2026-07-13 se comprobó que el contrato y los paquetes generados no tenían
drift tras regenerarlos. El scanner de rutas detecta consumidores ejecutables,
incluida la llamada Pro `iapValidatePost`, y no cuenta comentarios como uso de
una ruta. Consulta
[la auditoría funcional](../docs/AUDITORIA_FUNCIONAL_2026-07-13.md) antes de
atribuir un estado de despliegue a este contrato.
