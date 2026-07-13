# Formulae Pro diagram images (English labels)

This folder is the staging location for the **53 English-labelled** diagram PNGs
that the Formulae Pro app fetches from `https://formulaeapps.com/imagenes_ingles/`.

- The app URLs live in `pro/lib/constantes/urls_imagenes.dart` (53 entries under
  `formulaeapps.com/imagenes_ingles/`). Do not invent paths; mirror those exactly.
- Each English image is the **same diagram** as its Spanish counterpart in
  `../imagenes/<same relative path>` but with **English labels**. Use the Spanish
  prompt from `pro/docs/CATALOGO_PROMPTS_IMAGENES.md` for the same file, translate
  the labels to English, keep everything else identical.
- Subfolders in use: `electricidad_y_magnetismo/`, `geometria/`,
  `matematicas_discretas/`, `preguntas_frecuentes/`, plus a few root-level FAQ/UI
  mockups (e.g. `formulas_favoritas.png`, `agregar_tarea.png`).
- Style is identical to the Spanish set: **solid navy `#27283D` background**
  (the app background), light off-white strokes, PNG. See the "Estilo de fondo"
  block in `CATALOGO_PROMPTS_IMAGENES.md`.
- On landing deploy this folder publishes to
  `https://formulaeapps.com/imagenes_ingles/...`. After upload, verify each URL
  returns 200.
