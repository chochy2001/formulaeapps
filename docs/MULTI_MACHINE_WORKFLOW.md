# Trabajo distribuido y sincronización Git

`origin/main` es la única base de integración compartida. GitHub conserva todo
trabajo que deba sobrevivir a un cambio de equipo; un checkout, worktree o
stash local no es una fuente de verdad compartida.

## Inicio de una tarea

Desde un clon limpio y actualizado:

    git fetch --prune origin
    git switch main
    git pull --ff-only
    git worktree add -b agent/<tema>-<AAAAMMDD> \
      <ruta-compartida>/worktrees/formulae-<tema>-<AAAAMMDD> origin/main

Cada agente trabaja solamente en su rama y worktree. Antes de ceder una tarea
o cambiar de equipo, valida el cambio, crea un commit intencional, publica la
rama y abre una PR. Nunca se usa un stash como respaldo persistente.

    git status --short --branch
    git push -u origin HEAD

Tras integrar una rama, sincroniza `main` y elimina únicamente el worktree que
ya esté limpio e integrado:

    git fetch --prune origin
    git switch main
    git pull --ff-only
    git worktree remove <ruta-del-worktree-integrado>
    git branch -d agent/<tema>-<AAAAMMDD>

No se elimina una rama con trabajo distinto de `main`, ni se ejecuta una
recolección destructiva de objetos Git, sin revisar antes su contenido y
preservarlo remotamente.

## Preservación de trabajo previo

Estas ramas remotas preservan trabajo local histórico. Son archivo, no
candidatos de integración, y no se deben usar directamente como origen de una
PR a `main`:

- [archive/stash-20260529-deploy-notes-temp](https://github.com/CAPDESIS/formulaeapps/tree/archive/stash-20260529-deploy-notes-temp) (`50588e7`): nota histórica de despliegue.
- [archive/stash-20260705-fleet-cleanup-wip](https://github.com/CAPDESIS/formulaeapps/tree/archive/stash-20260705-fleet-cleanup-wip) (`b090015`): WIP amplio de limpieza, CI e infraestructura; requiere revisión selectiva.
- [archive/stash-20260713-bff-client-codegen](https://github.com/CAPDESIS/formulaeapps/tree/archive/stash-20260713-bff-client-codegen) (`3eb3730`): clientes Dart generados; dos archivos difieren de `main`.
- [archive/local-history-20260713](https://github.com/CAPDESIS/formulaeapps/tree/archive/local-history-20260713) (`a347805`): ancla de preservación para 47 puntas históricas potencialmente únicas y sus padres; no se fusiona.
- [archive/local-history-recovery-20260713](https://github.com/CAPDESIS/formulaeapps/tree/archive/local-history-recovery-20260713) (`b812a10`): preserva 58 commits históricos recuperados, incluidos parents de stash; no se fusiona.
- [archive/local-object-recovery-sanitized-20260713](https://github.com/CAPDESIS/formulaeapps/tree/archive/local-object-recovery-sanitized-20260713) (`28a017c`): árboles y blobs históricos saneados; una credencial detectada fue redactada y se sigue en `FML-129`.

Para retomar una de ellas, se inspecciona su diff y se reconstruye solamente el
cambio aprobado en una rama nueva basada en el `origin/main` vigente. Las tres
instantáneas se restauraron en worktrees aislados, pasaron `git diff --check`
y `gitleaks protect --staged --redact` antes de publicarse.
Si el escaneo encuentra una credencial, no se publica la rama cruda: se crea
una copia saneada, se abre un ticket de seguridad y el titular del secreto la
revoca/rota antes de limpiar o recrear el clon que contenía el objeto.

## Cierre verificable

Antes de terminar una sesión o mover trabajo a otro equipo, ejecuta:

    git status --short --branch
    git stash list
    git worktree list
    git fetch --prune origin
    git branch -vv

No debe quedar un cambio único sólo en disco local ni un stash como único
respaldo. Las ramas remotas de archivo conservan el contexto pendiente sin
presentarlo como trabajo listo para `main`. El estado operacional y los
bloqueos de promoción viven en [TICKETS.md](TICKETS.md).
