# Plan de actualizacion futura de Formulae Pro

Documento de roadmap para Formulae Pro. Se basa en cuatro analisis:
benchmark de Formulia, benchmark de otras apps de referencia, brechas de
contenido de ingenieria frente a planes de estudio UNAM/IPN, y fuentes de
graficos con licencia abierta. Solo aplica a la variante **Pro** (Community se
mantiene como esta).

## Punto de partida

Antes de esta ronda, Formulae Pro cubria 15 secciones casi todas de matematicas
puras: algebra, algebra lineal, calculo diferencial, calculo integral, calculo
multivariable, ecuaciones diferenciales, ejercicios, electricidad y magnetismo,
generales, geometria, matematicas discretas, matematicas financieras,
probabilidad y estadistica, series de Fourier y trigonometria.

## Ya entregado en la expansion de contenido

El commit `ad9e863` agrego 121 pantallas nuevas. El repositorio no conserva las
fotos, un JSON de transcripcion, el generador ni un registro que permita
reproducir las afirmaciones historicas de "752 formulas verificadas" o "140
erratas". Por tanto, esas cifras no se consideran evidencia de correccion. Las
formulas corregidas despues de la expansion deben registrar una fuente o una
derivacion verificable en `FUENTES_CONTENIDO.md`. En terminos del roadmap de
ingenieria, la expansion cubre parcialmente:

- **P0-1 Mecanica** (cinematica, dinamica, trabajo y energia, rotacional,
  momentum): seccion nueva creada.
- **P0-3 Termodinamica** (calor, gases, Carnot, dilatacion): seccion nueva.
- **P0-6 Conversion de unidades**: seccion nueva.
- **P0-7 Constantes** (fisicas y matematicas): seccion nueva.
- **P1-3 Optica** (reflexion, refraccion, lentes, iluminacion): seccion nueva.
- **Numeros reales y desigualdades**: seccion nueva.
- Enriquecimiento de algebra, trigonometria, geometria, calculo diferencial,
  calculo integral, probabilidad y estadistica, algebra lineal y electricidad y
  magnetismo.

## Vision

Llevar Formulae Pro de "formulario de matematicas" a "formulario de ingenieria
completo, bilingue ES/EN". El competidor de referencia (Formulia, cerca de 2.4
millones de descargas) cubre matematicas, fisica y quimica mas herramientas
interactivas. La diferenciacion propuesta para Pro: calculadoras interactivas
por formula, un diagrama junto a cada formula que lo amerite, y export a PDF con
formulas renderizadas.

## Fases de contenido pendientes

Prioridad segun demanda curricular (tronco comun primero). Las formulas
concretas de cada dominio estan en el analisis de brechas de ingenieria.

### P0 (critico, tronco comun) que falta

| Dominio | Estado | Notas |
|---|---|---|
| P0-2 Estatica y resistencia de materiales | Pendiente | Civil, Mecanica, Industrial, Aero, Mecatronica |
| P0-4 Quimica general y estequiometria | Pendiente | Tronco comun; Formulia lo tiene, nosotros no |
| P0-5 Circuitos electricos DC/AC | Revisar | Verificar si la seccion actual de electricidad es campos/Maxwell; de serlo, circuitos DC/AC es seccion nueva |

### P1 (alto)

Mecanica de fluidos e hidraulica, tablas de transformada de Laplace, ondas y
acustica (complemento de la optica ya entregada), metodos numericos, electronica
basica (semiconductores y amplificadores).

### P2 (especialidad por carrera)

Transformada Z, transferencia de calor, control automatico, maquinas electricas
y potencia, quimica de equilibrio y electroquimica, topografia, ciencia de
materiales, ciclos y maquinas termicas, geotecnia, y vibraciones mecanicas.

## Estrategia de graficos y diagramas

Ver `GRAFICOS_PENDIENTES.md` para el detalle y la plantilla de atribucion. En
resumen, dos vias:

1. **Corto plazo**: importar de Wikimedia Commons y tikz.net con verificacion de
   licencia archivo por archivo (dominio publico, CC0 o CC BY preferidos;
   registrar autor, licencia y URL en un archivo de creditos dentro de la app).
2. **Largo plazo**: generar los diagramas propios con TikZ o Matplotlib (salida
   sin restriccion de licencia). GeoGebra queda **vetado** para uso comercial
   sin licencia. En Flutter, SVG via flutter_svg con re-tematizado claro/oscuro,
   o PNG precompilado.

## Features de producto a adoptar

Priorizadas por valor frente a esfuerzo (S/M/L):

1. Calculadoras interactivas por formula (L) - principal diferenciador del
   mercado; Formulia y HiPER lo tienen.
2. Export a PDF con formulas renderizadas (M) - entregado; conserva un fallback
   de texto con fuente matematica cuando el renderer no permite capturar imagen.
3. Diagrama junto a cada formula que lo amerite (M).
4. Conversor de unidades transversal accesible desde cualquier pantalla (M) - la
   seccion de conversion ya entregada es la base de datos.
5. Tablas de referencia ampliadas (M).
6. Compartir una formula como imagen (S).
7. Tabla periodica interactiva (M).
8. Graficador de funciones (L).
9. Asistente con IA de apoyo (L) - ya existe el boton de chat via BFF.
10. Creador de calculadoras del usuario (L).

## Riesgos y dependencias

- Verificar contra el codigo real, antes de implementar circuitos, si la seccion
  actual de electricidad y magnetismo es campos y Maxwell o ya incluye circuitos.
- Toda formula nueva debe pasar el analyzer estricto (`--fatal-infos`) y la
  suite. Las guardas de rutas y widget mapper deben comprobar que cada pantalla
  nueva se construye sin excepciones; contar iteraciones despues de descartar
  errores no constituye una prueba.
- No declarar una formula o lote como verificado sin fuente, derivacion y prueba
  reproducible conservadas en el repositorio.
- Los graficos importados exigen cumplimiento de licencia; sin verificacion no se
  publican.
- La app es dark-only hoy; cualquier grafico debe leerse sobre fondo oscuro o
  traer variante clara.

## Como se implementa contenido nuevo

El flujo verificado esta en la guia de integracion de secciones (patron de
pantalla, rutas, favoritos, widget mapper, busqueda, l10n ES/EN, menus). El
gating Pro-only es por carpeta: nada se agrega a `community/`.
