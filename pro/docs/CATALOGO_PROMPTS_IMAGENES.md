# Catalogo de prompts de imagenes - Formulae

## Proposito

Este catalogo reune los prompts para **regenerar las 176 imagenes canónicas** de
Formulae Pro y Formulae Community. El host historico `capdesis.com` devuelve 404; ambas apps ya usan
`formulaeapps.com`, donde las rutas deben verificarse de nuevo despues de poblar
la landing. Cada imagen debe producirse como **PNG** (salvo las dos variantes
`.jpg` explicitamente marcadas en Preguntas frecuentes) con **fondo solido navy
#27283D**.

> **Regla no negociable de internacionalización:** hay una sola imagen por
> concepto, bajo `https://formulaeapps.com/imagenes/...`, para todos los
> idiomas presentes y futuros. El bitmap no puede contener palabras, títulos,
> frases, leyendas, texto de interfaz ni valores lógicos `V`/`F` o `T`/`F`.
> Conserva únicamente notación matemática y científica universal: variables,
> unidades, flechas, polaridades, fórmulas, símbolos y valores `0`/`1`. Las
> explicaciones se muestran como texto localizado en Flutter. No generar ni
> publicar variantes bajo `imagenes_ingles/`. Los logotipos oficiales Formulae
> y CAPDESIS son una excepción de identidad fija, no texto pedagógico
> localizado, y sólo se mantienen en sus assets de marca.
>
> Esta regla prevalece sobre cualquier redacción histórica de los prompts
> individuales: si una fila menciona título, nombre, etiqueta, botón, captura
> o una frase entre comillas, se entiende solo como contexto pedagógico y no
> como texto que deba aparecer dentro de la imagen.

> **Uso seguro de los prompts históricos:** las filas de este catálogo no se
> deben copiar aisladas a un generador. Algunas conservan descripciones de UI,
> pasos y etiquetas de la aplicación anterior. Antes de generar, combina la
> fila con la regla no negociable anterior y exige explícitamente un pictograma
> o diagrama sin palabras, botones, teclados, capturas ni texto de sistema
> operativo. Si el propósito es explicar una acción de UI, representa solo el
> icono universal, la relación espacial o el estado visual abstracto; la
> explicación localizada se queda en los ARB/widgets. Rechaza cualquier salida
> que incumpla esto, aunque la fila histórica pida una captura concreta.

### Correcciones por consumidor real

El widget Flutter que consume una ruta es la fuente de verdad cuando contradice
un prompt histórico. Las siguientes rutas se regeneraron según su uso efectivo
en la app y no deben volver a interpretarse con la redacción anterior:

- `corriente_en_el_capacitor{,_1}` y
  `diferencia_de_potencial_en_el_capacitor{,_1}` son las cuatro gráficas de
  carga y descarga RC, con sus ecuaciones universales.
- `no_polarizado`, `polarizado` y `polarizacion` representan dipolos de un
  dieléctrico, no iconos de capacitores.
- `fuerza_de_lorentz` cubre tanto `F=qv×B` como `F=Iℓ×B`.
- `nomenclatura_basica_1` y `nomenclatura_basica_2` son láminas de componentes
  de circuito genéricos, no diagramas de transformadores.
- `ley_de_biot_savart_1` muestra una carga móvil; la variante `_2` conserva el
  elemento de corriente.
- `representacion_de_los_vectores_electricos` muestra `D`, `E` y `P` en un
  capacitor con dieléctrico.
- `grafica_capacitancia` representa la relación lineal `Q=CV`.

Antes de regenerar cualquier otro asset, confirma el widget consumidor y deja
la explicación verbal en los ARB/widgets localizados.

El hospedaje es en **Hostinger**, sirviendo los archivos desde la carpeta `landing/public/imagenes/` del repositorio de la landing. En produccion la app los consume desde `https://formulaeapps.com/imagenes/<path>`, donde `<path>` es la ruta relativa indicada en la columna **path** de cada tabla (identica a la parte final de **target** despues de `landing/public/imagenes/`). La promoción no se hace desde este catálogo: sigue los controles de [despliegue autorizado](../../docs/DEPLOY_CI_WEB.md).

## Estilo de fondo (DECISION, aplica a TODO el catalogo)

Formulae Pro es **dark-only**. En móvil la imagen se dibuja con
`BoxFit.contain` **directamente sobre el fondo navy `#27283D`** de la app (el
constante `kColorFondo`); no hay tarjeta blanca detras. El objetivo es que la
imagen se funda con la pantalla, como si no tuviera borde de fondo.

- **Fondo por defecto: RELLENO SOLIDO navy `#27283D`** (exactamente el color de
  fondo de la app). Esta es la opcion recomendada y la mas robusta.
  - **Por que solido y no transparente**: los generadores de imagenes suelen
    "hornear" el patron de rejilla de ajedrez (el que representa transparencia)
    como pixeles reales, o entregan un canal alfa sucio con halos. Un relleno
    solido del MISMO color del fondo se ve identico a transparente sobre la app,
    sin ese riesgo, y funciona en cualquier generador. Por eso los prompts de
    abajo piden `fondo solido navy #27283D`.
  - Trazos y símbolos en **colores claros** que lean sobre navy: lineas
    off-white `#E8E8F0`; acentos con moderacion (dorado `#F3A73D`, teal
    `#3AC0C9`, rojo `#FF6B6B` para carga positiva/sentido, azul `#6BA9FF` para
    carga negativa/campo).
- **Opcional (solo si tu herramienta produce alfa limpio de verdad)**: PNG con
  fondo **transparente real**, sin rejilla ni halos. Si hay CUALQUIER duda o el
  resultado muestra la rejilla de ajedrez, usa el relleno solido navy. Nunca
  uses fondo blanco: se veria como una tarjeta blanca sobre el tema oscuro.
- **JPG**: las 2 variantes `.jpg` de Preguntas frecuentes no soportan alfa;
  van siempre con **fondo solido navy `#27283D`**.
- **Resolucion**: 1024x768 (4:3) o 1024x1024 cuadrado segun indique el prompt;
  puedes exportar al doble (2048x1536 / 2048x2048) para nitidez retina.
- **Validacion**: tras generar, verifica que el fondo sea navy `#27283D` liso
  (o alfa limpio), sin rejilla, y que trazos/símbolos se lean con claridad
  sobre navy.

## Instrucciones para el operador

1. Verifica primero el widget consumidor real y su layout; no generes desde una fila sin confirmar cómo se muestra en la app a 320 px y en escritorio.
2. Toma la ruta **target** y el contexto de la fila, pero aplica siempre el bloque de uso seguro y la regla no negociable de internacionalización de arriba.
3. Corre el prompt compuesto en tu IA de imágenes preferida (1024x768 4:3 o 1024x1024 cuando corresponda) y rechaza una salida que incluya texto natural, UI localizada o una captura dependiente de plataforma.
4. Guarda el resultado exactamente en la ruta **target** indicada, respetando subcarpetas, nombre y extensión (`.png`, o `.jpg` donde se especifique), y ejecuta `cd landing && bun run check:formulae-images` antes de aceptarlo.
5. Revisa visualmente el asset en su pantalla consumidora. Solo después de la revisión local y de una promoción autorizada según [DEPLOY_CI_WEB.md](../../docs/DEPLOY_CI_WEB.md), ejecuta el smoke remoto; no subas directamente a Hostinger desde esta guía.
6. Los activos de marca (Google Play badge, logos CAPDESIS) e iconos de sistema **no deben generarse con IA**: usa los archivos oficiales o iconos del sistema de diseño segun indica cada prompt (marcados como placeholder).

## Especificacion de estilo comun

### Diagramas tecnicos (electricidad, geometria, discretas, trigonometria)

> Estilo obligatorio para todas: diagrama tecnico 2D limpio tipo libro de texto de ingenieria. Formato PNG, fondo solido navy #27283D, resolucion 1024x768 (relacion 4:3) salvo indicacion cuadrada. Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para carga positiva y sentido de referencia, azul para carga negativa y campo, gris para conductores/metal). Flat, sin sombras 3D, sin fotorrealismo. No incluir texto natural ni tipografia de idioma. Solo símbolos fisico-matematicos universales correctos (vectores con flecha, subindices, unidades y fórmulas). CRITICO: correccion tecnica; fisica, topologia de circuito, sentido de campo y geometria exactos; nada inventado ni decorativo que confunda.

La seccion de **Geometria** aplica la misma base con este matiz de color: 

> Formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3, o cuadrado si la figura lo pide). Estilo diagrama tecnico 2D limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (azul para magnitudes/dimensiones, rojo para vertices o elementos destacados, gris claro para relleno neutro). Flat, sin sombras 3D, sin degradados fotorrealistas. No incluir texto natural. Usar solo símbolos matematicos correctos (subindices, exponentes, letras griegas, dimensiones y fórmulas). CRITICO: correccion geometrica y matematica exacta.

### Pictogramas de FAQ

> No usar capturas de interfaz, sistema operativo o navegador: envejecen y contienen texto dependiente del idioma. Para FAQ usa un pictograma plano 2D, fondo solido navy #27283D, lineas off-white nitidas y acentos moderados (dorado #F3A73D, azul para estado activo, rojo para error, verde para exito). No incluir tipografía, palabras ni números culturalmente localizados. Las instrucciones completas se muestran en widgets Flutter localizados.

---

## Electricidad y magnetismo (124 imagenes)

### `electricidad_y_magnetismo/analogia_con_campo_electrico.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/analogia_con_campo_electrico.png`
- **Descripcion:** Analogia entre el campo gravitatorio de una masa y el campo electrico de una carga puntual, mostrando lineas de campo radiales en ambos.
- **Prompt:**

  > Diagrama comparativo lado a lado que ilustra la ANALOGIA entre el campo gravitatorio y el campo electrico. Panel izquierdo: una masa esferica M al centro con lineas de campo rectas apuntando radialmente HACIA la masa (flechas entrantes en gris/negro), etiqueta 'Campo gravitatorio g' y una masa de prueba m con vector de fuerza F=mg dirigido hacia M. Panel derecho: una carga puntual positiva +Q (punto rojo) al centro con lineas de campo radiales SALIENDO de la carga (flechas salientes en rojo), etiqueta 'Campo electrico E' y una carga de prueba +q con vector de fuerza F=qE alejandose. Ambos paneles simetricos para resaltar el paralelismo (ambos campos ~1/r^2). Sin texto natural; usar solo simbolos universales. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, acentos rojo=carga positiva y azul=campo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, simbolos con flecha y subindices correctos. Correccion tecnica critica: el campo gravitatorio siempre atractivo (flechas entrantes), el electrico de carga positiva saliente.

### `electricidad_y_magnetismo/analogia_con_campo_electrico_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/analogia_con_campo_electrico_1.png`
- **Descripcion:** Variante de la analogia campo gravitatorio-campo electrico, enfocada en la ley del inverso del cuadrado con las expresiones de fuerza.
- **Prompt:**

  > Diagrama tecnico que refuerza la ANALOGIA entre gravitacion y electrostatica mediante sus formulas y geometria. A la izquierda dos masas m1 y m2 separadas una distancia r sobre una linea, con vectores de fuerza de atraccion apuntando una hacia la otra y la etiqueta de la ley de gravitacion F = G m1 m2 / r^2. A la derecha dos cargas puntuales, una +q1 (rojo) y otra +q2 (rojo) separadas la misma distancia r, con vectores de fuerza de REPULSION apuntando en sentidos opuestos y la etiqueta de la ley de Coulomb F = k q1 q2 / r^2. Flecha central o llave que indica 'misma forma matematica ~1/r^2'. Sin texto natural; usar solo simbolos universales. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=carga positiva, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: dos cargas positivas se REPELEN (fuerzas divergentes), dos masas se ATRAEN (fuerzas convergentes).

### `electricidad_y_magnetismo/bobina.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/bobina.png`
- **Descripcion:** Bobina (inductor): conductor arrollado en espiras helicoidales con sus dos terminales.
- **Prompt:**

  > Diagrama tecnico de una BOBINA (inductor) real: un alambre conductor arrollado en varias espiras helicoidales regulares e iguales alrededor de un eje horizontal, formando un cilindro de vueltas, con los dos extremos del alambre saliendo como terminales rectas a izquierda y derecha para conexion. Vueltas dibujadas como lazos parcialmente solapados vistos de lado (estilo esquematico de solenoide). Sin texto natural; usar solo simbolos universales: 'Bobina' o 'Inductor', simbolo L, y opcionalmente 'N espiras'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas (conductor en gris metalico), relleno minimo, flat sin sombras 3D ni fotorrealismo, sans-serif legible. Correccion tecnica critica: espiras uniformes en el mismo sentido de arrollamiento y ambos terminales continuos con el alambre.

### `electricidad_y_magnetismo/campo_electrico.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/campo_electrico.png`
- **Descripcion:** Concepto de campo electrico: vector E en un punto del espacio generado por una carga fuente, actuando sobre una carga de prueba.
- **Prompt:**

  > Diagrama conceptual del CAMPO ELECTRICO. Una carga fuente positiva +Q (punto rojo) a la izquierda. En un punto P del espacio a la derecha, dibujar el vector campo electrico E como flecha (color azul) que apunta radialmente alejandose de +Q, con etiqueta E en notacion vectorial. Colocar una pequena carga de prueba +q0 en P y su vector fuerza F = q0 E en la misma direccion que E, mostrando la relacion E = F/q0. Linea punteada de referencia entre Q y P indicando la distancia r. Sin texto natural; usar solo simbolos universales. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=carga positiva y azul=vector campo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, vectores con flecha y subindices correctos. Correccion tecnica critica: E y F paralelos para carga de prueba positiva; E apunta lejos de la carga fuente positiva.

### `electricidad_y_magnetismo/campo_electrico_de_una_carga_puntual.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/campo_electrico_de_una_carga_puntual.png`
- **Descripcion:** Campo electrico radial de una carga puntual positiva, con lineas de campo saliendo simetricamente en todas direcciones.
- **Prompt:**

  > Diagrama del CAMPO ELECTRICO DE UNA CARGA PUNTUAL. Una carga puntual positiva +q (punto rojo) en el centro. Ocho o doce lineas de campo rectas distribuidas uniformemente en todas direcciones, saliendo radialmente de la carga con puntas de flecha apuntando hacia afuera (color rojo/negro). En una de las lineas, en un punto a distancia r, dibujar el vector E tangente (radial) con su etiqueta y la formula E = k q / r^2. Sin texto natural; usar solo simbolos universales: '+q', 'E', 'r'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, imagen preferentemente cuadrada 1024x1024 por la simetria radial, Lineas claras off-white nitidas, relleno minimo, rojo=carga positiva, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices y exponentes correctos. Correccion tecnica critica: lineas perfectamente radiales y equiespaciadas, flechas SALIENDO (carga positiva), simetria puntual.

### `electricidad_y_magnetismo/campo_electrico_de_una_linea_infinita.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/campo_electrico_de_una_linea_infinita.png`
- **Descripcion:** Campo electrico de una linea de carga infinita: lineas de campo radiales perpendiculares al hilo, simetria cilindrica.
- **Prompt:**

  > Diagrama del CAMPO ELECTRICO DE UNA LINEA DE CARGA INFINITA. Un hilo recto horizontal (o vertical) largo con densidad lineal de carga positiva lambda (signos + distribuidos a lo largo, en rojo), extendiendose fuera del marco por ambos extremos con puntos suspensivos que sugieren longitud infinita. Lineas de campo electrico RADIALES perpendiculares al hilo, saliendo en el plano transversal en forma de estrella alrededor del hilo, con flechas hacia afuera (azul/negro). Indicar el radio r desde el hilo hasta un punto y el vector E perpendicular al hilo con la formula E = lambda / (2 pi epsilon0 r). Sin texto natural; usar solo simbolos universales: 'lambda', 'E', 'r'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=carga positiva y azul=campo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, simbolos griegos y subindices correctos. Correccion tecnica critica: campo perpendicular al hilo y decreciente ~1/r, simetria cilindrica.

### `electricidad_y_magnetismo/campo_magnetico.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/campo_magnetico.png`
- **Descripcion:** Campo magnetico de un iman de barra: lineas de campo cerradas que salen del polo N y entran al polo S.
- **Prompt:**

  > Diagrama del CAMPO MAGNETICO de un iman de barra. Un iman rectangular horizontal con polo NORTE (N) a la derecha en rojo y polo SUR (S) a la izquierda en azul. Lineas de campo magnetico B como curvas cerradas continuas que SALEN del polo N, se arquean por encima y por debajo del iman y ENTRAN al polo S, con puntas de flecha indicando el sentido (de N a S por fuera). Mas densidad de lineas cerca de los polos. Etiqueta del vector B en una linea y letras N y S en los polos. Sin texto natural; usar solo simbolos universales. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=polo norte y azul=polo sur, flat sin sombras 3D ni fotorrealismo, sans-serif legible, vector con flecha. Correccion tecnica critica: lineas de campo cerradas (nunca terminan en el aire), sentido de N a S por el exterior del iman.

### `electricidad_y_magnetismo/capacitor_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/capacitor_1.png`
- **Descripcion:** Capacitor de placas paralelas cargado: placa positiva y negativa con carga +Q y -Q enfrentadas.
- **Prompt:**

  > Diagrama de un CAPACITOR de placas paralelas cargado. Dos placas conductoras rectangulares paralelas y verticales, separadas una distancia d. La placa izquierda con carga positiva +Q (signos + rojos distribuidos en su cara interna), la placa derecha con carga negativa -Q (signos - azules en su cara interna). Terminales que salen de cada placa hacia una fuente. Sin texto natural; usar solo simbolos universales: '+Q', '-Q', 'd' para la separacion, 'A' para el area de placa. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white/gris (placas en gris metalico) nitidas, relleno minimo, rojo=carga positiva y azul=negativa, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: cargas iguales y opuestas en magnitud enfrentadas en las caras internas.

### `electricidad_y_magnetismo/capacitor_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/capacitor_2.png`
- **Descripcion:** Capacitor de placas paralelas mostrando el campo electrico uniforme entre placas.
- **Prompt:**

  > Diagrama de un CAPACITOR de placas paralelas resaltando el CAMPO ELECTRICO INTERNO. Dos placas conductoras paralelas verticales separadas distancia d, la izquierda positiva +Q (signos + rojos), la derecha negativa -Q (signos - azules). Entre las placas, varias lineas de campo electrico E rectas, paralelas, uniformemente espaciadas y horizontales, apuntando de la placa positiva a la negativa (flechas azules). Sin texto natural; usar solo simbolos universales: 'E' (campo uniforme), '+Q', '-Q', 'd', y relacion V = E d. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=carga positiva y azul=campo/negativa, flat sin sombras 3D ni fotorrealismo, sans-serif legible. Correccion tecnica critica: campo interior uniforme y paralelo, dirigido de la placa + a la placa -.

### `electricidad_y_magnetismo/capacitor_de_placas_planas_y_paralelas.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/capacitor_de_placas_planas_y_paralelas.png`
- **Descripcion:** Capacitor de placas planas y paralelas con area A, separacion d, campo uniforme y formula de capacitancia.
- **Prompt:**

  > Diagrama detallado de un CAPACITOR DE PLACAS PLANAS Y PARALELAS. Dos placas conductoras rectangulares planas identicas, paralelas, de area A cada una, separadas una distancia d pequena frente a sus dimensiones. Placa superior/izquierda con +Q (signos + rojos en cara interna), placa inferior/derecha con -Q (signos - azules). Entre ellas campo electrico E uniforme (lineas rectas paralelas con flechas de + a -). Acotaciones: 'A' (area de la placa), 'd' (separacion). Incluir la formula de la capacitancia C = epsilon0 A / d. Sin texto natural; usar solo simbolos universales. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white/gris (placas grises) nitidas, relleno minimo, rojo=carga positiva y azul=campo/negativa, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices y simbolos griegos correctos. Correccion tecnica critica: C = epsilon0 A / d, campo uniforme, placas identicas y paralelas.

### `electricidad_y_magnetismo/carga_de_un_capacitor.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/carga_de_un_capacitor.png`
- **Descripcion:** Proceso de carga de un capacitor en circuito RC: bateria, resistor, capacitor y curva exponencial de carga.
- **Prompt:**

  > Diagrama de la CARGA DE UN CAPACITOR en un circuito RC serie. Parte izquierda: circuito esquematico con una fuente de tension continua V (bateria, simbolo de lineas larga/corta), un interruptor, un resistor R (rectangulo o zigzag) y un capacitor C (dos lineas paralelas), todos en serie formando un lazo; el capacitor mostrando +q y -q en formacion. Parte derecha: grafica cartesiana con eje horizontal tiempo t y eje vertical carga q(t) (o voltaje), mostrando una curva de crecimiento EXPONENCIAL que parte de 0 y se satura asintoticamente hacia el valor final Qmax = C V; marcar la constante de tiempo tau = R C en el eje t. Sin texto natural; usar solo simbolos universales: 'V', 'R', 'C', 'q(t)', 'tau = RC', formula q(t) = C V (1 - e^{-t/RC}). Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar, relleno minimo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices y exponentes correctos. Correccion tecnica critica: curva monotona creciente saturante (no lineal), topologia RC serie correcta.

### `electricidad_y_magnetismo/carga_puntual.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/carga_puntual.png`
- **Descripcion:** Representacion de una carga puntual: un punto con su valor de carga q en el espacio.
- **Prompt:**

  > Diagrama simple de una CARGA PUNTUAL. Un unico punto pequeno y solido (esfera idealizada) situado en el espacio, coloreado en rojo con un signo + en su interior, etiquetado 'q' o '+q'. Opcionalmente un sistema de ejes o un vector de posicion r desde un origen O hasta la carga para ubicarla. Amplio margen (espacio negativo) alrededor de la carga sobre el fondo navy. Sin texto natural; usar solo simbolos universales. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=carga positiva, flat sin sombras 3D ni fotorrealismo, sans-serif legible, vector de posicion con flecha si se incluye. Correccion tecnica critica: representar una carga idealizada de tamano despreciable (un punto), sin geometria extendida.

### `electricidad_y_magnetismo/cargas_puntuales.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/cargas_puntuales.png`
- **Descripcion:** Sistema de varias cargas puntuales (positivas y negativas) distribuidas en el plano con sus distancias.
- **Prompt:**

  > Diagrama de un SISTEMA DE CARGAS PUNTUALES. Tres o cuatro cargas puntuales dispuestas en el plano: dos positivas (+q1, +q2 en rojo con signo +) y una o dos negativas (-q3 en azul con signo -). Lineas punteadas de referencia que unen los pares de cargas indicando las distancias r12, r13, etc. Cada carga como punto solido con su etiqueta. Opcionalmente indicar el vector fuerza sobre una carga como suma de contribuciones. Sin texto natural; usar solo simbolos universales con subindices. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=carga positiva y azul=negativa, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: distancias correctamente rotuladas entre pares, signos de carga consistentes con sus colores.

### `electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo.png`
- **Descripcion:** Circuito RC alimentado por voltaje continuo: fuente DC, resistor y capacitor en serie con interruptor.
- **Prompt:**

  > Esquema de un CIRCUITO RC CON VOLTAJE CONTINUO. Lazo cerrado con: una fuente de tension continua V (simbolo de bateria, linea larga = +, linea corta = -), un interruptor S, un resistor R en serie y un capacitor C en serie, todos conectados con conductores rectos en angulos rectos. Marcar la polaridad de la fuente, la corriente i con una flecha de sentido de referencia y las cargas +q/-q en las placas del capacitor. Sin texto natural; usar solo simbolos universales: 'V', 'S', 'R', 'C', 'i'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar (IEC), relleno minimo, rojo para el sentido de referencia de la corriente, flat sin sombras 3D ni fotorrealismo, sans-serif legible. Correccion tecnica critica: topologia serie correcta (fuente-interruptor-R-C en un solo lazo), simbolos normalizados, polaridad coherente.

### `electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo_1.png`
- **Descripcion:** Circuito RC con voltaje continuo, variante enfocada en la etapa de carga (interruptor a la posicion de la fuente).
- **Prompt:**

  > Esquema de un CIRCUITO RC CON VOLTAJE CONTINUO en fase de CARGA. Lazo con fuente de tension continua V, interruptor en la posicion que conecta la fuente, resistor R en serie y capacitor C. Mostrar la corriente de carga i con flecha saliendo del terminal + de la fuente hacia la placa positiva del capacitor, y las cargas +q/-q acumulandose. Anadir junto al esquema la ecuacion de malla de Kirchhoff V = i R + q/C. Sin texto natural; usar solo simbolos universales: 'V', 'R', 'C', 'i', '+q', '-q'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar, relleno minimo, rojo=sentido de referencia de corriente y carga positiva, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: ecuacion de malla V = iR + q/C correcta, sentido de corriente coherente con la carga del capacitor.

### `electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/circuito_rc_y_voltaje_continuo_2.png`
- **Descripcion:** Circuito RC con voltaje continuo, variante de descarga: capacitor descargandose a traves del resistor.
- **Prompt:**

  > Esquema de un CIRCUITO RC CON VOLTAJE CONTINUO en fase de DESCARGA. Lazo cerrado formado solo por el capacitor C (inicialmente cargado con +q/-q) y el resistor R, con el interruptor en la posicion que desconecta la fuente y cierra el lazo R-C. Mostrar la corriente de descarga i con flecha en el sentido que sale de la placa positiva del capacitor hacia R (sentido opuesto al de carga). Incluir la ecuacion R i + q/C = 0 y la solucion q(t) = Q0 e^{-t/RC}. Sin texto natural; usar solo simbolos universales: 'R', 'C', 'i', 'q(t)', 'tau = RC'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar, relleno minimo, rojo=sentido de corriente, flat sin sombras 3D ni fotorrealismo, sans-serif legible, exponentes/subindices correctos. Correccion tecnica critica: durante la descarga la fuente esta desconectada, corriente en sentido inverso al de carga, decaimiento exponencial.

### `electricidad_y_magnetismo/circulacion_de_un_campo_vectorial.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/circulacion_de_un_campo_vectorial.png`
- **Descripcion:** Circulacion de un campo vectorial: integral de linea de F a lo largo de una trayectoria cerrada orientada.
- **Prompt:**

  > Diagrama de la CIRCULACION DE UN CAMPO VECTORIAL. Un campo vectorial F representado por un conjunto de flechas distribuidas en el plano (por ejemplo un patron ligeramente rotacional o uniforme, en azul). Superpuesta, una trayectoria cerrada C (curva ovalada o poligonal) con una flecha que indica el sentido de recorrido (antihorario). En un punto de la curva, mostrar el elemento diferencial de longitud dl tangente a la trayectoria y el vector de campo F en ese punto, resaltando el producto escalar F . dl. Incluir la notacion de la integral cerrada de circulacion: circulacion = integral cerrada de F . dl. Sin texto natural; usar solo simbolos universales: 'F', 'C', 'dl'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, azul=vectores de campo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, vectores con flecha. Correccion tecnica critica: dl tangente a la curva, sentido de recorrido indicado, notacion de integral de linea cerrada correcta.

### `electricidad_y_magnetismo/circulacion_para_una_carga_puntual.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/circulacion_para_una_carga_puntual.png`
- **Descripcion:** Circulacion del campo electrico de una carga puntual a lo largo de una trayectoria cerrada (resultado nulo, campo conservativo).
- **Prompt:**

  > Diagrama de la CIRCULACION DEL CAMPO ELECTRICO DE UNA CARGA PUNTUAL. Una carga puntual positiva +q (punto rojo) con sus lineas de campo radiales salientes (azul/negro). Superpuesta una trayectoria cerrada C (lazo) que rodea o pasa cerca de la carga, con flecha de sentido de recorrido. En puntos de la curva, mostrar el campo E radial y el elemento dl tangente, ilustrando el producto E . dl. Incluir el resultado clave: la integral cerrada de E . dl = 0 (campo electrostatico conservativo). Sin texto natural; usar solo simbolos universales: '+q', 'E', 'dl', 'C'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=carga positiva y azul=campo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, vectores con flecha e integral cerrada correcta. Correccion tecnica critica: el resultado de la circulacion del campo electrostatico es CERO por ser conservativo; campo radial desde la carga.

### `electricidad_y_magnetismo/conductividad_y_resistividad.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conductividad_y_resistividad.png`
- **Descripcion:** Conductor cilindrico de longitud L y area A con densidad de corriente J y campo E, ilustrando resistividad/conductividad.
- **Prompt:**

  > Diagrama de CONDUCTIVIDAD Y RESISTIVIDAD. Un conductor cilindrico (o prisma) horizontal de longitud L y area de seccion transversal A, mostrado en gris metalico. En su interior, flechas paralelas que representan la densidad de corriente J y el campo electrico E, ambos apuntando en el mismo sentido a lo largo del eje (de mayor a menor potencial). Terminales en los extremos conectados a una fuente que impulsa la corriente I. Acotaciones 'L' (longitud) y 'A' (seccion). Incluir relaciones: J = sigma E, resistividad rho = 1/sigma, y R = rho L / A. Sin texto natural; usar solo simbolos universales: 'L', 'A', 'J', 'E', 'sigma', 'rho'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white/gris (conductor gris) nitidas, relleno minimo, azul=campo E y flechas de J, flat sin sombras 3D ni fotorrealismo, sans-serif legible, simbolos griegos y subindices correctos. Correccion tecnica critica: J y E paralelos (J = sigma E), R = rho L / A, rho = 1/sigma.

### `electricidad_y_magnetismo/conexion_en_paralelo_carga_diferencia_de_potencial_capacitancia_equivalente.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_paralelo_carga_diferencia_de_potencial_capacitancia_equivalente.png`
- **Descripcion:** Capacitores en paralelo: misma diferencia de potencial, las cargas se suman, capacitancia equivalente Ceq = C1+C2+...
- **Prompt:**

  > Esquema de CAPACITORES EN PARALELO. Tres capacitores C1, C2, C3 (cada uno dos lineas paralelas) conectados en PARALELO entre dos nodos/barras horizontales comunes, alimentados por una fuente de tension V. Resaltar que TODOS soportan la MISMA diferencia de potencial V, y que las cargas se reparten q1, q2, q3 sumandose: q_total = q1 + q2 + q3. Incluir la formula de la capacitancia equivalente Ceq = C1 + C2 + C3. Al lado, un capacitor equivalente Ceq con la misma V y carga total. Sin texto natural; usar solo simbolos universales: 'C1', 'C2', 'C3', 'V', 'q1..q3', 'Ceq = C1+C2+C3'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar, relleno minimo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: en paralelo la TENSION es comun y las capacitancias SE SUMAN (Ceq = suma de Ci).

### `electricidad_y_magnetismo/conexion_en_paralelo_corriente_diferencia_de_potencial_resistencia_equivalente.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_paralelo_corriente_diferencia_de_potencial_resistencia_equivalente.png`
- **Descripcion:** Resistores en paralelo: misma diferencia de potencial, las corrientes se suman, 1/Req = 1/R1+1/R2+...
- **Prompt:**

  > Esquema de RESISTORES EN PARALELO. Tres resistores R1, R2, R3 (rectangulos IEC o zigzag) conectados en PARALELO entre dos nodos comunes alimentados por una fuente V. La corriente total I entra a un nodo y se divide en I1, I2, I3 (una por rama, flechas rojas de sentido), reuniendose en el otro nodo: I = I1 + I2 + I3. Todos los resistores soportan la MISMA diferencia de potencial V. Incluir la formula de la resistencia equivalente 1/Req = 1/R1 + 1/R2 + 1/R3. Sin texto natural; usar solo simbolos universales: 'R1', 'R2', 'R3', 'V', 'I', 'I1..I3'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar, relleno minimo, rojo=corrientes, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: en paralelo la TENSION es comun y las corrientes se suman; 1/Req = suma de 1/Ri (Req menor que la menor resistencia).

### `electricidad_y_magnetismo/conexion_en_paralelo_fisico.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_paralelo_fisico.png`
- **Descripcion:** Representacion fisica (pictorica) de una conexion en paralelo: componentes reales conectados entre dos barras comunes.
- **Prompt:**

  > Ilustracion FISICA (pictorica, no solo simbolica) de una CONEXION EN PARALELO. Mostrar componentes reales estilizados (por ejemplo tres resistores dibujados como cuerpos cilindricos con bandas, o tres bombillas/elementos) conectados con cables entre DOS barras conductoras horizontales comunes (una superior y una inferior), de modo que cada componente forma una rama independiente entre las mismas dos barras. Una bateria real conectada a las barras. Resaltar visualmente que cada componente tiene sus dos terminales en las mismas dos barras (mismos nodos). Sin texto natural; usar solo simbolos universales: 'conexion en paralelo', y opcionalmente los componentes. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, componentes en gris con acentos moderados, relleno minimo, flat sin sombras 3D ni fotorrealismo, sans-serif legible. Correccion tecnica critica: todas las ramas comparten los mismos dos nodos (barras), configuracion paralela real.

### `electricidad_y_magnetismo/conexion_en_paralelo_inductor.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_paralelo_inductor.png`
- **Descripcion:** Inductores en paralelo con su formula de inductancia equivalente 1/Leq = 1/L1+1/L2+...
- **Prompt:**

  > Esquema de INDUCTORES EN PARALELO. Tres inductores L1, L2, L3 (simbolo de bobina: serie de semicirculos/lazos) conectados en PARALELO entre dos nodos comunes, alimentados por una fuente. Todos con la misma tension entre terminales. Incluir la formula de la inductancia equivalente 1/Leq = 1/L1 + 1/L2 + 1/L3 (sin acoplamiento mutuo). Sin texto natural; usar solo simbolos universales: 'L1', 'L2', 'L3', 'Leq'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolo de inductor estandar (bobina), relleno minimo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: en paralelo 1/Leq = suma de 1/Li (analogo a resistores en paralelo).

### `electricidad_y_magnetismo/conexion_en_paralelo_resistor.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_paralelo_resistor.png`
- **Descripcion:** Resistores en paralelo (esquema simbolico) con la formula 1/Req = 1/R1+1/R2+...
- **Prompt:**

  > Esquema simbolico de RESISTORES EN PARALELO. Dos o tres resistores R1, R2 (R3) dibujados con el simbolo de rectangulo IEC, conectados en PARALELO entre dos nodos comunes (lineas verticales que unen un extremo de cada resistor arriba y el otro extremo abajo). Incluir la formula de la resistencia equivalente 1/Req = 1/R1 + 1/R2 + 1/R3 y, para dos resistores, la forma Req = R1 R2 / (R1 + R2). Sin texto natural; usar solo simbolos universales: 'R1', 'R2', 'R3', 'Req'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolo de resistor IEC estandar, relleno minimo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: 1/Req = suma de 1/Ri; para dos, Req = producto sobre suma.

### `electricidad_y_magnetismo/conexion_en_paralelo_simbologia.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_paralelo_simbologia.png`
- **Descripcion:** Simbologia generica de una conexion en paralelo: elementos genericos entre dos nodos comunes.
- **Prompt:**

  > Diagrama de SIMBOLOGIA de la CONEXION EN PARALELO. Mostrar de forma generica dos o tres elementos representados como rectangulos genericos rotulados 'Elemento 1', 'Elemento 2', 'Elemento 3' (o Z1, Z2, Z3), conectados en PARALELO entre dos nodos comunes A y B (dos lineas verticales que unen todos los extremos superiores en el nodo A y todos los inferiores en el nodo B). Indicar que la tension V entre A y B es comun a todos y que la corriente se reparte. Sin texto natural; usar solo simbolos universales: 'A', 'B', 'V', 'Z1', 'Z2', 'Z3'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos de nodo (puntos) estandar, relleno minimo, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: todos los elementos comparten los dos mismos nodos; misma tension entre A y B.

### `electricidad_y_magnetismo/conexion_en_serie_carga_diferencia_de_potencial_capacitancia_equivalente.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_serie_carga_diferencia_de_potencial_capacitancia_equivalente.png`
- **Descripcion:** Capacitores en serie: misma carga en todos, las tensiones se suman, 1/Ceq = 1/C1+1/C2+...
- **Prompt:**

  > Esquema de CAPACITORES EN SERIE. Tres capacitores C1, C2, C3 (cada uno dos lineas paralelas) conectados uno tras otro en un unico lazo con una fuente de tension V. Resaltar que TODOS tienen la MISMA carga q en sus placas (por induccion en serie) y que la tension total se REPARTE: V = V1 + V2 + V3. Incluir la formula de la capacitancia equivalente 1/Ceq = 1/C1 + 1/C2 + 1/C3. Sin texto natural; usar solo simbolos universales: 'C1', 'C2', 'C3', 'V', 'V1..V3', 'q', 'Ceq'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar, relleno minimo, rojo=carga positiva, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: en serie la CARGA es comun y 1/Ceq = suma de 1/Ci (Ceq menor que el menor Ci); las tensiones se suman.

### `electricidad_y_magnetismo/conexion_en_serie_corriente_diferencia_de_potencial_y_resistencia_equivalente.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_serie_corriente_diferencia_de_potencial_y_resistencia_equivalente.png`
- **Descripcion:** Resistores en serie: misma corriente, las tensiones se suman, Req = R1+R2+...
- **Prompt:**

  > Esquema de RESISTORES EN SERIE. Tres resistores R1, R2, R3 (rectangulos IEC) conectados uno tras otro en un unico lazo con una fuente de tension V. Una sola corriente I recorre todo el lazo (misma I en todos, flecha roja). La tension total se reparte en caidas V1 = I R1, V2 = I R2, V3 = I R3, con V = V1 + V2 + V3. Incluir la formula de la resistencia equivalente Req = R1 + R2 + R3. Sin texto natural; usar solo simbolos universales: 'R1', 'R2', 'R3', 'V', 'I', 'V1..V3', 'Req'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar, relleno minimo, rojo=corriente, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: en serie la CORRIENTE es comun y las resistencias SE SUMAN (Req = suma de Ri); las tensiones se reparten.

### `electricidad_y_magnetismo/conexion_en_serie_fisico.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_serie_fisico.png`
- **Descripcion:** Representacion fisica (pictorica) de una conexion en serie: componentes reales encadenados uno tras otro.
- **Prompt:**

  > Ilustracion FISICA (pictorica, no solo simbolica) de una CONEXION EN SERIE. Mostrar componentes reales estilizados (por ejemplo tres resistores como cuerpos cilindricos con bandas de colores, o tres bombillas) conectados uno TRAS otro formando una unica cadena: el terminal de salida de cada componente se une al terminal de entrada del siguiente, y los extremos de la cadena van a una bateria real, cerrando un solo lazo. Resaltar el camino unico de la corriente. Sin texto natural; usar solo simbolos universales: 'conexion en serie'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, componentes en gris con acentos moderados, relleno minimo, flat sin sombras 3D ni fotorrealismo, sans-serif legible. Correccion tecnica critica: un unico camino de corriente (cadena), sin nodos de derivacion; configuracion serie real.

### `electricidad_y_magnetismo/conexion_en_serie_inductor.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_serie_inductor.png`
- **Descripcion:** Inductores en serie con su formula de inductancia equivalente Leq = L1+L2+...
- **Prompt:**

  > Esquema de INDUCTORES EN SERIE. Tres inductores L1, L2, L3 (simbolo de bobina: semicirculos consecutivos) conectados uno tras otro en un unico lazo, recorridos por la misma corriente I. Incluir la formula de la inductancia equivalente Leq = L1 + L2 + L3 (sin acoplamiento mutuo). Sin texto natural; usar solo simbolos universales: 'L1', 'L2', 'L3', 'I', 'Leq'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolo de inductor estandar (bobina), relleno minimo, rojo=corriente, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: en serie las inductancias SE SUMAN (Leq = suma de Li), misma corriente en todos.

### `electricidad_y_magnetismo/conexion_en_serie_resistor.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_serie_resistor.png`
- **Descripcion:** Resistores en serie (esquema simbolico) con la formula Req = R1+R2+...
- **Prompt:**

  > Esquema simbolico de RESISTORES EN SERIE. Dos o tres resistores R1, R2 (R3) con simbolo de rectangulo IEC conectados uno a continuacion de otro en linea, formando un unico ramal por el que circula la misma corriente I. Incluir la formula de la resistencia equivalente Req = R1 + R2 + R3. Sin texto natural; usar solo simbolos universales: 'R1', 'R2', 'R3', 'I', 'Req'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolo de resistor IEC estandar, relleno minimo, rojo=corriente, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: Req = suma de Ri; unico camino de corriente.

### `electricidad_y_magnetismo/conexion_en_serie_simbologia.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/conexion_en_serie_simbologia.png`
- **Descripcion:** Simbologia generica de una conexion en serie: elementos genericos encadenados en un unico ramal.
- **Prompt:**

  > Diagrama de SIMBOLOGIA de la CONEXION EN SERIE. Mostrar de forma generica dos o tres elementos como rectangulos genericos rotulados 'Elemento 1', 'Elemento 2', 'Elemento 3' (o Z1, Z2, Z3) conectados uno tras otro en un unico ramal entre los nodos A y B, de modo que la salida de uno es la entrada del siguiente. Indicar que la corriente I es la MISMA a lo largo de todo el ramal y que la tension entre A y B es la suma de las caidas. Sin texto natural; usar solo simbolos universales: 'A', 'B', 'I', 'Z1', 'Z2', 'Z3'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo=corriente, flat sin sombras 3D ni fotorrealismo, sans-serif legible, subindices correctos. Correccion tecnica critica: unico camino, misma corriente en todos los elementos; las tensiones se suman.

### `electricidad_y_magnetismo/corriente_en_el_capacitor.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/corriente_en_el_capacitor.png`
- **Descripcion:** Corriente en un capacitor: relacion i = C dv/dt, con el capacitor, la tension aplicada y el sentido de corriente.
- **Prompt:**

  > Diagrama de la CORRIENTE EN EL CAPACITOR. Un capacitor C (dos lineas paralelas) con una tension variable v(t) aplicada entre sus terminales (marcada con polaridad + y -), y la corriente i entrando por la placa positiva (flecha roja de sentido de referencia asociada a la caida de tension). Mostrar las cargas +q y -q en las placas. Incluir de forma prominente la relacion constitutiva i = C dv/dt (la corriente es proporcional a la razon de cambio de la tension). Sin texto natural; usar solo simbolos universales: 'C', 'v(t)', 'i', '+q', '-q'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, simbolos electricos estandar, relleno minimo, rojo=sentido de corriente y carga positiva, flat sin sombras 3D ni fotorrealismo, sans-serif legible, notacion de derivada correcta. Correccion tecnica critica: relacion i = C dv/dt exacta; convencion de signos corriente-tension coherente (corriente entra por el terminal +).

### `electricidad_y_magnetismo/corriente_en_el_capacitor_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/corriente_en_el_capacitor_1.png`
- **Descripcion:** Variante grafica: relacion temporal entre la tension v(t) y la corriente i(t) en un capacitor (i proporcional a la pendiente de v).
- **Prompt:**

  > Diagrama con dos GRAFICAS apiladas que ilustran la CORRIENTE EN EL CAPACITOR i = C dv/dt. Grafica superior: tension v(t) en el capacitor frente al tiempo t, por ejemplo una rampa lineal creciente seguida de un tramo constante. Grafica inferior alineada en el mismo eje temporal: corriente i(t) resultante, que es CONSTANTE y positiva durante la rampa (pendiente constante de v) y CERO durante el tramo en que v es constante (pendiente nula). Ejes rotulados. Anotar la relacion i = C dv/dt y resaltar 'i proporcional a la pendiente de v'. Sin texto natural; usar solo simbolos universales: 'v(t)', 'i(t)', 't', 'C'. Estilo: diagrama tecnico 2D limpio tipo libro de texto, PNG fondo solido navy #27283D, 1024x768 (4:3), Lineas claras off-white nitidas, ejes y curvas claros, relleno minimo, un acento de color (azul) para la curva de corriente, flat sin sombras 3D ni fotorrealismo, sans-serif legible, notacion de derivada correcta. Correccion tecnica critica: la corriente es proporcional a la PENDIENTE de v(t); en v constante la corriente es cero; alineacion temporal exacta entre ambas graficas.

### `electricidad_y_magnetismo/diferencia_de_potencial_en_el_capacitor.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/diferencia_de_potencial_en_el_capacitor.png`
- **Descripcion:** Diferencia de potencial entre las placas de un capacitor cargado.
- **Prompt:**

  > Diagrama tecnico de un capacitor de placas planas paralelas cargado. Dos placas metalicas grises verticales enfrentadas y separadas una distancia d; la placa izquierda con carga +Q (signos + en rojo) y la derecha con carga -Q (signos - en azul). Entre las placas, lineas de campo electrico rectas y paralelas horizontales dirigidas de la placa positiva a la negativa, etiquetadas E con flecha vector. A la izquierda un terminal marcado V+ y a la derecha V-, con una llave que indica la diferencia de potencial V entre placas y la relacion V = Q/C. Etiquetas d (separacion) y +Q, -Q. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo para carga positiva y azul para negativa, gris para las placas conductoras, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha y subindices correctos. Correccion tecnica estricta: el campo va de + a -.

### `electricidad_y_magnetismo/diferencia_de_potencial_en_el_capacitor_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/diferencia_de_potencial_en_el_capacitor_1.png`
- **Descripcion:** Curva de la diferencia de potencial de un capacitor cargandose en el tiempo.
- **Prompt:**

  > Grafica tecnica de la diferencia de potencial de un capacitor durante su carga en un circuito RC. Ejes cartesianos: eje horizontal etiquetado t (tiempo), eje vertical etiquetado V (diferencia de potencial). Curva exponencial creciente que parte del origen y se aproxima asintoticamente a un valor final marcado con linea punteada horizontal V_max (o V_f = fem). Marca en el eje t la constante de tiempo tau = RC donde la curva alcanza ~63% de V_max. Ecuacion junto a la curva: V(t) = V_max (1 - e^(-t/RC)). Curva en negro, asintota punteada gris, eje limpio con flechas. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, subindices y exponentes correctos. Correccion tecnica estricta: curva de carga (concava hacia abajo, monotona creciente, asintotica).

### `electricidad_y_magnetismo/disco_con_carga_uniforme.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/disco_con_carga_uniforme.png`
- **Descripcion:** Disco con densidad superficial de carga uniforme y campo electrico sobre su eje.
- **Prompt:**

  > Diagrama tecnico de un disco plano circular con carga superficial uniforme visto en perspectiva ligera (elipse). El disco de radio R con signos + distribuidos uniformemente sobre su superficie y etiqueta de densidad superficial de carga sigma. Una linea recta perpendicular al centro del disco representa el eje; sobre el eje un punto P a distancia z del centro. En P un vector de campo electrico E dirigido a lo largo del eje alejandose del disco (rojo). Simbolos permitidos: R (radio), z (distancia sobre el eje), sigma, P y E con flecha. Linea de eje punteada gris. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, relleno minimo, rojo para carga positiva y vector campo, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha y subindices correctos. Correccion tecnica estricta: E sobre el eje, perpendicular al plano del disco.

### `electricidad_y_magnetismo/distribucion_discreta_de_cargas_puntuales.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/distribucion_discreta_de_cargas_puntuales.png`
- **Descripcion:** Distribucion discreta de cargas puntuales y campo resultante en un punto por superposicion.
- **Prompt:**

  > Diagrama tecnico de una distribucion discreta de cargas puntuales. Tres o cuatro cargas puntuales pequenas etiquetadas q1, q2, q3 (algunas + en rojo, alguna - en azul) ubicadas en posiciones dispersas del plano, cada una con su vector de posicion. Un punto de observacion P donde se dibujan los vectores de campo E1, E2, E3 aportados por cada carga (lineas finas con flecha) y el vector resultante E (mas grueso, en negro) obtenido por suma vectorial (principio de superposicion). Vectores r desde cada carga hasta P punteados en gris. Simbolos permitidos: q1..q3, P, E1, E2, E3, E resultante. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para carga positiva, azul para negativa, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha y subindices correctos. Correccion tecnica estricta: el vector resultante es la suma vectorial de los aportes individuales.

### `electricidad_y_magnetismo/efecto_joule.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/efecto_joule.png`
- **Descripcion:** Efecto Joule: resistor disipando calor por el paso de corriente.
- **Prompt:**

  > Diagrama tecnico del efecto Joule. Un resistor (simbolo rectangular normalizado IEC) etiquetado R conectado en un circuito simple a una fuente, con corriente I (flecha roja indicando el sentido convencional). Del resistor emanan pequenas flechas onduladas de calor Q disipado hacia afuera. Ecuacion asociada visible: P = I^2 R (potencia disipada). Conductores en gris, resistor y flechas de corriente destacados. Simbolos permitidos: R, I, Q (calor), P = I^2 R. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para el sentido de la corriente, gris para conductores, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, exponentes y subindices correctos. Correccion tecnica estricta: simbolo de resistor IEC correcto y ecuacion de potencia correcta.

### `electricidad_y_magnetismo/efecto_joule_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/efecto_joule_1.png`
- **Descripcion:** Efecto Joule: relacion potencia disipada y energia electrica convertida en calor.
- **Prompt:**

  > Diagrama tecnico complementario del efecto Joule que muestra las formas equivalentes de la potencia disipada en un resistor. Un resistor R con corriente I y diferencia de potencial V en sus terminales (marcados + y -), la corriente entra por + (rojo). Recuadro con las tres expresiones equivalentes de potencia: P = V I = I^2 R = V^2 / R, y la energia disipada en calor W = P t. Conductores en gris. Simbolos permitidos: R, I, V, P, W = P t. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para el sentido de la corriente, gris para conductores, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, exponentes y subindices correctos. Correccion tecnica estricta: las tres expresiones de potencia son equivalentes y correctas.

### `electricidad_y_magnetismo/efecto_joule_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/efecto_joule_2.png`
- **Descripcion:** Efecto Joule: grafica de energia calorifica generada frente al tiempo.
- **Prompt:**

  > Grafica tecnica del efecto Joule: energia calorifica disipada por un resistor frente al tiempo a corriente constante. Ejes cartesianos, eje horizontal t (tiempo), eje vertical W (energia disipada en calor). Recta con pendiente positiva que parte del origen, pendiente igual a la potencia P = I^2 R; anotacion junto a la recta W = I^2 R t. Recta en negro, ejes con flechas, cuadricula tenue opcional. Simbolos permitidos: t, W, pendiente = P. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, exponentes y subindices correctos. Correccion tecnica estricta: a potencia constante la energia crece linealmente con el tiempo (recta por el origen).

### `electricidad_y_magnetismo/elementos_capacitor_y_resistor.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/elementos_capacitor_y_resistor.png`
- **Descripcion:** Simbologia normalizada de los elementos capacitor y resistor.
- **Prompt:**

  > Lamina de simbologia de dos elementos de circuito, presentados lado a lado con su nombre. A la izquierda el simbolo normalizado de un RESISTOR (rectangulo IEC, y opcionalmente su variante en zigzag ANSI debajo) etiquetado 'Resistor' con parametro R (ohmios). A la derecha el simbolo de un CAPACITOR (dos lineas paralelas cortas separadas, terminales a cada lado) etiquetado 'Capacitor' con parametro C (faradios). Cada simbolo con sus dos terminales dibujados en gris. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, gris para terminales, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif. Correccion tecnica estricta: simbolos normalizados correctos (capacitor = dos placas paralelas, resistor = rectangulo).

### `electricidad_y_magnetismo/elementos_fem.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/elementos_fem.png`
- **Descripcion:** Simbolo del elemento fuente de fuerza electromotriz (fem).
- **Prompt:**

  > Lamina de simbologia de una fuente de fuerza electromotriz (fem). Simbolo normalizado de una fuente de corriente continua: dos lineas paralelas, una larga (terminal positivo, marcada +) y una corta (terminal negativo, marcado -), con terminales en gris a cada lado. Etiqueta del elemento con la letra epsilon (o E con subindice) que denota la fem, y flecha que indica el sentido de subida de potencial de - a +. Titulo 'Fuente de fuerza electromotriz (fem)'. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, gris para terminales, rojo para el terminal +, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, simbolo epsilon correcto. Correccion tecnica estricta: linea larga = polo positivo, linea corta = polo negativo.

### `electricidad_y_magnetismo/energia_potencial_electrica.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/energia_potencial_electrica.png`
- **Descripcion:** Energia potencial electrica entre dos cargas puntuales.
- **Prompt:**

  > Diagrama tecnico de la energia potencial electrica de un sistema de dos cargas puntuales. Dos cargas puntuales separadas una distancia r: una carga +q (rojo) a la izquierda y otra +q' (rojo) a la derecha, unidas por una linea de separacion acotada r. Vectores de fuerza de repulsion apuntando en sentidos opuestos sobre cada carga. Recuadro con la ecuacion U = k q q' / r (energia potencial). Simbolos permitidos: q, q', r, U. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para cargas positivas, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, primas y subindices correctos. Correccion tecnica estricta: dos cargas del mismo signo se repelen; U inversamente proporcional a r.

### `electricidad_y_magnetismo/energia_y_capacitancia.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/energia_y_capacitancia.png`
- **Descripcion:** Energia almacenada en un capacitor cargado.
- **Prompt:**

  > Diagrama tecnico de la energia almacenada en un capacitor. Un capacitor de placas paralelas cargado (placa + en rojo, placa - en azul) con campo electrico E entre placas y diferencia de potencial V, capacitancia C. Sombreado tenue entre placas que representa la energia del campo electrico almacenada. Recuadro con las expresiones equivalentes de la energia: U = 1/2 C V^2 = Q^2 / (2C) = 1/2 Q V. Simbolos permitidos: C, V, Q, U. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para carga positiva, azul para negativa, gris para placas, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, exponentes y fracciones correctos. Correccion tecnica estricta: las tres expresiones de energia son equivalentes.

### `electricidad_y_magnetismo/espira_cuadrada.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/espira_cuadrada.png`
- **Descripcion:** Espira cuadrada de corriente y su vector de area / momento magnetico.
- **Prompt:**

  > Diagrama tecnico de una espira cuadrada de corriente. Un cuadrado de lado a formado por un conductor, con corriente I circulando en sentido indicado por flechas rojas a lo largo de los cuatro lados. En el centro un vector normal a la superficie (vector de area A, o momento dipolar magnetico m) saliendo perpendicular al plano de la espira segun la regla de la mano derecha respecto al sentido de I. Simbolos permitidos: a (lado), I, A (o vector m). Conductor en gris/negro, corriente en rojo, vector normal en negro con punta de flecha. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para el sentido de la corriente, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha. Correccion tecnica estricta: el vector normal cumple la regla de la mano derecha con el sentido de la corriente.

### `electricidad_y_magnetismo/espira_desplazandose_en_una_region_de_campo_magnetico_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/espira_desplazandose_en_una_region_de_campo_magnetico_1.png`
- **Descripcion:** Espira entrando en una region de campo magnetico uniforme: fem de movimiento.
- **Prompt:**

  > Diagrama tecnico de una espira rectangular conductora que se desplaza con velocidad v hacia una region de campo magnetico uniforme. A la derecha, region delimitada con campo magnetico B entrante al plano (matriz de cruces 'x' azules). La espira rectangular (gris) se mueve horizontalmente con vector velocidad v (flecha) entrando parcialmente en la region; solo el lado que ya cruzo el borde esta dentro del campo. Se indica la corriente inducida I con flechas rojas alrededor de la espira y el sentido dado por la ley de Lenz. Simbolos permitidos: v, B (con simbolos x), I inducida, ancho L del lado. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, azul para el campo magnetico, rojo para la corriente inducida, gris para la espira, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha. Correccion tecnica estricta: sentido de la corriente inducida coherente con la ley de Lenz al aumentar el flujo entrante.

### `electricidad_y_magnetismo/espira_desplazandose_en_una_region_de_campo_magnetico_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/espira_desplazandose_en_una_region_de_campo_magnetico_2.png`
- **Descripcion:** Espira saliendo de una region de campo magnetico uniforme: fem de movimiento.
- **Prompt:**

  > Diagrama tecnico de una espira rectangular conductora que sale de una region de campo magnetico uniforme. Region con campo magnetico B entrante al plano (matriz de cruces 'x' azules); la espira rectangular (gris) se desplaza con velocidad v (flecha) saliendo por el borde, de modo que el flujo a traves de ella disminuye. Corriente inducida I con flechas rojas cuyo sentido, por la ley de Lenz, tiende a mantener el flujo (opuesto al caso de entrada). Fuerza de frenado sobre el lado conductor indicada con flecha F. Simbolos permitidos: v, B (con simbolos x), I inducida, F. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, azul para campo magnetico, rojo para corriente inducida, gris para la espira, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha. Correccion tecnica estricta: al disminuir el flujo el sentido de la corriente inducida es opuesto al del caso de entrada (ley de Lenz).

### `electricidad_y_magnetismo/espira_en_forma_de_circunferencia.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/espira_en_forma_de_circunferencia.png`
- **Descripcion:** Espira circular de corriente y campo magnetico en su centro.
- **Prompt:**

  > Diagrama tecnico de una espira circular de corriente. Un anillo conductor de radio R con corriente I circulando (flechas rojas sobre el anillo). En el centro de la espira un vector de campo magnetico B perpendicular al plano de la espira, saliendo segun la regla de la mano derecha; algunas lineas de campo curvas atravesando el anillo. Ecuacion junto al centro: B = mu_0 I / (2R) (campo en el centro). Simbolos permitidos: R (radio), I, B con flecha. Conductor gris/negro, corriente roja, campo azul. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente, azul para campo magnetico, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, subindices y letras griegas correctos. Correccion tecnica estricta: B en el centro perpendicular al plano, sentido segun regla de la mano derecha.

### `electricidad_y_magnetismo/experimento_oersted.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/experimento_oersted.png`
- **Descripcion:** Experimento de Oersted: una corriente desvia la aguja de una brujula.
- **Prompt:**

  > Diagrama tecnico del experimento de Oersted. Un conductor recto horizontal por el que circula corriente I (flecha roja) situado sobre una brujula. La aguja de la brujula (con extremo N rojo y S azul) se desvia orientandose perpendicular al conductor por efecto del campo magnetico creado por la corriente. Alrededor del conductor, lineas de campo magnetico circulares B (azules) segun la regla de la mano derecha. Se muestra el conductor conectado a una fuente/pila. Simbolos permitidos: I (corriente), B (campo), aguja N/S, brujula. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente y polo N, azul para campo y polo S, gris para conductor, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha. Correccion tecnica estricta: la aguja se orienta perpendicular al hilo; lineas de campo circulares con sentido segun la mano derecha.

### `electricidad_y_magnetismo/fem_aspectos_relevantes.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/fem_aspectos_relevantes.png`
- **Descripcion:** Aspectos relevantes de una fuente de fem: fem, resistencia interna y voltaje en terminales.
- **Prompt:**

  > Diagrama tecnico de una fuente de fem real conectada a una carga, senalando sus aspectos relevantes. Circuito con una fuente de fem epsilon en serie con una resistencia interna r (resistor pequeno dentro de un recuadro punteado que representa la fuente real), conectada a una resistencia de carga R externa. Corriente I circulando (flecha roja). Se marcan los terminales A y B de la fuente con el voltaje en terminales V_AB. Anotaciones: epsilon (fem), r (resistencia interna), V = epsilon - I r (voltaje en terminales), R (carga). Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente, gris para conductores, recuadro punteado para la fuente real, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, simbolo epsilon y subindices correctos. Correccion tecnica estricta: r en serie con la fem dentro de la fuente; V terminal = fem menos caida en r.

### `electricidad_y_magnetismo/fem_ideal_y_real.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/fem_ideal_y_real.png`
- **Descripcion:** Comparacion entre fuente de fem ideal y fuente real con resistencia interna.
- **Prompt:**

  > Diagrama tecnico comparativo de una fuente de fem ideal y una real, lado a lado. A la izquierda 'Fuente ideal': simbolo de fem epsilon sola (sin resistencia interna), voltaje en terminales V = epsilon constante. A la derecha 'Fuente real': simbolo de fem epsilon en serie con una resistencia interna r, encerradas en un recuadro punteado que representa la fuente; voltaje en terminales V = epsilon - I r. En ambos se dibujan los dos terminales y una flecha de corriente I (roja). Titulos sobre cada caso. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente, gris para conductores, recuadro punteado para la fuente real, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, simbolo epsilon y subindices correctos. Correccion tecnica estricta: la ideal no tiene r; la real la tiene en serie.

### `electricidad_y_magnetismo/flujo_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_1.png`
- **Descripcion:** Concepto de flujo de un campo vectorial a traves de una superficie.
- **Prompt:**

  > Diagrama tecnico del concepto de flujo de un campo vectorial a traves de una superficie plana. Una superficie plana rectangular representada en perspectiva (paralelogramo) con su vector normal n (o vector de area A) saliendo perpendicular. Varias lineas de campo vectorial paralelas E (o F) atravesando la superficie con vectores flecha, formando un angulo theta con la normal. Se acota el angulo theta entre E y n. Ecuacion junto a la figura: Phi = E . A = E A cos(theta). Simbolos permitidos: E (campo), n / A (normal), theta, Phi (flujo). Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, azul para las lineas de campo, negro para la normal, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha y letras griegas correctas. Correccion tecnica estricta: flujo = E A cos(theta), theta medido entre campo y normal.

### `electricidad_y_magnetismo/flujo_magnetico_en_un_conductor_recto_y_largo.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_magnetico_en_un_conductor_recto_y_largo.png`
- **Descripcion:** Campo magnetico circular alrededor de un conductor recto y largo.
- **Prompt:**

  > Diagrama tecnico del campo magnetico alrededor de un conductor recto y largo. Un hilo conductor vertical (gris) por el que circula corriente I hacia arriba (flecha roja). Alrededor del hilo, lineas de campo magnetico B en forma de circunferencias concentricas azules en planos perpendiculares al hilo, con flechas que indican el sentido segun la regla de la mano derecha. Se marca la distancia radial r desde el hilo hasta una linea de campo. Ecuacion: B = mu_0 I / (2 pi r). Simbolos permitidos: I, B, r, mu_0. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente, azul para el campo, gris para el conductor, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas y subindices correctos. Correccion tecnica estricta: lineas de campo circulares concentricas, sentido por regla de la mano derecha, B decrece con r.

### `electricidad_y_magnetismo/flujo_magnetico_en_un_conductor_recto_y_largo_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_magnetico_en_un_conductor_recto_y_largo_1.png`
- **Descripcion:** Regla de la mano derecha aplicada al campo de un conductor recto.
- **Prompt:**

  > Diagrama tecnico que ilustra la regla de la mano derecha para el campo magnetico de un conductor recto y largo. Un hilo conductor recto con corriente I (flecha roja) y una mano derecha estilizada (contorno de linea, no fotorrealista) agarrando el conductor: el pulgar apunta en el sentido de la corriente I y los dedos se curvan indicando el sentido del campo magnetico B circular alrededor del hilo (lineas azules con flecha). Simbolos permitidos: I (pulgar, sentido de corriente), B (dedos, sentido del campo). Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente, azul para campo, gris para conductor, mano en contorno simple, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha. Correccion tecnica estricta: pulgar = sentido de I, dedos curvados = sentido de B.

### `electricidad_y_magnetismo/flujo_magnetico_en_un_conductor_recto_y_largo_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_magnetico_en_un_conductor_recto_y_largo_2.png`
- **Descripcion:** Vista en corte transversal del campo de un conductor recto (corriente saliente).
- **Prompt:**

  > Diagrama tecnico en vista de corte transversal (seccion) de un conductor recto y largo. En el centro un circulo con un punto (simbolo de corriente saliente del plano) etiquetado I. Alrededor, varias circunferencias concentricas azules que representan las lineas de campo magnetico B, cada una con flechas en sentido antihorario (coherente con corriente saliente y la regla de la mano derecha). Se marca el radio r a una de las lineas y la ecuacion B = mu_0 I / (2 pi r). Simbolos permitidos: I (con simbolo de punto), B, r. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, imagen preferentemente cuadrada, Lineas claras off-white nitidas, rojo para el conductor/corriente, azul para el campo, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas y subindices correctos. Correccion tecnica estricta: corriente saliente (punto) implica lineas de campo en sentido antihorario.

### `electricidad_y_magnetismo/flujo_magnetico_en_un_toroide.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_magnetico_en_un_toroide.png`
- **Descripcion:** Campo magnetico confinado dentro de un toroide devanado.
- **Prompt:**

  > Diagrama tecnico de un toroide (nucleo en forma de dona) con un devanado de N espiras de conductor enrolladas uniformemente a su alrededor, por el que circula corriente I (flechas rojas en las espiras). Dentro del nucleo toroidal, lineas de campo magnetico B circulares azules confinadas siguiendo la circunferencia media del toro (el campo es practicamente nulo fuera). Se indica el radio medio r y la ecuacion B = mu_0 N I / (2 pi r). Simbolos permitidos: N (numero de espiras), I, B, r. Nucleo en gris, devanado en negro, corriente roja, campo azul. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas y subindices correctos. Correccion tecnica estricta: campo confinado dentro del toroide, circular a lo largo del nucleo.

### `electricidad_y_magnetismo/flujo_magnetico_en_un_toroide_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_magnetico_en_un_toroide_1.png`
- **Descripcion:** Corte transversal de un toroide mostrando el campo interior y la trayectoria amperiana.
- **Prompt:**

  > Diagrama tecnico en corte de un toroide para aplicar la ley de Ampere. Se muestra la seccion del nucleo toroidal con las espiras del devanado en corte: en el lado interior circulos con punto (corriente saliente) y en el exterior circulos con cruz (corriente entrante), etiquetados I. Una trayectoria amperiana circular punteada de radio r a lo largo del interior del nucleo, con el campo B tangente (azul, flechas) sobre ella. Ecuacion: B (2 pi r) = mu_0 N I, de donde B = mu_0 N I / (2 pi r). Simbolos permitidos: I, B, r, trayectoria amperiana, N. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, imagen preferentemente cuadrada, Lineas claras off-white nitidas, rojo para corriente, azul para campo, gris para nucleo, trayectoria punteada, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas y subindices correctos. Correccion tecnica estricta: campo tangente a la trayectoria interior; simbolos de corriente entrante/saliente coherentes.

### `electricidad_y_magnetismo/flujo_magnetico_en_una_superficie_cerrada.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_magnetico_en_una_superficie_cerrada.png`
- **Descripcion:** Flujo magnetico neto nulo a traves de una superficie cerrada (ley de Gauss magnetica).
- **Prompt:**

  > Diagrama tecnico que ilustra que el flujo magnetico neto a traves de una superficie cerrada es cero. Un iman de barra (con polo N rojo y polo S azul) con sus lineas de campo B cerradas saliendo de N y entrando en S. Una superficie cerrada (esfera o elipsoide dibujado con contorno punteado) que encierra uno de los polos: se ve que toda linea de campo que entra a la superficie tambien sale de ella, de modo que el flujo neto es nulo. Ecuacion: flujo cerrado de B . dA = 0 (ley de Gauss para el magnetismo, no existen monopolos). Simbolos permitidos: N, S, B, superficie cerrada, Phi_B = 0. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para N, azul para S y lineas de campo, superficie punteada, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, subindices correctos. Correccion tecnica estricta: lineas de campo magnetico siempre cerradas; flujo neto por superficie cerrada = 0.

### `electricidad_y_magnetismo/flujo_respecto_a_superficie.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_respecto_a_superficie.png`
- **Descripcion:** Flujo de un campo a traves de una superficie plana con normal inclinada.
- **Prompt:**

  > Diagrama tecnico del flujo de un campo (electrico) a traves de una superficie plana. Un plano rectangular en perspectiva (paralelogramo, gris tenue) con su vector normal A (o n) saliendo perpendicular. Lineas de campo E paralelas y uniformes (azules, con flecha) incidiendo sobre la superficie con un angulo theta respecto a la normal. Se acota el angulo theta entre E y A. Ecuacion: Phi_E = E . A = E A cos(theta). Simbolos permitidos: E, A (normal), theta, Phi_E. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, azul para lineas de campo, negro para la normal, gris para la superficie, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha y letras griegas correctas. Correccion tecnica estricta: Phi = E A cos(theta), angulo entre campo y normal.

### `electricidad_y_magnetismo/flujo_respecto_a_superficie_continua.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_respecto_a_superficie_continua.png`
- **Descripcion:** Flujo a traves de una superficie curva mediante elementos diferenciales de area.
- **Prompt:**

  > Diagrama tecnico del flujo de un campo a traves de una superficie curva continua. Una superficie curva (tipo casquete o lamina alabeada, contorno en gris) sobre la que se marca un pequeno elemento diferencial de area dA con su vector normal local n saliente. Un vector de campo E que atraviesa ese elemento formando un angulo theta con la normal local. Varias flechas de campo azules cruzando la superficie. Ecuacion integral: Phi_E = integral sobre S de E . dA. Simbolos permitidos: E, dA (elemento de area), n (normal), theta, Phi_E. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, azul para el campo, negro para la normal, gris para la superficie, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, notacion de integral y vectores correcta. Correccion tecnica estricta: el flujo total es la integral de superficie de E . dA con normal local.

### `electricidad_y_magnetismo/flujo_respecto_a_superficies.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/flujo_respecto_a_superficies.png`
- **Descripcion:** Comparacion del flujo segun la orientacion de la superficie respecto al campo.
- **Prompt:**

  > Diagrama tecnico comparativo del flujo de un campo uniforme E segun la orientacion de la superficie, mostrando tres casos lado a lado con el mismo haz de lineas de campo horizontales (azules). Caso 1: superficie perpendicular al campo (normal paralela a E, theta = 0), flujo maximo Phi = E A. Caso 2: superficie inclinada un angulo theta, flujo Phi = E A cos(theta). Caso 3: superficie paralela al campo (normal perpendicular a E, theta = 90 grados), flujo nulo Phi = 0. Cada superficie es un segmento/paralelogramo con su vector normal; se acota el angulo. Simbolos permitidos: E, A, theta, Phi en cada caso. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, azul para lineas de campo, negro para normales, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas correctas. Correccion tecnica estricta: flujo maximo a 0 grados, nulo a 90 grados, proporcional a cos(theta).

### `electricidad_y_magnetismo/fuente_de_fuerza_electromotriz_fem.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/fuente_de_fuerza_electromotriz_fem.png`
- **Descripcion:** Fuente de fuerza electromotriz (fem) impulsando corriente en un circuito.
- **Prompt:**

  > Diagrama tecnico de una fuente de fuerza electromotriz (fem) en un circuito cerrado simple. Simbolo de fuente de fem epsilon (lineas larga + y corta -) conectada mediante conductores grises a una resistencia de carga R, formando un lazo. Corriente convencional I circulando del terminal + a traves del circuito externo hasta el terminal - (flechas rojas). La fem impulsa las cargas del - al + dentro de la fuente (flecha interior indicada). Simbolos permitidos: epsilon (fem), I (corriente), R, terminales + y -. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente y terminal +, gris para conductores, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, simbolo epsilon correcto. Correccion tecnica estricta: corriente convencional sale por +, la fem eleva el potencial dentro de la fuente de - a +.

### `electricidad_y_magnetismo/fuerza_de_lorentz.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/fuerza_de_lorentz.png`
- **Descripcion:** Fuerza de Lorentz sobre una carga en movimiento dentro de un campo magnetico.
- **Prompt:**

  > Diagrama tecnico 3D esquematico (ejes en perspectiva) de la fuerza de Lorentz sobre una carga puntual positiva. Una carga +q (rojo) moviendose con velocidad v (vector, flecha) dentro de un campo magnetico B uniforme (vector, azul) que apunta en otra direccion; el vector fuerza F = q v x B (negro) sale perpendicular al plano formado por v y B, segun la regla de la mano derecha. Los tres vectores v, B y F mutuamente perpendiculares partiendo de la carga, con angulos rectos indicados. Recuadro con la ecuacion F = q v x B. Simbolos permitidos: q, v, B, F. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para la carga y velocidad, azul para el campo, negro para la fuerza, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores con flecha y producto vectorial correcto. Correccion tecnica estricta: F perpendicular a v y a B, sentido dado por la regla de la mano derecha para carga positiva.

### `electricidad_y_magnetismo/fuerza_magnetica_entre_conductores.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/fuerza_magnetica_entre_conductores.png`
- **Descripcion:** Fuerza magnetica entre dos conductores paralelos con corrientes en el mismo sentido (atraccion).
- **Prompt:**

  > Diagrama tecnico de la fuerza magnetica entre dos conductores rectos, largos y paralelos. Dos hilos verticales grises separados una distancia d, ambos con corriente en el mismo sentido (flechas rojas hacia arriba), etiquetados I1 e I2. El campo magnetico de cada hilo (lineas azules) en la posicion del otro produce fuerzas de atraccion: vectores F apuntando uno hacia el otro (los hilos se atraen). Ecuacion: F/L = mu_0 I1 I2 / (2 pi d). Simbolos permitidos: I1, I2, d (separacion), F (atraccion), mu_0. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corrientes, azul para campo, gris para conductores, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas y subindices correctos. Correccion tecnica estricta: corrientes en el mismo sentido se ATRAEN.

### `electricidad_y_magnetismo/fuerza_magnetica_entre_conductores_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/fuerza_magnetica_entre_conductores_1.png`
- **Descripcion:** Fuerza magnetica entre dos conductores paralelos con corrientes opuestas (repulsion).
- **Prompt:**

  > Diagrama tecnico de la fuerza magnetica entre dos conductores rectos, largos y paralelos con corrientes en sentidos OPUESTOS. Dos hilos verticales grises separados una distancia d: el izquierdo con corriente I1 hacia arriba y el derecho con corriente I2 hacia abajo (flechas rojas en sentidos contrarios). Las fuerzas resultantes F apuntan hacia afuera (los hilos se repelen), representadas con vectores separandose. Ecuacion: F/L = mu_0 I1 I2 / (2 pi d). Simbolos permitidos: I1, I2, d, F (repulsion), mu_0. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corrientes, azul para campo, gris para conductores, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas y subindices correctos. Correccion tecnica estricta: corrientes en sentidos opuestos se REPELEN.

### `electricidad_y_magnetismo/fuerza_magnetica_entre_conductores_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/fuerza_magnetica_entre_conductores_2.png`
- **Descripcion:** Detalle del campo de un conductor actuando sobre el otro para producir la fuerza.
- **Prompt:**

  > Diagrama tecnico detallado del mecanismo de la fuerza entre dos conductores paralelos. Dos hilos rectos paralelos separados una distancia d, con corrientes I1 e I2 (flechas rojas). Se resalta el campo magnetico B1 creado por el conductor 1 (lineas circulares azules) en la posicion del conductor 2, y sobre el conductor 2 se dibuja la fuerza F2 = I2 L x B1 resultante (vector negro). Se muestra que B1 es perpendicular al conductor 2 en su ubicacion. Ecuaciones: B1 = mu_0 I1 / (2 pi d) y F/L = mu_0 I1 I2 / (2 pi d). Simbolos permitidos: I1, I2, d, B1, F2, mu_0. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corrientes, azul para el campo B1, negro para la fuerza, gris para conductores, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, vectores, letras griegas y subindices correctos. Correccion tecnica estricta: la fuerza sobre el conductor 2 proviene del campo del conductor 1, F = I L x B.

### `electricidad_y_magnetismo/generador_homopolar_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/generador_homopolar_1.png`
- **Descripcion:** Generador homopolar (disco de Faraday): esquema basico.
- **Prompt:**

  > Diagrama tecnico de un generador homopolar o disco de Faraday. Un disco conductor circular (gris) montado sobre un eje central que gira con velocidad angular omega; un campo magnetico B uniforme perpendicular al disco (flechas azules paralelas al eje, saliendo del plano del disco). Escobillas de contacto: una en el eje central y otra en el borde del disco, conectadas por un conductor externo a un galvanometro/carga R. La fem inducida entre el centro y el borde impulsa una corriente I (roja). Simbolos permitidos: omega (rotacion), B (campo), eje, borde, escobillas, I, fem inducida. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, azul para el campo, rojo para la corriente, gris para el disco conductor, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, simbolos correctos. Correccion tecnica estricta: fem generada entre el eje y el borde por rotacion del disco en el campo axial.

### `electricidad_y_magnetismo/generador_homopolar_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/generador_homopolar_2.png`
- **Descripcion:** Generador homopolar: fem inducida sobre el radio del disco.
- **Prompt:**

  > Diagrama tecnico que detalla la fem inducida en un generador homopolar. Vista frontal del disco conductor de radio R girando con velocidad angular omega en un campo magnetico B saliente del plano (matriz de puntos azules). Sobre un radio del disco se muestra un elemento a distancia r del centro moviendose con velocidad v = omega r; el vector fuerza magnetica sobre los portadores q v x B apunta radialmente, generando la fem. Ecuacion: fem = 1/2 B omega R^2. Simbolos permitidos: R, r, omega, B (con puntos), v = omega r, fem = (1/2) B omega R^2. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, imagen preferentemente cuadrada, Lineas claras off-white nitidas, azul para el campo saliente, rojo para v/fuerza, gris para el disco, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas, exponentes y subindices correctos. Correccion tecnica estricta: fem = (1/2) B omega R^2, velocidad tangencial v = omega r.

### `electricidad_y_magnetismo/grafica_capacitancia.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/grafica_capacitancia.png`
- **Descripcion:** Grafica de la carga almacenada frente a la diferencia de potencial (pendiente = capacitancia).
- **Prompt:**

  > Grafica tecnica de la relacion lineal entre la carga almacenada y la diferencia de potencial de un capacitor. Ejes cartesianos: eje horizontal V (diferencia de potencial), eje vertical Q (carga). Recta que pasa por el origen con pendiente constante; anotacion de que la pendiente es la capacitancia C, es decir Q = C V, por lo que C = Q / V. Recta en negro, un punto (V, Q) marcado con lineas guia punteadas grises, ejes con flechas. Simbolos permitidos: V, Q, pendiente = C, Q = C V. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, guias punteadas grises, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, subindices correctos. Correccion tecnica estricta: relacion lineal Q = C V, recta por el origen cuya pendiente es C.

### `electricidad_y_magnetismo/iman_rojo.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/iman_rojo.png`
- **Descripcion:** Iman de barra con polos N-S y sus lineas de campo magnetico.
- **Prompt:**

  > Diagrama tecnico de un iman de barra recto en posicion horizontal. La mitad izquierda del iman marcada como polo Norte (N) en rojo y la mitad derecha como polo Sur (S) en azul. Lineas de campo magnetico B (azules, con flecha) que salen del polo N, se curvan por fuera del iman describiendo lazos cerrados y entran por el polo S; dentro del iman las lineas van de S a N cerrando el circuito. Simbolos permitidos: N, S, B (lineas de campo). Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas para el cuerpo del iman, mitad N en rojo y mitad S en azul, lineas de campo azules con flecha, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif. Correccion tecnica estricta: lineas de campo salen de N, entran en S por el exterior, y son cerradas.

### `electricidad_y_magnetismo/induccion_electromagnetica.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/induccion_electromagnetica.png`
- **Descripcion:** Induccion electromagnetica: iman en movimiento induce corriente en una bobina.
- **Prompt:**

  > Diagrama tecnico de la induccion electromagnetica (ley de Faraday). Una bobina cilindrica de varias espiras (conductor gris) conectada a un galvanometro G. Un iman de barra (polo N rojo hacia la bobina, S azul) se aproxima a la bobina con velocidad v (flecha), aumentando el flujo magnetico a traves de las espiras. Esto induce una corriente I (roja) en la bobina, cuyo sentido, por la ley de Lenz, crea un campo que se opone al acercamiento (la cara de la bobina frente al iman se comporta como N). La aguja del galvanometro se desvia. Simbolos permitidos: v (movimiento del iman), N, S, I inducida, G (galvanometro), flujo Phi. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para N y corriente, azul para S y campo, gris para la bobina, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, simbolos correctos. Correccion tecnica estricta: el movimiento del iman cambia el flujo e induce corriente cuyo sentido se opone al cambio (Lenz).

### `electricidad_y_magnetismo/inductancia_mutua.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/inductancia_mutua.png`
- **Descripcion:** Inductancia mutua entre dos bobinas acopladas magneticamente.
- **Prompt:**

  > Diagrama tecnico de la inductancia mutua entre dos bobinas. Dos bobinas proximas: la bobina primaria (1) con N1 espiras conectada a una fuente con corriente variable I1 (roja), y la bobina secundaria (2) con N2 espiras conectada a un galvanometro. El flujo magnetico Phi generado por la bobina 1 (lineas azules) enlaza parcialmente la bobina 2, induciendo en ella una fem. Se indica el coeficiente de inductancia mutua M y la ecuacion fem_2 = -M dI1/dt. Simbolos permitidos: N1, N2, I1, Phi (flujo compartido), M, fem_2. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente, azul para flujo, gris para conductores/nucleo, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, subindices y derivada correctos. Correccion tecnica estricta: la corriente variable en 1 induce fem en 2 mediante el flujo compartido; fem_2 = -M dI1/dt.

### `electricidad_y_magnetismo/inductancia_mutua_entre_dos_solenoides_coaxiales.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/inductancia_mutua_entre_dos_solenoides_coaxiales.png`
- **Descripcion:** Inductancia mutua entre dos solenoides coaxiales (uno dentro del otro).
- **Prompt:**

  > Diagrama tecnico en corte de dos solenoides coaxiales para la inductancia mutua. Un solenoide exterior largo de N1 espuras (dibujado como serie de espiras en corte) y, coaxial en su interior, un solenoide mas corto o de N2 espiras compartiendo el mismo eje. La corriente I1 (roja) circula por el solenoide 1 y crea un campo magnetico axial uniforme B en su interior (flechas azules a lo largo del eje) que atraviesa completamente al solenoide 2. Se indica la longitud l, el area A y la ecuacion M = mu_0 N1 N2 A / l. Simbolos permitidos: N1, N2, I1, B (axial), A, l, M. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente, azul para el campo axial, gris para conductores, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, letras griegas y subindices correctos. Correccion tecnica estricta: campo axial uniforme del solenoide exterior enlaza el interior; M = mu_0 N1 N2 A / l.

### `electricidad_y_magnetismo/inductancia_propia_de_un_solenoide.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/inductancia_propia_de_un_solenoide.png`
- **Descripcion:** Inductancia propia (autoinductancia) de un solenoide.
- **Prompt:**

  > Diagrama tecnico en corte de un solenoide para su autoinductancia. Un solenoide cilindrico largo con N espiras uniformemente distribuidas (conductor en corte, gris) de longitud l y area de seccion A, por el que circula corriente I (roja). En su interior, campo magnetico axial uniforme B (flechas azules paralelas al eje) dado por B = mu_0 (N/l) I. Se indica la autoinductancia L y su ecuacion L = mu_0 N^2 A / l. Simbolos permitidos: N (numero de espiras), l (longitud), A (area), I, B, L. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, rojo para corriente, azul para el campo axial interno, gris para conductores, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif, exponentes, letras griegas y subindices correctos. Correccion tecnica estricta: campo axial uniforme interior; L = mu_0 N^2 A / l.

### `electricidad_y_magnetismo/inductor_simbologia_basica.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/inductor_simbologia_basica.png`
- **Descripcion:** Simbologia basica del inductor (bobina).
- **Prompt:**

  > Lamina de simbologia basica de un inductor. Simbolo normalizado de inductor: serie de cuatro semicirculos/bucles consecutivos (bobina) con dos terminales rectos en gris a cada lado, etiquetado 'Inductor' con parametro L (henrios). Opcionalmente, debajo, la variante de inductor con nucleo (dos lineas paralelas junto a la bobina indicando nucleo de hierro). Titulo 'Inductor: simbologia basica'. Estilo comun: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, PNG fondo solido navy #27283D, ~1024x768 (4:3), Lineas claras off-white nitidas, gris para terminales, flat sin sombras 3D. Sin texto natural; usar solo simbolos universales, sans-serif. Correccion tecnica estricta: simbolo de inductor con bucles consecutivos correcto; variante con nucleo mediante lineas paralelas.

### `electricidad_y_magnetismo/ley_de_biot_savart_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/ley_de_biot_savart_1.png`
- **Descripcion:** Ley de Biot-Savart: elemento de corriente dl y contribucion diferencial de campo magnetico dB en un punto P.
- **Prompt:**

  > Diagrama tecnico de la Ley de Biot-Savart. Dibuja un conductor delgado que transporta corriente I (flecha roja indicando el sentido de la corriente a lo largo del alambre). Marca sobre el conductor un pequeno elemento diferencial de longitud vectorial dl (flecha corta tangente al alambre, misma direccion que I). Desde el elemento dl traza el vector de posicion r hacia un punto de campo P situado fuera del conductor; sobre ese vector marca el vector unitario r-gorro y el angulo theta entre dl y r. En el punto P dibuja el campo magnetico diferencial dB como un vector (azul) perpendicular al plano formado por dl y r (indicado con simbolo de punto/saliendo del plano o flecha), coherente con la regla de la mano derecha dB proporcional a dl x r-gorro. Incluye la formula dB = (mu_0 / 4pi) * I dl x r-gorro / r^2. Simbolos permitidos: I, dl, r, r-gorro, theta, P, dB. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama tecnico 2D limpio tipo libro de texto de ingenieria, Lineas claras off-white nitidas, acentos rojo=corriente/sentido y azul=campo, flat sin sombras 3D ni fotorrealismo, Sin texto natural; usar solo simbolos universales sans-serif con vectores en negrita/flecha y subindices, fisica y geometricamente correcto.

### `electricidad_y_magnetismo/ley_de_biot_savart_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/ley_de_biot_savart_2.png`
- **Descripcion:** Ley de Biot-Savart: campo magnetico total de un conductor recto largo por integracion de los elementos dl.
- **Prompt:**

  > Diagrama tecnico de la Ley de Biot-Savart aplicada a un conductor recto y largo. Dibuja un alambre recto vertical con corriente I (flecha roja hacia arriba). Marca dos o tres elementos diferenciales dl a lo largo del alambre y desde cada uno un vector r hacia el mismo punto de campo P a distancia perpendicular d del alambre; indica el angulo theta entre cada dl y su r. En P representa el campo magnetico resultante B como una linea de campo circular alrededor del conductor (circulo azul con flecha) o un vector B entrante/saliente del plano segun la regla de la mano derecha. Incluye la expresion integral B = (mu_0 I)/(2 pi d) para el conductor recto infinito y la forma diferencial dB = (mu_0/4pi) I dl sin(theta)/r^2. Simbolos permitidos: I, dl, r, theta, d, P, B. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente, azul=campo, flat sin 3D ni fotorrealismo, Sin texto natural; usar solo simbolos universales sans-serif con simbolos correctos, fisica y geometricamente correcto.

### `electricidad_y_magnetismo/ley_de_corrientes_de_kirchhoff.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/ley_de_corrientes_de_kirchhoff.png`
- **Descripcion:** Ley de corrientes de Kirchhoff (LCK): en un nodo la suma de corrientes que entran es igual a la suma de las que salen.
- **Prompt:**

  > Diagrama de la Ley de Corrientes de Kirchhoff (LCK / KCL). Dibuja un nodo (punto de union grueso) del que salen cuatro o cinco ramas conductoras. Asigna corrientes con flechas rojas y Simbolos permitidos: dos corrientes entrando al nodo (I1, I2 con flechas apuntando hacia el nodo) y dos o tres saliendo (I3, I4 con flechas alejandose). Anade la ecuacion de conservacion de carga: I1 + I2 = I3 + I4, equivalente a suma(I_entran) = suma(I_salen) y suma algebraica en el nodo = 0. Nodo claramente marcado en el centro. Simbolos permitidos: nodo, I1, I2, I3, I4. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama de circuito 2D limpio tipo libro de texto, Lineas claras off-white nitidas para conductores, flechas rojas para el sentido de las corrientes, flat sin sombras 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, topologia electrica correcta.

### `electricidad_y_magnetismo/ley_de_lenz_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/ley_de_lenz_1.png`
- **Descripcion:** Ley de Lenz: iman acercandose a una espira; la corriente inducida se opone al aumento de flujo.
- **Prompt:**

  > Diagrama de la Ley de Lenz, caso iman ACERCANDOSE. Dibuja una espira conductora circular vista en perspectiva ligera (o de frente) y a la izquierda un iman de barra con el polo Norte (N, rojo) enfrentado a la espira, moviendose hacia ella (flecha de velocidad v apuntando hacia la espira). Representa el flujo magnetico externo del iman aumentando a traves de la espira (lineas de campo B saliendo del polo N hacia la espira, azules). Dibuja la corriente inducida I_ind en la espira con un sentido tal que su propio campo magnetico se OPONGA al aumento de flujo (la cara de la espira frente al iman actua como polo Norte para repeler; usa la regla de la mano derecha para el sentido de I_ind). Incluye la ley: fem = - dPhi/dt (Ley de Faraday-Lenz). Simbolos permitidos: N, S, v, B, I_ind, Phi. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=polo N/sentido, azul=campo/flujo, flat sin 3D fotorrealista, Sin texto natural; usar solo simbolos universales sans-serif con simbolos correctos, sentido de la corriente inducida fisicamente correcto segun Lenz.

### `electricidad_y_magnetismo/ley_de_lenz_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/ley_de_lenz_2.png`
- **Descripcion:** Ley de Lenz: iman alejandose de una espira; la corriente inducida se opone a la disminucion de flujo (sentido invertido).
- **Prompt:**

  > Diagrama de la Ley de Lenz, caso iman ALEJANDOSE. Dibuja una espira conductora circular y a la izquierda un iman de barra con el polo Norte (N, rojo) frente a la espira pero moviendose ALEJANDOSE de ella (flecha de velocidad v apuntando lejos de la espira). El flujo magnetico a traves de la espira DISMINUYE (lineas de campo B azules). Dibuja la corriente inducida I_ind con sentido tal que su campo se OPONGA a la disminucion, es decir intente mantener el flujo (la cara de la espira frente al iman actua como polo Sur para atraer al iman que se aleja); el sentido de I_ind es OPUESTO al del caso de acercamiento. Incluye fem = - dPhi/dt. Simbolos permitidos: N, S, v, B, I_ind, Phi. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=polo N/sentido, azul=campo/flujo, flat sin 3D fotorrealista, Sin texto natural; usar solo simbolos universales sans-serif con simbolos correctos, sentido de la corriente inducida correcto segun Lenz y opuesto al de acercamiento.

### `electricidad_y_magnetismo/ley_de_voltajes_de_kirchhoff.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/ley_de_voltajes_de_kirchhoff.png`
- **Descripcion:** Ley de voltajes de Kirchhoff (LVK): en una malla cerrada la suma algebraica de fem y caidas de tension es cero.
- **Prompt:**

  > Diagrama de la Ley de Voltajes de Kirchhoff (LVK / KVL). Dibuja una malla (lazo) rectangular de circuito con una fuente de fem (bateria, simbolo de lineas larga/corta) etiquetada V o E, y dos o tres resistores en serie etiquetados R1, R2, R3 con sus caidas de tension V1, V2, V3 (marcadas con polaridad + y -). Anade una flecha curva que indique el sentido de recorrido de la malla y la corriente I (roja). Escribe la ecuacion: E - V1 - V2 - V3 = 0, equivalente a suma algebraica de tensiones en la malla = 0. Simbolos IEC/ANSI de resistor y bateria correctos. Simbolos permitidos: E (o V), R1, R2, R3, V1, V2, V3, I, sentido de la malla. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama de circuito 2D limpio tipo libro de texto, Lineas claras off-white nitidas para conductores, rojo para corriente/sentido, flat sin sombras 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices y polaridades, topologia y polaridades electricamente correctas.

### `electricidad_y_magnetismo/leyes_de_kirchhoff_circuito_rc.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/leyes_de_kirchhoff_circuito_rc.png`
- **Descripcion:** Aplicacion de las leyes de Kirchhoff a un circuito RC serie (fuente, resistor y capacitor en malla).
- **Prompt:**

  > Diagrama de un circuito RC serie para aplicar las leyes de Kirchhoff. Dibuja una malla con una fuente de fem E (bateria), un interruptor, un resistor R y un capacitor C conectados en serie. Marca la corriente de malla i(t) con flecha roja, la caida de tension en el resistor V_R = i R y la tension en el capacitor V_C = q/C con su polaridad + y - en las placas. Incluye la ecuacion de malla (LVK): E - i R - q/C = 0. Simbolos correctos: bateria (lineas larga/corta), resistor (rectangulo o zigzag), capacitor (dos placas paralelas), interruptor abierto/cerrado. Simbolos permitidos: E, R, C, i(t), V_R, V_C, q, +q, -q. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama de circuito 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente/sentido, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, topologia RC serie y polaridades correctas.

### `electricidad_y_magnetismo/linea_infinita.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/linea_infinita.png`
- **Descripcion:** Linea de carga infinita con densidad lineal lambda y campo electrico radial; superficie gaussiana cilindrica.
- **Prompt:**

  > Diagrama de una linea de carga INFINITA con densidad lineal de carga lambda uniforme (linea horizontal larga con signos + distribuidos, roja, que se extiende y sale de ambos bordes indicando longitud infinita). Muestra el campo electrico E radial: vectores azules perpendiculares a la linea, apuntando hacia afuera de forma simetrica (arriba, abajo y alrededor). Superpon un cilindro gaussiano coaxial a la linea (superficie gris translucida) de radio r y longitud L para aplicar la ley de Gauss. Incluye la formula E = lambda / (2 pi epsilon_0 r). Simbolos permitidos: lambda, E, r, L, superficie gaussiana. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=carga positiva, azul=campo electrico, flat sin sombras 3D fotorrealistas, Sin texto natural; usar solo simbolos universales sans-serif con simbolos griegos y subindices correctos, simetria radial del campo correcta.

### `electricidad_y_magnetismo/momento_dipolar_magnetico.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/momento_dipolar_magnetico.png`
- **Descripcion:** Momento dipolar magnetico de una espira de corriente: mu = I A, vector perpendicular al plano por la regla de la mano derecha.
- **Prompt:**

  > Diagrama del momento dipolar magnetico de una espira de corriente. Dibuja una espira plana (circular o cuadrada) que transporta corriente I en sentido definido (flecha roja recorriendo la espira). Dibuja el vector de area A (o el vector normal n) y el vector momento dipolar magnetico mu perpendicular al plano de la espira, apuntando segun la regla de la mano derecha respecto al sentido de la corriente (azul, saliendo del plano). Incluye la formula mu = I A (y mu = N I A si hay N vueltas). Opcional: pequena mano derecha indicando la regla (dedos siguen I, pulgar da mu). Simbolos permitidos: I, A, n, mu, area de la espira. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente, azul=vector mu, flat sin 3D fotorrealista, Sin texto natural; usar solo simbolos universales sans-serif con vectores en negrita/flecha, direccion de mu correcta por la regla de la mano derecha.

### `electricidad_y_magnetismo/motor_de_corriente_directa.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/motor_de_corriente_directa.png`
- **Descripcion:** Motor de corriente directa: espira portadora de corriente en campo magnetico entre polos N-S, con conmutador, genera par.
- **Prompt:**

  > Diagrama esquematico de un motor de corriente directa (CD). Dibuja dos imanes o piezas polares fijas, uno con polo Norte (N, rojo) y otro con polo Sur (S, azul) enfrentados, con lineas de campo magnetico B horizontales de N a S entre ellos. Entre los polos coloca una espira rectangular (armadura) que transporta corriente I proveniente de una fuente de CD a traves de un conmutador (dos delgas) y escobillas. Indica con flechas las fuerzas F = I L x B sobre los dos lados activos de la espira (fuerzas opuestas arriba y abajo) que producen un par (torque) de giro; marca el sentido de rotacion con una flecha curva. Simbolos permitidos: N, S, B, I, F, conmutador, escobillas, espira/armadura, fuente CD, sentido de giro. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=polo N/corriente, azul=polo S/campo, gris=metal, flat sin 3D fotorrealista, Sin texto natural; usar solo simbolos universales sans-serif, sentido de fuerzas y giro coherente con F = I L x B.

### `electricidad_y_magnetismo/motor_de_corriente_directa_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/motor_de_corriente_directa_1.png`
- **Descripcion:** Motor de corriente directa (vista 2): detalle del conmutador y la inversion de corriente que mantiene el par en un solo sentido.
- **Prompt:**

  > Diagrama esquematico de un motor de corriente directa mostrando el DETALLE del conmutador. Dibuja la espira de la armadura entre los polos N (rojo) y S (azul) con campo B, y en primer plano el conmutador de dos delgas (semianillos) con las dos escobillas que rozan sobre el. Muestra con flechas rojas como, al girar media vuelta, el conmutador INVIERTE el sentido de la corriente en la espira para que el par de giro se mantenga siempre en el mismo sentido de rotacion. Incluye las fuerzas F sobre los lados de la espira y la flecha del sentido de giro. Simbolos permitidos: N, S, B, I, F, delgas del conmutador, escobillas, sentido de giro, inversion de corriente. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente/N, azul=S/campo, gris=metal, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif, mecanismo de conmutacion y sentido de las fuerzas correctos.

### `electricidad_y_magnetismo/no_polarizado.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/no_polarizado.png`
- **Descripcion:** Simbolo de capacitor NO polarizado: dos placas rectas paralelas simetricas, sin marca de polaridad.
- **Prompt:**

  > Simbolo esquematico de un capacitor NO polarizado. Dibuja el simbolo estandar: dos lineas rectas paralelas iguales (las dos placas) separadas por un pequeno espacio, cada una conectada a una terminal (linea de conexion) que sale hacia afuera. Ambas placas identicas y simetricas, SIN signo de polaridad (no hay +, ninguna placa curva). Junto al simbolo la etiqueta 'Capacitor no polarizado' y la letra de designacion C. Composicion centrada y limpia, tipo hoja de simbologia electrica. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, sin color de acento innecesario, flat sin sombras 3D, Sin texto natural; usar solo simbolos universales sans-serif, simbolo IEC/ANSI de capacitor no polarizado correcto.

### `electricidad_y_magnetismo/nomenclatura_basica_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/nomenclatura_basica_1.png`
- **Descripcion:** Nomenclatura basica de un transformador/devanado: nucleo, devanado primario y secundario con sus simbolos y notacion.
- **Prompt:**

  > Diagrama de nomenclatura basica de un transformador. Dibuja el simbolo esquematico de un transformador: dos bobinas (devanados) representadas como series de arcos/espiras enfrentadas, con el nucleo ferromagnetico en el centro (dos lineas verticales paralelas). Etiqueta claramente el devanado PRIMARIO (lado de entrada) con N1 vueltas y tension V1, y el devanado SECUNDARIO (lado de salida) con N2 vueltas y tension V2; marca el nucleo. Anade la relacion de transformacion V1/V2 = N1/N2. Terminales de entrada y salida claras. Simbolos permitidos: primario, secundario, nucleo, N1, N2, V1, V2. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, gris para el nucleo, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, simbologia de transformador correcta.

### `electricidad_y_magnetismo/nomenclatura_basica_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/nomenclatura_basica_2.png`
- **Descripcion:** Nomenclatura basica de un transformador (vista 2): convencion de puntos de polaridad en primario y secundario.
- **Prompt:**

  > Diagrama de nomenclatura basica de un transformador con la CONVENCION DE PUNTOS (polaridad). Dibuja el simbolo del transformador con nucleo central y devanados primario y secundario, cada uno con un punto (marca de polaridad) en una de sus terminales indicando los extremos de igual polaridad instantanea. Muestra el sentido de las corrientes i1 e i2 y las tensiones v1 y v2 referidas a los puntos. Explica con etiqueta breve que las corrientes que entran por los terminales con punto producen flujos que se suman. Simbolos permitidos: primario, secundario, nucleo, punto de polaridad, i1, i2, v1, v2. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo para el sentido de corrientes, gris para el nucleo, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, convencion de puntos y polaridad correcta.

### `electricidad_y_magnetismo/polaridad_devanado_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polaridad_devanado_1.png`
- **Descripcion:** Polaridad de devanado (caso 1): dos bobinas acopladas en serie aditiva, con puntos del mismo lado (flujos que se suman).
- **Prompt:**

  > Diagrama de polaridad de devanado, conexion SERIE ADITIVA. Dibuja dos inductores/bobinas acoplados magneticamente L1 y L2 (arcos de espiras) sobre un mismo nucleo, conectados en serie. Coloca las marcas de polaridad (puntos) de modo que la corriente entre por el terminal con punto en ambas bobinas, de forma que los flujos magneticos se SUMAN (acoplamiento aditivo). Indica el sentido de la corriente I con flecha roja y los flujos Phi1 y Phi2 en el nucleo apuntando en el mismo sentido. Incluye la inductancia equivalente L_eq = L1 + L2 + 2M. Simbolos permitidos: L1, L2, M, punto de polaridad, I, Phi, serie aditiva. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente, gris=nucleo, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, convencion de puntos y suma de flujos correcta.

### `electricidad_y_magnetismo/polaridad_devanado_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polaridad_devanado_2.png`
- **Descripcion:** Polaridad de devanado (caso 2): dos bobinas en serie sustractiva, puntos en lados opuestos (flujos que se restan).
- **Prompt:**

  > Diagrama de polaridad de devanado, conexion SERIE SUSTRACTIVA. Dibuja dos inductores acoplados L1 y L2 sobre un mismo nucleo, en serie, con las marcas de polaridad (puntos) en lados OPUESTOS, de modo que la corriente produce flujos magneticos que se RESTAN (acoplamiento sustractivo/oposicion). Indica el sentido de la corriente I (flecha roja) y los flujos Phi1 y Phi2 en el nucleo apuntando en sentidos opuestos. Incluye la inductancia equivalente L_eq = L1 + L2 - 2M. Simbolos permitidos: L1, L2, M, punto de polaridad, I, Phi, serie sustractiva. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente, gris=nucleo, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, convencion de puntos y oposicion de flujos correcta.

### `electricidad_y_magnetismo/polaridad_devanado_paralelo_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polaridad_devanado_paralelo_1.png`
- **Descripcion:** Polaridad de devanado en PARALELO (caso 1): dos bobinas acopladas en paralelo con puntos del mismo lado (aditivo).
- **Prompt:**

  > Diagrama de polaridad de devanado, conexion en PARALELO ADITIVA. Dibuja dos inductores acoplados L1 y L2 conectados en PARALELO (mismos dos nodos comunes) sobre un nucleo comun, con las marcas de polaridad (puntos) orientadas del MISMO lado, de modo que los flujos se suman (acoplamiento aditivo). Indica las corrientes de rama i1 e i2 (flechas rojas) que entran por los terminales con punto, la corriente total I y los flujos Phi. Incluye la inductancia equivalente en paralelo con acoplamiento aditivo L_eq = (L1 L2 - M^2)/(L1 + L2 - 2M). Simbolos permitidos: L1, L2, M, punto de polaridad, i1, i2, I, Phi, paralelo aditivo. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama de circuito 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente, gris=nucleo, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, topologia en paralelo y convencion de puntos correcta.

### `electricidad_y_magnetismo/polaridad_devanado_paralelo_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polaridad_devanado_paralelo_2.png`
- **Descripcion:** Polaridad de devanado en PARALELO (caso 2): dos bobinas acopladas en paralelo con puntos opuestos (sustractivo).
- **Prompt:**

  > Diagrama de polaridad de devanado, conexion en PARALELO SUSTRACTIVA. Dibuja dos inductores acoplados L1 y L2 conectados en PARALELO sobre un nucleo comun, con las marcas de polaridad (puntos) en lados OPUESTOS, de modo que los flujos se restan (acoplamiento sustractivo). Indica las corrientes de rama i1 e i2 (flechas rojas), la corriente total I y los flujos Phi en oposicion. Incluye la inductancia equivalente en paralelo con acoplamiento sustractivo L_eq = (L1 L2 - M^2)/(L1 + L2 + 2M). Simbolos permitidos: L1, L2, M, punto de polaridad, i1, i2, I, Phi, paralelo sustractivo. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama de circuito 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente, gris=nucleo, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, topologia en paralelo y convencion de puntos correcta.

### `electricidad_y_magnetismo/polarizacion.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polarizacion.png`
- **Descripcion:** Polarizacion de un dielectrico: dipolos moleculares alineandose ante un campo electrico externo.
- **Prompt:**

  > Diagrama de la polarizacion de un material dielectrico. Dibuja un bloque rectangular de dielectrico dentro de un campo electrico externo E0 uniforme (flechas azules horizontales apuntando hacia la derecha). Dentro del material representa muchos dipolos moleculares como pequenos pares de cargas -/+ (elipses con extremo azul negativo a la izquierda y extremo rojo positivo a la derecha) ALINEADOS con el campo externo. Muestra que en las caras del bloque aparecen cargas de polarizacion (bound): capa negativa en la cara izquierda y capa positiva en la cara derecha, generando un campo interno E_p opuesto a E0. Incluye el vector polarizacion P (en el sentido de E0) y la etiqueta del campo resultante dentro menor que E0. Simbolos permitidos: E0, dielectrico, dipolos, P, cargas de polarizacion, E_p. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, azul=campo/carga negativa, rojo=carga positiva, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif, orientacion de dipolos y signos de carga fisicamente correctos.

### `electricidad_y_magnetismo/polarizacion_cargas.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polarizacion_cargas.png`
- **Descripcion:** Cargas de polarizacion (ligadas): cargas superficiales netas en las caras de un dielectrico polarizado.
- **Prompt:**

  > Diagrama de las cargas de polarizacion (cargas ligadas) en un dielectrico. Dibuja un bloque de dielectrico polarizado; en su interior los dipolos alineados se cancelan salvo en las superficies. En la cara izquierda muestra una capa de carga superficial NEGATIVA (fila de signos - azules) y en la cara derecha una capa de carga superficial POSITIVA (fila de signos + rojos), que son las cargas de polarizacion o cargas ligadas sigma_p. Indica el vector polarizacion P apuntando de las cargas negativas hacia las positivas y la relacion sigma_p = P . n (densidad de carga ligada = P por la normal). Simbolos permitidos: dielectrico, sigma_p (+), sigma_p (-), P, n. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=carga positiva, azul=carga negativa, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices y simbolos griegos, signos de carga y direccion de P correctos.

### `electricidad_y_magnetismo/polarizacion_de_carga_inducida_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polarizacion_de_carga_inducida_1.png`
- **Descripcion:** Polarizacion de carga inducida (paso 1): material neutro sin campo externo, dipolos/cargas distribuidos al azar.
- **Prompt:**

  > Diagrama, PASO 1 de una secuencia de polarizacion de carga inducida. Dibuja un bloque de material dielectrico neutro SIN campo electrico externo aplicado. En su interior representa moleculas/dipolos orientados al AZAR (pequenos pares -/+ apuntando en direcciones aleatorias) de modo que no hay polarizacion neta y las caras no tienen carga superficial. Etiqueta breve: 'Sin campo externo: E0 = 0, orientacion aleatoria, sin polarizacion neta'. Simbolos permitidos: dielectrico, E0 = 0, dipolos al azar. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=carga positiva, azul=carga negativa, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif, representacion fisicamente correcta del estado no polarizado.

### `electricidad_y_magnetismo/polarizacion_de_carga_inducida_2.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polarizacion_de_carga_inducida_2.png`
- **Descripcion:** Polarizacion de carga inducida (paso 2): al aplicar campo externo, los dipolos se alinean y aparecen cargas en las caras.
- **Prompt:**

  > Diagrama, PASO 2 de la secuencia de polarizacion de carga inducida. El mismo bloque de dielectrico ahora dentro de un campo electrico externo E0 uniforme (flechas azules apuntando a la derecha). Los dipolos moleculares se ALINEAN con el campo (pares -/+ ordenados, extremo negativo hacia la izquierda, positivo hacia la derecha). Empiezan a aparecer cargas de polarizacion en las caras: negativa a la izquierda, positiva a la derecha. Etiqueta breve: 'Con campo externo E0: los dipolos se alinean y se induce polarizacion'. Simbolos permitidos: E0, dielectrico, dipolos alineados, cargas inducidas, P. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, azul=campo/carga negativa, rojo=carga positiva, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif, alineacion de dipolos y signos correctos.

### `electricidad_y_magnetismo/polarizacion_de_carga_inducida_3.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polarizacion_de_carga_inducida_3.png`
- **Descripcion:** Polarizacion de carga inducida (paso 3): dielectrico polarizado con campo interno inducido opuesto al externo.
- **Prompt:**

  > Diagrama, PASO 3 (final) de la secuencia de polarizacion de carga inducida. El bloque de dielectrico completamente polarizado dentro del campo externo E0. Muestra claramente las capas de carga de polarizacion: negativa en la cara izquierda (signos - azules) y positiva en la derecha (signos + rojos). Estas cargas generan un campo electrico interno inducido E_p (flechas dentro del material apuntando a la izquierda, OPUESTO a E0), de modo que el campo neto dentro del dielectrico es E = E0 - E_p, menor que E0. Incluye el vector polarizacion P. Etiqueta breve: 'Campo inducido E_p opuesto a E0; campo neto reducido'. Simbolos permitidos: E0, E_p, E (neto), P, cargas de polarizacion. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, azul=campo/carga negativa, rojo=carga positiva, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, direccion de E_p opuesta a E0 y signos correctos.

### `electricidad_y_magnetismo/polarizado.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/polarizado.png`
- **Descripcion:** Simbolo de capacitor polarizado (electrolitico): una placa recta y otra curva, con marca de polaridad +.
- **Prompt:**

  > Simbolo esquematico de un capacitor POLARIZADO (electrolitico). Dibuja el simbolo estandar: una placa recta (terminal positiva) y frente a ella una placa CURVA (terminal negativa), separadas por un pequeno espacio, cada una con su linea de conexion hacia afuera. Marca claramente el signo + (rojo) junto a la terminal de la placa recta para indicar la polaridad. Junto al simbolo la etiqueta 'Capacitor polarizado (electrolitico)' y la designacion C. Composicion centrada y limpia tipo hoja de simbologia. Simbolos permitidos: +, terminal positiva, terminal negativa, C. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo solo para el signo +, flat sin sombras 3D, Sin texto natural; usar solo simbolos universales sans-serif, simbolo de capacitor polarizado (placa recta + placa curva) correcto.

### `electricidad_y_magnetismo/portadores_de_carga_libre.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/portadores_de_carga_libre.png`
- **Descripcion:** Portadores de carga libre en un conductor: electrones libres derivando bajo un campo aplicado, generando corriente.
- **Prompt:**

  > Diagrama de portadores de carga libre en un conductor. Dibuja un segmento de alambre conductor cilindrico (gris) con seccion transversal A. En su interior representa multiples electrones libres como pequenos circulos azules con signo - moviendose (velocidad de deriva v_d) por accion de un campo electrico externo E aplicado a lo largo del conductor (flecha azul E). Indica que la corriente convencional I (flecha roja) va en sentido OPUESTO al movimiento de los electrones. Incluye la relacion I = n q v_d A (densidad de portadores n, carga q, velocidad de deriva v_d, area A). Simbolos permitidos: conductor, electrones libres, v_d, E, I, A, n. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, gris=conductor, azul=electrones/campo, rojo=corriente convencional, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, sentido opuesto de corriente y deriva electronica correcto.

### `electricidad_y_magnetismo/principio_de_superposicion.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/principio_de_superposicion.png`
- **Descripcion:** Principio de superposicion: el campo electrico total en un punto es la suma vectorial de los campos de cada carga.
- **Prompt:**

  > Diagrama del principio de superposicion del campo electrico. Dibuja dos o tres cargas puntuales en distintas posiciones: por ejemplo +q1 (rojo) y -q2 (azul), y un punto de campo P. Desde P dibuja el vector campo electrico E1 producido por q1 (alejandose de la carga positiva) y E2 producido por q2 (acercandose a la carga negativa), con lineas punteadas de referencia hacia cada carga. Luego dibuja la suma vectorial (regla del paralelogramo con lineas punteadas) que da el campo resultante E_total = E1 + E2 en P (flecha mas gruesa). Incluye la formula E_total = suma de E_i = k suma q_i r_i-gorro / r_i^2. Simbolos permitidos: +q1, -q2, P, E1, E2, E_total. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=carga positiva, azul=carga negativa, vectores de campo claros, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con subindices, suma vectorial y sentidos de campo fisicamente correctos.

### `electricidad_y_magnetismo/regla_de_la_mano_derecha.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/regla_de_la_mano_derecha.png`
- **Descripcion:** Regla de la mano derecha: relacion entre corriente/velocidad, campo magnetico y fuerza (o campo alrededor de un conductor).
- **Prompt:**

  > Diagrama de la regla de la mano derecha para la fuerza magnetica. Dibuja una mano derecha estilizada (contorno limpio tipo libro de texto) con: el PULGAR apuntando en la direccion de la velocidad v o la corriente I (flecha roja), los DEDOS extendidos en la direccion del campo magnetico B (flecha azul), y la PALMA empujando en la direccion de la fuerza F (flecha, resultado de F = q v x B o F = I L x B). Muestra los tres vectores mutuamente perpendicules con ejes de referencia. Incluye las formulas F = q v x B y F = I L x B. Opcional secundario: un conductor recto con corriente I y las lineas de campo B circulares alrededor (regla de la mano derecha para el campo). Simbolos permitidos: I (o v), B, F, mano derecha. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=corriente/velocidad, azul=campo, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con vectores en negrita/flecha, ortogonalidad y sentidos correctos del producto vectorial.

### `electricidad_y_magnetismo/representacion_de_los_vectores_electricos.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/representacion_de_los_vectores_electricos.png`
- **Descripcion:** Representacion de los vectores electricos: campo E en un punto por componentes y notacion vectorial.
- **Prompt:**

  > Diagrama de la representacion de los vectores electricos. Dibuja un plano cartesiano x-y (o ejes x, y, z) y en un punto P un vector campo electrico E representado por una flecha azul, descompuesto en sus componentes Ex y Ey (lineas punteadas y flechas sobre los ejes). Indica el angulo theta que forma E con el eje x y la magnitud |E|. Incluye la notacion vectorial E = Ex i + Ey j (con i, j vectores unitarios) y |E| = raiz(Ex^2 + Ey^2). Junto a una carga fuente +q muestra brevemente el sentido radial del campo. Simbolos permitidos: P, E, Ex, Ey, theta, i, j, +q. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas para ejes, azul para vector de campo, rojo=carga positiva, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif con vectores en negrita/flecha y subindices, descomposicion vectorial correcta.

### `electricidad_y_magnetismo/resistor_lineal_y_no_lineal.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/resistor_lineal_y_no_lineal.png`
- **Descripcion:** Resistor lineal vs no lineal: curvas caracteristicas corriente-voltaje (recta ohmica vs curva).
- **Prompt:**

  > Diagrama comparativo de un resistor LINEAL y uno NO LINEAL mediante sus curvas caracteristicas corriente-voltaje. Dibuja unos ejes cartesianos con voltaje V en el eje horizontal y corriente I en el eje vertical. Traza dos curvas: (1) resistor LINEAL/ohmico = una linea recta que pasa por el origen con pendiente constante 1/R (color negro), cumpliendo la ley de Ohm V = I R; (2) resistor NO LINEAL = una curva que se curva (por ejemplo tipo diodo o exponencial, pendiente variable, en rojo o azul), donde la resistencia depende del voltaje. Etiqueta cada curva. Incluye V = I R para el caso lineal. Simbolos permitidos: V, I, resistor lineal (ohmico), resistor no lineal, pendiente 1/R. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), grafica/diagrama 2D limpio tipo libro de texto, ejes y Lineas claras off-white nitidas, un acento de color para la curva no lineal, flat sin 3D, Sin texto natural; usar solo simbolos universales sans-serif, forma de las curvas I-V correcta (recta por el origen vs curva).

### `electricidad_y_magnetismo/resistor_simbologia_basica.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/resistor_simbologia_basica.png`
- **Descripcion:** Simbologia basica del resistor: simbolo rectangular (IEC) y de zigzag (ANSI), con designacion R.
- **Prompt:**

  > Diagrama de la simbologia basica de un resistor. Dibuja los dos simbolos estandar uno junto al otro con sus terminales de conexion: (1) simbolo IEC = rectangulo alargado; (2) simbolo ANSI = linea en zigzag (dientes de sierra). Etiqueta cada uno con su norma (IEC / ANSI) y anade la designacion generica R y la unidad ohm (Omega). Composicion centrada y limpia tipo hoja de simbologia electrica. Simbolos permitidos: resistor, R, ohm (Omega), IEC (rectangulo), ANSI (zigzag). Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, sin colores de acento innecesarios, flat sin sombras 3D, Sin texto natural; usar solo simbolos universales sans-serif con simbolo de ohm correcto, simbolos de resistor IEC y ANSI dibujados correctamente.

### `electricidad_y_magnetismo/rigidez_dielectrica.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/rigidez_dielectrica.png`
- **Descripcion:** Rigidez dielectrica: campo electrico maximo que soporta un dielectrico antes de la ruptura (arco/descarga).
- **Prompt:**

  > Diagrama de la rigidez dielectrica. Dibuja un capacitor de placas planas y paralelas: placa superior positiva (+, roja) y placa inferior negativa (-, azul), con un material dielectrico entre ellas y el campo electrico E uniforme (flechas verticales azules de + a -). Representa que al superar el campo maximo admisible el dielectrico sufre RUPTURA: dibuja un arco electrico o descarga (linea tipo rayo, en amarillo/naranja o negro) atravesando el dielectrico entre las placas. Incluye la definicion de rigidez dielectrica E_max = V_ruptura / d (campo maximo antes de la ruptura, con d la separacion). Simbolos permitidos: +, -, dielectrico, E, d, ruptura/arco, E_max = V_r / d. Estilo/formato comun: PNG, fondo solido navy #27283D, ~1024x768 (4:3), diagrama 2D limpio tipo libro de texto, Lineas claras off-white nitidas, rojo=placa positiva, azul=placa negativa/campo, gris=placas conductoras, un acento para el arco de ruptura, flat sin 3D fotorrealista, Sin texto natural; usar solo simbolos universales sans-serif con subindices, geometria del capacitor y sentido del campo correctos.

### `electricidad_y_magnetismo/segmento_de_conductor_recto.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/segmento_de_conductor_recto.png`
- **Descripcion:** Segmento de conductor recto que transporta corriente, con elemento diferencial dl y sentido de la corriente I; base para la ley de Biot-Savart o la fuerza magnetica sobre un conductor.
- **Prompt:**

  > Diagrama tecnico 2D de un SEGMENTO DE CONDUCTOR RECTO que transporta corriente. Dibuja un alambre recto horizontal (linea gris gruesa) de longitud finita con extremos marcados a y b. Sobre el alambre marca el sentido de la corriente con una flecha roja rotulada I apuntando de a hacia b. En un punto interior del alambre marca un elemento diferencial de longitud como un pequeno tramo resaltado con una flecha vectorial roja rotulada d(vector)l alineada con la corriente. Desde ese elemento traza una linea de trazos gris hasta un punto exterior P, rotulada r (vector unitario r con sombrero opcional), formando un angulo theta con el alambre; marca el angulo theta con un arco. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para el sentido de la corriente/vectores, gris para el conductor). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, vectores con flecha y subindices correctos (I, d(vector)l, r, theta, P, a, b). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: el elemento dl debe ser colineal con la corriente y el angulo theta medido entre el conductor y la linea al punto P.

### `electricidad_y_magnetismo/segmento_de_linea.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/segmento_de_linea.png`
- **Descripcion:** Segmento de linea con carga distribuida (densidad lineal lambda); elemento dq = lambda dl que aporta un campo dE en un punto P.
- **Prompt:**

  > Diagrama tecnico 2D de un SEGMENTO DE LINEA CARGADO usado para calcular campo electrico por integracion. Dibuja un segmento recto (linea gruesa gris o negra) con marcas de signo mas (+) distribuidas uniformemente a lo largo, rotulado con densidad lineal de carga lambda. Resalta un pequeno tramo del segmento como un elemento diferencial rotulado dl, con su carga dq = lambda dl. Desde ese elemento traza una linea de trazos hasta un punto exterior P, rotulada r (con flecha vectorial). En P dibuja una flecha vectorial roja rotulada d(vector)E apuntando alejandose del elemento (carga positiva). Marca un sistema de ejes o el origen O en un extremo y la variable de posicion del elemento. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para carga positiva y vector campo, gris para la linea). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, vectores con flecha y subindices (lambda, dl, dq, r, d(vector)E, P, O). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: el vector dE debe apuntar desde el elemento de carga hacia P (repulsion de carga positiva) y r medido del elemento a P.

### `electricidad_y_magnetismo/simbologia_capacitores.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/simbologia_capacitores.png`
- **Descripcion:** Tabla de simbologia esquematica de capacitores: capacitor fijo (no polarizado), capacitor polarizado/electrolitico y capacitor variable.
- **Prompt:**

  > Diagrama tecnico 2D de SIMBOLOGIA DE CAPACITORES: una fila o tabla con los simbolos esquematicos estandar y su nombre debajo. 1) Capacitor fijo no polarizado: dos placas paralelas rectas iguales separadas, con terminales. 2) Capacitor polarizado (electrolitico): una placa recta (positiva, con signo +) y la otra curva (negativa), con terminales. 3) Capacitor variable: dos placas rectas paralelas atravesadas por una flecha diagonal. Cada simbolo con Lineas claras off-white nitidas y terminales de conexion a cada lado; rotulo en espanol debajo de cada uno. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acento rojo solo para el signo + del polarizado. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible (Capacitor fijo, Capacitor polarizado, Capacitor variable). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: usar los simbolos IEC/ANSI correctos, placa curva solo en el polarizado y flecha diagonal solo en el variable.

### `electricidad_y_magnetismo/solenoide.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/solenoide.png`
- **Descripcion:** Solenoide: bobina helicoidal de N espiras recorrida por corriente I, con campo magnetico interior uniforme y lineas de campo B.
- **Prompt:**

  > Diagrama tecnico 2D de un SOLENOIDE. Dibuja una bobina helicoidal en vista lateral como una serie de bucles/ovalos alineados horizontalmente (varias espiras), con los dos terminales conectados a una fuente que marca el sentido de la corriente con una flecha roja rotulada I. Dentro del solenoide dibuja lineas de campo magnetico rectas y paralelas al eje (flechas azules) rotuladas B apuntando en el sentido dado por la regla de la mano derecha; muestra las lineas cerrandose por fuera del solenoide (campo externo debil). Rotula N (numero de espiras) y la longitud L del solenoide con una linea de cota. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para corriente, azul para campo B, gris para el alambre). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, vectores con flecha (I, B, N, L). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: el sentido de B interior debe ser coherente con el sentido de la corriente segun la regla de la mano derecha y el campo interior debe verse uniforme.

### `electricidad_y_magnetismo/solenoide_largo.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/solenoide_largo.png`
- **Descripcion:** Solenoide largo ideal (longitud mucho mayor que el radio) con campo interior uniforme B = mu0 n I y campo exterior despreciable.
- **Prompt:**

  > Diagrama tecnico 2D de un SOLENOIDE LARGO IDEAL en corte/seccion. Dibuja un solenoide muy alargado (longitud L mucho mayor que el diametro) representado por dos filas horizontales de cortes de alambre: en la fila superior los conductores con corriente saliendo del plano (circulos con punto) y en la inferior con corriente entrando (circulos con cruz), o viceversa segun la regla de la mano derecha. En el interior dibuja varias lineas de campo rectas, densas, uniformes y paralelas al eje (flechas azules) rotuladas B; en el exterior muestra campo practicamente nulo. Rotula la relacion B = mu0 * n * I y n = N/L (espiras por unidad de longitud), con linea de cota para L. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo/azul para corriente segun convencion, azul para B, gris para conductores). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (B, mu0, n, N, L, I, simbolos punto/cruz). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: los sentidos punto/cruz de las dos filas deben ser opuestos y coherentes con el sentido de B interior; campo exterior despreciable.

### `electricidad_y_magnetismo/superficie_gaussiana.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/superficie_gaussiana.png`
- **Descripcion:** Superficie gaussiana cerrada (esfera) que encierra una carga puntual +q, con vectores de area dA salientes y campo E radial atravesandola.
- **Prompt:**

  > Diagrama tecnico 2D de una SUPERFICIE GAUSSIANA. Dibuja una superficie cerrada esferica representada como una circunferencia de trazo discontinuo gris. En su centro coloca una carga puntual positiva como un pequeno circulo rojo con signo +q. Desde el centro traza varias flechas rojas radiales que atraviesan la superficie apuntando hacia afuera, rotuladas E (campo electrico radial). En varios puntos de la superficie dibuja pequenos vectores normales salientes rotulados d(vector)A (perpendiculares a la superficie, hacia afuera). Rotula la superficie como S y anota el flujo phi = q/epsilon0. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para carga positiva y campo E, gris para la superficie). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, vectores con flecha y subindices (+q, E, d(vector)A, S, phi, epsilon0). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: para carga positiva E y dA apuntan radialmente hacia afuera y son paralelos sobre la esfera; la superficie es cerrada.

### `electricidad_y_magnetismo/superficie_infinita.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/superficie_infinita.png`
- **Descripcion:** Plano infinito con carga superficial uniforme sigma; campo electrico uniforme perpendicular saliendo por ambas caras.
- **Prompt:**

  > Diagrama tecnico 2D de un PLANO INFINITO CARGADO. Dibuja un plano vertical (visto de canto como una linea/franja vertical gris con marcas de signo + distribuidas uniformemente) que se extiende mas alla de los bordes de la imagen (con lineas de continuacion o flechas indicando que es infinito). Rotula la densidad superficial de carga sigma. A ambos lados del plano dibuja lineas de campo electrico rectas, paralelas, uniformemente espaciadas y perpendiculares al plano (flechas rojas) rotuladas E, apuntando alejandose del plano en los dos sentidos. Anota la magnitud E = sigma/(2 epsilon0). Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para carga positiva y campo E, gris para el plano). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (sigma, E, epsilon0). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: el campo debe ser uniforme (mismas longitud y espaciado a cualquier distancia), perpendicular al plano y en sentidos opuestos a cada lado para carga positiva.

### `electricidad_y_magnetismo/superficies_conductoras_cargadas_paralelas.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/superficies_conductoras_cargadas_paralelas.png`
- **Descripcion:** Dos placas conductoras paralelas con cargas opuestas (+sigma y -sigma) y campo electrico uniforme confinado entre ellas.
- **Prompt:**

  > Diagrama tecnico 2D de DOS SUPERFICIES CONDUCTORAS PARALELAS CARGADAS (condensador plano). Dibuja dos placas verticales paralelas grises separadas por una distancia d (linea de cota). La placa izquierda con signos + distribuidos y rotulada +sigma; la placa derecha con signos - y rotulada -sigma. Entre las placas dibuja lineas de campo electrico rectas, paralelas, uniformes y perpendiculares a las placas (flechas rojas) rotuladas E, apuntando de la placa positiva hacia la negativa. Fuera de las placas el campo es practicamente nulo (sin lineas). Anota E = sigma/epsilon0 y la separacion d. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para carga positiva y campo E, azul opcional para signos negativos, gris para placas conductoras). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (+sigma, -sigma, E, d, epsilon0). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: el campo interior debe ser uniforme y perpendicular, dirigido de la placa positiva a la negativa, y despreciable fuera.

### `electricidad_y_magnetismo/superficies_equipotenciales.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/superficies_equipotenciales.png`
- **Descripcion:** Superficies equipotenciales alrededor de una carga puntual: circunferencias concentricas perpendiculares a las lineas de campo radiales.
- **Prompt:**

  > Diagrama tecnico 2D de SUPERFICIES EQUIPOTENCIALES de una carga puntual. En el centro coloca una carga puntual positiva (circulo rojo con signo +q). Dibuja varias circunferencias concentricas de trazo discontinuo azul alrededor de la carga, rotuladas como equipotenciales V1 > V2 > V3 (mayor potencial cerca de la carga). Dibuja lineas de campo electrico rectas y radiales (flechas rojas) que salen de la carga, rotuladas E, cruzando SIEMPRE de forma perpendicular a las circunferencias equipotenciales. Anota que las lineas de campo son perpendiculares a las superficies equipotenciales. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para carga y campo E, azul para las equipotenciales). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (+q, E, V1, V2, V3). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: las equipotenciales deben ser circunferencias concentricas y las lineas de campo radiales perpendiculares a ellas en todo punto; el potencial decrece al alejarse.

### `electricidad_y_magnetismo/teorema_de_la_divergencia.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/teorema_de_la_divergencia.png`
- **Descripcion:** Teorema de la divergencia (Gauss): el flujo de un campo vectorial a traves de una superficie cerrada equivale a la integral de volumen de su divergencia.
- **Prompt:**

  > Diagrama tecnico 2D que ilustra el TEOREMA DE LA DIVERGENCIA (Gauss). Dibuja un volumen cerrado V representado por una region ovalada/blob 3D estilizada en 2D con su superficie frontera S (contorno gris cerrado). Sobre la superficie dibuja varios vectores normales salientes rotulados n (vector normal unitario) y flechas de un campo vectorial F que atraviesan la superficie hacia afuera (flechas rojas). Dentro del volumen dibuja pequenas flechas que representan el campo divergiendo desde el interior. Anota la igualdad del teorema en notacion clara: (integral cerrada sobre S) F . n dA = (integral sobre V) (div F) dV. Rotula S (superficie frontera) y V (volumen). Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para vectores de campo/flujo, gris para la superficie). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, notacion vectorial correcta (F, n, dA, dV, div F, S, V). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: S debe ser cerrada, las normales salientes, y la ecuacion debe relacionar la integral de superficie del flujo con la integral de volumen de la divergencia.

### `electricidad_y_magnetismo/teorema_del_rotacional.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/teorema_del_rotacional.png`
- **Descripcion:** Teorema del rotacional (Stokes): la circulacion de un campo alrededor de una curva cerrada equivale al flujo del rotacional a traves de la superficie que limita.
- **Prompt:**

  > Diagrama tecnico 2D que ilustra el TEOREMA DEL ROTACIONAL (Stokes). Dibuja una superficie abierta S (una tapa curva/domo estilizado en 2D) limitada por una curva cerrada de contorno C (linea negra cerrada) con una flecha que indica el sentido de recorrido. A lo largo de la curva C dibuja vectores tangentes del campo F (flechas rojas) rotulados F y el elemento d(vector)l. Sobre la superficie dibuja el vector normal n y pequenas flechas curvas/circulares que representan el rotacional rot F (o curl F) atravesando la superficie. Anota la igualdad: (integral cerrada sobre C) F . d(vector)l = (integral sobre S) (rot F) . n dA. Rotula C (curva frontera) y S (superficie). Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para vectores de campo, azul para el rotacional, gris para la superficie). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, notacion vectorial correcta (F, d(vector)l, n, rot F, dA, C, S). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: el sentido de recorrido de C y la normal n deben cumplir la regla de la mano derecha; S es abierta con frontera C.

### `electricidad_y_magnetismo/teoria_de_circuitos.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/teoria_de_circuitos.png`
- **Descripcion:** Circuito electrico basico de ejemplo para teoria de circuitos: fuente de tension, resistores y nodos/mallas.
- **Prompt:**

  > Diagrama tecnico 2D de un CIRCUITO ELECTRICO BASICO para ilustrar la teoria de circuitos. Dibuja un circuito rectangular con conductores rectos (Lineas claras off-white) que incluya: una fuente de tension continua a la izquierda (simbolo de baterias con placas larga/corta) rotulada V, con la polaridad + y - marcada; y dos o tres resistores (rectangulos IEC o zig-zag ANSI) rotulados R1, R2, R3 distribuidos en el circuito formando al menos dos mallas y varios nodos. Marca el sentido convencional de la corriente con flechas rojas rotuladas I (I1, I2 en las ramas). Marca los nodos con puntos gruesos. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acento rojo para el sentido de la corriente. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (V, R1, R2, R3, I1, I2, +, -). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: la topologia del circuito debe ser cerrada y coherente, con nodos y mallas bien definidos y polaridad de la fuente consistente con el sentido de la corriente.

### `electricidad_y_magnetismo/terminos_adicionales.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/terminos_adicionales.png`
- **Descripcion:** Diagrama auxiliar (nombre generico) que muestra terminos adicionales de un circuito/malla: fuentes, caidas de tension y elementos extra sumados en una ecuacion de malla de Kirchhoff.
- **Prompt:**

  > Diagrama tecnico 2D auxiliar que ilustra los TERMINOS ADICIONALES en una malla de circuito (aplicacion de la ley de voltajes de Kirchhoff). Dibuja una malla cerrada rectangular con conductores negros que contenga en serie: una fuente de tension V (simbolo de bateria con polaridad + y -), un resistor R con su caida de tension rotulada V_R = I*R (flecha de referencia de polaridad), y un elemento adicional (por ejemplo un segundo resistor o una fuente adicional) rotulado como termino adicional. Marca el sentido de recorrido de la malla con una flecha circular y el sentido de la corriente I con flecha roja. Junto al circuito escribe la ecuacion de malla con sus terminos sumados: V - I*R1 - I*R2 - ... = 0, resaltando el termino adicional. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acento rojo para corriente y polaridades. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (V, R1, R2, I, V_R). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: los signos de las caidas y fuentes deben ser consistentes con el sentido de recorrido de la malla (LVK). Nota: el nombre del archivo es generico; representar un esquema de malla con terminos de tension sumados.

### `electricidad_y_magnetismo/tierra_como_iman.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/tierra_como_iman.png`
- **Descripcion:** La Tierra como iman: dipolo magnetico terrestre con lineas de campo y la inversion entre polos geograficos y magneticos.
- **Prompt:**

  > Diagrama tecnico 2D de LA TIERRA COMO UN IMAN (dipolo magnetico terrestre). Dibuja la Tierra como una circunferencia con el eje de rotacion vertical marcado (linea vertical con el Polo Norte geografico arriba y el Polo Sur geografico abajo). Dentro dibuja una barra iman inclinada respecto al eje (pequeno rectangulo con mitades roja y azul) representando el dipolo, ligeramente desalineada del eje geografico. Dibuja las lineas de campo magnetico cerradas (curvas azules con flechas) que SALEN por el hemisferio sur magnetico y ENTRAN por el hemisferio norte magnetico, envolviendo el planeta. Rotula: Polo Norte geografico, Polo Sur geografico, polo sur magnetico (cerca del norte geografico) y polo norte magnetico (cerca del sur geografico), y las lineas de campo B. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para polo norte del iman, azul para polo sur del iman y lineas de campo, gris para la Tierra). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible (Polo Norte geografico, Polo Sur geografico, polo norte magnetico, polo sur magnetico, B). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: el polo SUR magnetico del dipolo terrestre esta cerca del Polo NORTE geografico (por eso la aguja de la brujula apunta al norte), y las lineas de campo entran por el norte geografico; el eje magnetico esta inclinado respecto al geografico.

### `electricidad_y_magnetismo/tipos_de_corriente_electrica.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/tipos_de_corriente_electrica.png`
- **Descripcion:** Tipos de corriente electrica: corriente continua (CC) como linea constante y corriente alterna (CA) como onda senoidal, en graficas de corriente vs tiempo.
- **Prompt:**

  > Diagrama tecnico 2D de los TIPOS DE CORRIENTE ELECTRICA mediante dos graficas de corriente contra tiempo, una al lado de la otra (o apiladas). Grafica 1 - Corriente continua (CC/DC): ejes i (eje vertical, corriente) y t (eje horizontal, tiempo); traza una linea horizontal recta constante por encima del eje t, rotulada CC (corriente continua). Grafica 2 - Corriente alterna (CA/AC): mismos ejes i y t; traza una onda senoidal simetrica que oscila por encima y por debajo del eje t (varios ciclos), rotulada CA (corriente alterna); marca el periodo T y la amplitud maxima Im. Cada grafica con su titulo. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas para ejes, curvas en rojo, relleno minimo. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (i, t, CC, CA, T, Im). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: la CC debe ser una recta horizontal constante y la CA una senoidal simetrica centrada en el eje de tiempo (media cero).

### `electricidad_y_magnetismo/tipos_de_transformadores.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/tipos_de_transformadores.png`
- **Descripcion:** Tipos de transformadores segun su relacion de transformacion: elevador, reductor y de aislamiento, con simbolos esquematicos y relacion de espiras.
- **Prompt:**

  > Diagrama tecnico 2D de TIPOS DE TRANSFORMADORES: tres simbolos esquematicos en fila con su nombre. Cada transformador se representa con dos bobinas (primario y secundario) dibujadas como series de bucles enfrentados y, entre ellas, dos lineas verticales paralelas que representan el nucleo. 1) Transformador ELEVADOR: primario con pocas espiras (Np) y secundario con muchas (Ns > Np), rotulado elevador. 2) Transformador REDUCTOR: primario con muchas espiras y secundario con pocas (Ns < Np), rotulado reductor. 3) Transformador de AISLAMIENTO: primario y secundario con igual numero de espiras (Np = Ns), rotulado aislamiento (relacion 1:1). Rotula en cada uno Vp, Np en el primario y Vs, Ns en el secundario, y la relacion Vs/Vp = Ns/Np. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, sin exceso de color. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (Np, Ns, Vp, Vs, elevador, reductor, aislamiento). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: la cantidad relativa de espiras dibujadas debe corresponder al tipo (mas espiras en el lado de mayor tension) y el simbolo de nucleo entre bobinas.

### `electricidad_y_magnetismo/transformador_con_nucleo_de_aire.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/transformador_con_nucleo_de_aire.png`
- **Descripcion:** Transformador con nucleo de aire: dos bobinas (primario y secundario) acopladas por induccion mutua sin nucleo ferromagnetico.
- **Prompt:**

  > Diagrama tecnico 2D de un TRANSFORMADOR CON NUCLEO DE AIRE. Dibuja dos bobinas separadas y proximas (primario a la izquierda, secundario a la derecha) representadas como series de bucles de alambre (helices en vista lateral) SIN nucleo ferromagnetico entre ellas (solo aire, sin las lineas del nucleo). El primario conectado a una fuente de tension alterna Vp con corriente Ip (flecha roja); el secundario conectado a una carga con Vs. Dibuja algunas lineas de campo magnetico (curvas azules) que enlazan parcialmente ambas bobinas indicando el acoplamiento por induccion mutua M (parte del flujo se dispersa por el aire). Rotula Np, Ip, Vp en el primario y Ns, Vs en el secundario, y la inductancia mutua M. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para corriente, azul para lineas de campo, gris para alambre). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (Np, Ns, Vp, Vs, Ip, M). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: NO debe haber nucleo ferromagnetico (solo aire); el acoplamiento es debil, con lineas de flujo que se dispersan y solo parte enlaza el secundario.

### `electricidad_y_magnetismo/transformador_con_nucleo_de_aire_1.png`

- **Target:** `landing/public/imagenes/electricidad_y_magnetismo/transformador_con_nucleo_de_aire_1.png`
- **Descripcion:** Transformador con nucleo de aire (variante): dos solenoides coaxiales acoplados por induccion mutua, mostrando el flujo compartido y el circuito equivalente.
- **Prompt:**

  > Diagrama tecnico 2D de un TRANSFORMADOR CON NUCLEO DE AIRE, variante de dos SOLENOIDES COAXIALES. Dibuja dos solenoides concentricos/coaxiales sobre el mismo eje horizontal (uno de menor radio dentro o junto a otro), ambos como series de bucles, sin nucleo ferromagnetico (medio aire). El solenoide primario (N1 espiras) conectado a una fuente alterna con corriente I1 (flecha roja); el secundario (N2 espiras) con terminales de salida V2. Dibuja lineas de campo axiales (flechas azules) rotuladas B a lo largo del eje que enlazan ambos solenoides, representando el flujo comun y la induccion mutua M. Anota la relacion de induccion mutua M = mu0 * N1 * N2 * A / l (para solenoides coaxiales largos). Rotula N1, I1 (primario) y N2, V2 (secundario), el radio y la longitud l. Estilo: diagrama tecnico 2D limpio tipo libro de texto de ingenieria, formato PNG, fondo solido navy #27283D, resolucion 1024x768 (4:3). Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion (rojo para corriente, azul para campo B, gris para alambre). Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos correctos (N1, N2, I1, V2, B, M, mu0, A, l). Solo los simbolos necesarios y correctos. Correccion tecnica obligatoria: los dos solenoides deben ser coaxiales, sin nucleo ferromagnetico, con el campo B axial que enlaza ambos; sentido de B coherente con I1 por la regla de la mano derecha.

---

## Geometria (18 imagenes)

### `geometria/area_y_perimetros_de_cuadrados/cuadrado.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_de_cuadrados/cuadrado.png`
- **Descripcion:** Cuadrado con lado etiquetado para calcular area y perimetro.
- **Prompt:**

  > Diagrama geometrico 2D de un CUADRADO perfecto (cuatro lados iguales, cuatro angulos rectos de 90 grados). Dibuja el contorno con Lineas claras off-white nitidas y relleno gris muy claro. Etiqueta un lado con la letra 'l' en azul. Marca los cuatro angulos rectos con el pequeno simbolo de cuadrado en una esquina. Opcional: en la parte inferior indica de forma discreta las formulas 'A = l^2' y 'P = 4l'. Composicion centrada. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, acentos azul para la dimension. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible, simbolos correctos. Correccion geometrica exacta: los cuatro lados deben ser visualmente iguales.

### `geometria/area_y_perimetros_de_cuadrados/rectangulo.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_de_cuadrados/rectangulo.png`
- **Descripcion:** Rectangulo con base y altura etiquetadas para area y perimetro.
- **Prompt:**

  > Diagrama geometrico 2D de un RECTANGULO (lados opuestos iguales, cuatro angulos rectos, base claramente mas larga que la altura). Contorno con Lineas claras off-white nitidas y relleno gris muy claro. Etiqueta la base horizontal con 'b' y la altura vertical con 'h' en azul, con lineas de cota discretas. Marca al menos un angulo recto con el simbolo de cuadrado. Opcional en la parte inferior: 'A = b x h' y 'P = 2b + 2h'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: angulos rectos reales y lados opuestos iguales.

### `geometria/area_y_perimetros_de_cuadrados/rombo.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_de_cuadrados/rombo.png`
- **Descripcion:** Rombo con lado y las dos diagonales etiquetadas.
- **Prompt:**

  > Diagrama geometrico 2D de un ROMBO (cuadrilatero con los cuatro lados iguales y angulos no rectos, dibujado como un diamante apoyado en un vertice). Contorno con Lineas claras off-white nitidas y relleno gris muy claro. Traza las dos DIAGONALES con linea negra fina punteada, etiquetadas 'D' (diagonal mayor) y 'd' (diagonal menor) en azul; marca su interseccion en el centro con un pequeno angulo recto (las diagonales son perpendiculares). Etiqueta un lado con 'l'. Opcional inferior: 'A = (D x d) / 2' y 'P = 4l'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: los cuatro lados iguales y las diagonales perpendiculares que se bisecan.

### `geometria/area_y_perimetros_de_cuadrados/romboide.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_de_cuadrados/romboide.png`
- **Descripcion:** Paralelogramo (romboide) con base y altura perpendicular.
- **Prompt:**

  > Diagrama geometrico 2D de un ROMBOIDE (paralelogramo inclinado: lados opuestos paralelos e iguales, sin angulos rectos). Contorno con Lineas claras off-white nitidas y relleno gris muy claro. Etiqueta la base horizontal con 'b' en azul. Traza la ALTURA 'h' como un segmento vertical punteado desde un vertice superior perpendicular a la base (o a su prolongacion), marcando el angulo recto entre la altura y la base. Etiqueta tambien el lado oblicuo con 'a'. Opcional inferior: 'A = b x h' y 'P = 2(a + b)'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: la altura debe ser perpendicular a la base, NO el lado inclinado.

### `geometria/area_y_perimetros_de_cuadrados/trapecio.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_de_cuadrados/trapecio.png`
- **Descripcion:** Trapecio con base mayor, base menor y altura.
- **Prompt:**

  > Diagrama geometrico 2D de un TRAPECIO (cuadrilatero con solo un par de lados paralelos: la base inferior mas larga y la base superior mas corta, horizontales y paralelas; lados laterales oblicuos). Contorno con Lineas claras off-white nitidas y relleno gris muy claro. Etiqueta la base inferior con 'B' (base mayor) y la superior con 'b' (base menor) en azul. Traza la ALTURA 'h' como segmento vertical punteado entre ambas bases, con marca de angulo recto en la base. Opcional inferior: 'A = ((B + b) / 2) x h'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: exactamente dos lados paralelos (las bases) y la altura perpendicular a ellas.

### `geometria/area_y_perimetros_de_triangulos/equilatero.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_de_triangulos/equilatero.png`
- **Descripcion:** Triangulo equilatero con lados iguales y altura.
- **Prompt:**

  > Diagrama geometrico 2D de un TRIANGULO EQUILATERO (tres lados iguales y tres angulos de 60 grados), apoyado en su base horizontal. Contorno con Lineas claras off-white nitidas y relleno gris muy claro. Marca los tres lados como iguales con una pequena marca (tick) en cada lado y etiqueta el lado con 'l' en azul. Indica los angulos internos de 60 grados. Traza la altura 'h' como segmento vertical punteado desde el vertice superior al punto medio de la base, con marca de angulo recto en la base. Opcional inferior: 'A = (l^2 x raiz(3)) / 4' y 'P = 3l'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: triangulo visualmente equilatero con los tres angulos iguales.

### `geometria/area_y_perimetros_de_triangulos/escaleno.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_de_triangulos/escaleno.png`
- **Descripcion:** Triangulo escaleno con los tres lados distintos y altura.
- **Prompt:**

  > Diagrama geometrico 2D de un TRIANGULO ESCALENO (los tres lados de longitud distinta y los tres angulos distintos, sin ningun angulo recto), apoyado en su base horizontal. Contorno con Lineas claras off-white nitidas y relleno gris muy claro. Etiqueta los tres lados con 'a', 'b' (base) y 'c' en azul, todos claramente diferentes. Traza la altura 'h' como segmento vertical punteado desde el vertice superior perpendicular a la base 'b', con marca de angulo recto. Opcional inferior: 'A = (b x h) / 2' y 'P = a + b + c'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: los tres lados y angulos deben verse claramente desiguales.

### `geometria/area_y_perimetros_de_triangulos/isosceles.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_de_triangulos/isosceles.png`
- **Descripcion:** Triangulo isosceles con dos lados iguales y altura.
- **Prompt:**

  > Diagrama geometrico 2D de un TRIANGULO ISOSCELES (dos lados iguales y una base distinta, simetrico respecto a su eje vertical), apoyado en su base horizontal. Contorno con Lineas claras off-white nitidas y relleno gris muy claro. Marca los dos lados iguales con doble tick y etiquetalos 'l'; etiqueta la base con 'b' en azul. Indica que los dos angulos de la base son iguales. Traza la altura 'h' como segmento vertical punteado desde el vertice superior al punto medio de la base, con marca de angulo recto. Opcional inferior: 'A = (b x h) / 2' y 'P = 2l + b'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: simetria clara con dos lados iguales.

### `geometria/area_y_perimetros_del_circulo.png`

- **Target:** `landing/public/imagenes/geometria/area_y_perimetros_del_circulo.png`
- **Descripcion:** Circulo con centro, radio y diametro para area y circunferencia.
- **Prompt:**

  > Diagrama geometrico 2D de un CIRCULO. Traza la circunferencia con linea negra nitida y relleno gris muy claro. Marca el centro con un punto 'O'. Dibuja el RADIO 'r' como segmento en azul desde el centro hasta la circunferencia, con punta de flecha o marca de longitud. Dibuja tambien el DIAMETRO 'd' como segmento que cruza el centro de lado a lado (d = 2r), en un tono mas tenue. Opcional inferior: 'A = pi x r^2' y 'P = 2 x pi x r'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible, simbolo pi correcto. Correccion geometrica exacta: circulo perfecto, radio desde el centro y diametro pasando por el centro.

### `geometria/elipse_centro_en_el_origen.png`

- **Target:** `landing/public/imagenes/geometria/elipse_centro_en_el_origen.png`
- **Descripcion:** Elipse centrada en el origen con semiejes a y b y focos.
- **Prompt:**

  > Diagrama de geometria analitica 2D de una ELIPSE centrada en el ORIGEN de un plano cartesiano. Dibuja los ejes X e Y con flechas y el origen 'O'. Traza la elipse (mas ancha horizontalmente) con linea negra nitida y relleno gris muy claro. Marca el SEMIEJE MAYOR 'a' sobre el eje X (del centro al vertice) y el SEMIEJE MENOR 'b' sobre el eje Y, ambos en azul. Marca los dos FOCOS F1 y F2 sobre el eje X como puntos rojos, con la distancia focal 'c'. Rotula los vertices (a,0), (-a,0), (0,b), (0,-b). Opcional: ecuacion 'x^2/a^2 + y^2/b^2 = 1'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul para semiejes y rojo para focos. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion matematica exacta: focos sobre el eje mayor, a > b, elipse simetrica respecto a ambos ejes.

### `geometria/hiperbola.png`

- **Target:** `landing/public/imagenes/geometria/hiperbola.png`
- **Descripcion:** Hiperbola centrada en el origen con vertices, focos y asintotas.
- **Prompt:**

  > Diagrama de geometria analitica 2D de una HIPERBOLA horizontal centrada en el ORIGEN de un plano cartesiano. Dibuja los ejes X e Y con flechas y el origen 'O'. Traza las dos ramas de la hiperbola (abriendo hacia izquierda y derecha) con linea negra nitida. Dibuja las dos ASINTOTAS como rectas diagonales punteadas grises que pasan por el origen. Marca los VERTICES (a,0) y (-a,0) en azul y los FOCOS F1 y F2 sobre el eje X como puntos rojos, con 'c' > 'a'. Opcional: ecuacion 'x^2/a^2 - y^2/b^2 = 1'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acentos azul para vertices y rojo para focos. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion matematica exacta: las ramas se aproximan a las asintotas sin tocarlas, focos mas alejados que los vertices.

### `geometria/parabola_con_vertice_en_el_origen.png`

- **Target:** `landing/public/imagenes/geometria/parabola_con_vertice_en_el_origen.png`
- **Descripcion:** Parabola con vertice en el origen, foco y directriz.
- **Prompt:**

  > Diagrama de geometria analitica 2D de una PARABOLA con VERTICE en el ORIGEN, abriendo hacia arriba. Dibuja los ejes X e Y con flechas y el vertice 'V' en el origen. Traza la parabola simetrica respecto al eje Y con linea negra nitida. Marca el FOCO 'F' sobre el eje Y positivo como punto rojo a distancia 'p' del vertice. Dibuja la DIRECTRIZ como una recta horizontal punteada gris debajo del vertice, a distancia 'p' (y = -p). Opcional: ecuacion 'x^2 = 4py'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, relleno minimo, acento rojo para el foco. Flat, sin sombras 3D ni fotorrealismo. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion matematica exacta: foco dentro de la curva y directriz al lado opuesto, ambos a igual distancia del vertice.

### `geometria/volumen_de_cuerpos_geometricos/cono.png`

- **Target:** `landing/public/imagenes/geometria/volumen_de_cuerpos_geometricos/cono.png`
- **Descripcion:** Cono recto con radio de la base y altura para volumen.
- **Prompt:**

  > Diagrama geometrico en 2D con perspectiva sencilla de un CONO circular recto. Dibuja el cono con contorno negro nitido: base como elipse (para dar perspectiva) con la mitad frontal en linea solida y la trasera punteada, y un apice en la punta superior. Marca el RADIO 'r' de la base como segmento azul del centro al borde, y la ALTURA 'h' como segmento vertical punteado desde el centro de la base al apice, con marca de angulo recto en la base. Opcional inferior: 'V = (1/3) x pi x r^2 x h'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, aristas ocultas punteadas, relleno minimo, acentos azul. Flat, sin sombras 3D fotorrealistas ni degradados. Sin texto natural; usar solo simbolos universales, sans-serif legible, simbolo pi correcto. Correccion geometrica exacta: altura perpendicular a la base pasando por el centro.

### `geometria/volumen_de_cuerpos_geometricos/cubo.png`

- **Target:** `landing/public/imagenes/geometria/volumen_de_cuerpos_geometricos/cubo.png`
- **Descripcion:** Cubo con arista etiquetada para volumen.
- **Prompt:**

  > Diagrama geometrico en 2D con perspectiva isometrica sencilla de un CUBO (hexaedro regular, tres aristas iguales). Dibuja el cubo con contorno negro nitido; las tres aristas visibles frontales en linea solida y las tres aristas ocultas del fondo en linea punteada. Etiqueta una arista con 'l' (o 'a') en azul. Opcional inferior: 'V = l^3'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, aristas ocultas punteadas, sin relleno o relleno gris muy claro, acento azul en la arista. Flat, sin sombras 3D fotorrealistas ni degradados. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: las tres dimensiones iguales, caras cuadradas en perspectiva coherente.

### `geometria/volumen_de_cuerpos_geometricos/esfera.png`

- **Target:** `landing/public/imagenes/geometria/volumen_de_cuerpos_geometricos/esfera.png`
- **Descripcion:** Esfera con radio etiquetado para volumen.
- **Prompt:**

  > Diagrama geometrico en 2D con perspectiva sencilla de una ESFERA. Dibuja el circulo exterior con contorno negro nitido y anade una elipse ecuatorial (linea frontal solida, mitad trasera punteada) para sugerir el volumen 3D. Marca el centro 'O' y el RADIO 'r' como segmento azul del centro a la superficie, con flecha o marca de longitud. Opcional inferior: 'V = (4/3) x pi x r^3'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, elipse de referencia punteada atras, relleno minimo, acento azul en el radio. Flat, sin sombras 3D fotorrealistas ni degradados de iluminacion. Sin texto natural; usar solo simbolos universales, sans-serif legible, simbolo pi correcto. Correccion geometrica exacta: radio desde el centro.

### `geometria/volumen_de_cuerpos_geometricos/piramide.png`

- **Target:** `landing/public/imagenes/geometria/volumen_de_cuerpos_geometricos/piramide.png`
- **Descripcion:** Piramide de base cuadrada con lado de la base y altura.
- **Prompt:**

  > Diagrama geometrico en 2D con perspectiva sencilla de una PIRAMIDE de base cuadrada. Dibuja la base cuadrada en perspectiva (aristas frontales solidas, aristas del fondo punteadas) y un apice superior unido a los cuatro vertices por aristas. Etiqueta el lado de la base con 'l' (o 'b') en azul y traza la ALTURA 'h' como segmento vertical punteado desde el centro de la base al apice, con marca de angulo recto en la base. Opcional inferior: 'V = (1/3) x A_base x h'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, aristas ocultas punteadas, relleno minimo, acentos azul. Flat, sin sombras 3D fotorrealistas ni degradados. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: altura desde el centro de la base perpendicular a ella, apice sobre el centro.

### `geometria/volumen_de_cuerpos_geometricos/prisma_circular.png`

- **Target:** `landing/public/imagenes/geometria/volumen_de_cuerpos_geometricos/prisma_circular.png`
- **Descripcion:** Cilindro (prisma circular) con radio de la base y altura.
- **Prompt:**

  > Diagrama geometrico en 2D con perspectiva sencilla de un PRISMA CIRCULAR (cilindro recto). Dibuja el cilindro con contorno negro nitido: base superior e inferior como elipses (mitad frontal solida, mitad trasera punteada) unidas por dos generatrices verticales. Marca el RADIO 'r' de la base como segmento azul del centro al borde de la elipse superior, y la ALTURA 'h' como segmento vertical a un costado entre ambas bases. Opcional inferior: 'V = pi x r^2 x h'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, bordes ocultos punteados, relleno minimo, acentos azul. Flat, sin sombras 3D fotorrealistas ni degradados. Sin texto natural; usar solo simbolos universales, sans-serif legible, simbolo pi correcto. Correccion geometrica exacta: eje del cilindro perpendicular a las bases, ambas bases circulares iguales.

### `geometria/volumen_de_cuerpos_geometricos/prisma_pentagonal.png`

- **Target:** `landing/public/imagenes/geometria/volumen_de_cuerpos_geometricos/prisma_pentagonal.png`
- **Descripcion:** Prisma de base pentagonal con altura para volumen.
- **Prompt:**

  > Diagrama geometrico en 2D con perspectiva sencilla de un PRISMA PENTAGONAL RECTO (dos bases pentagonales regulares paralelas unidas por caras rectangulares). Dibuja el prisma con contorno negro nitido: la base pentagonal frontal en linea solida y la base trasera desplazada con las aristas ocultas punteadas, unidas por aristas laterales. Marca la ALTURA (longitud del prisma) 'h' como segmento entre las dos bases en azul, y opcionalmente el lado 'l' del pentagono y el apotema 'ap'. Opcional inferior: 'V = A_base x h'. Formato PNG, fondo solido navy #27283D, ~1024x768. Estilo diagrama tecnico limpio tipo libro de texto: Lineas claras off-white nitidas, aristas ocultas punteadas, relleno minimo, acentos azul. Flat, sin sombras 3D fotorrealistas ni degradados. Sin texto natural; usar solo simbolos universales, sans-serif legible. Correccion geometrica exacta: pentagono regular (cinco lados iguales) y bases paralelas congruentes con las caras laterales rectangulares.

---

## Preguntas frecuentes (19 imagenes)

> **Actualización obligatoria, 2026-07-13.** Los prompts individuales
> históricos que siguen debajo se conservan solo como inventario de paths y no
> se deben usar para generar o sustituir assets. Pedían mockups, capturas y
> texto localizado, por lo que contradicen el contrato visual canónico. Para
> cualquiera de las 19 rutas FAQ usa exclusivamente los prompts de reemplazo
> de esta subsección. Ningún bitmap FAQ puede incluir palabras, títulos,
> controles de una UI, nombres de red, números de paso escritos ni cursores.

### Prompts canónicos de reemplazo

Todos los pictogramas FAQ son PNG salvo `trespuntos.jpg` y `opcionespdf.jpg`,
que conservan su formato JPG histórico. Fondo opaco navy `#27283D`, 1024x768,
líneas off-white, acento dorado `#F3A73D`, flat 2D y sin texto natural.

| Targets | Prompt canónico sin idioma |
| --- | --- |
| `entrada_con_negativo.png` | Pictograma de una celda numérica abstracta: símbolo menos rojo seguido de dígitos neutros y un teclado de símbolos formado solo por `-`, `+`, `.` y dígitos. Resaltar el menos con aro dorado. Sin etiqueta de campo ni cursor. |
| `entrada_con_punto.png` | Pictograma de dos grupos de dígitos separados por un punto decimal destacado en dorado, con una cuadrícula de teclado formada solo por dígitos y `.`. Sin palabras ni controles de sistema. |
| `entrada_sin_nada.png` | Pictograma de celda numérica vacía representada por contorno y guion bajo, junto a un símbolo de advertencia neutro. Sin texto ni placeholder escrito. |
| `formula_cortada.png`, `menu_display.png` | Diagrama de una fórmula simbólica larga recortada por dos bordes verticales, con flechas hacia dentro y un icono universal de ajuste `Aa` sin palabras. Para `menu_display`, mostrar únicamente el icono de ajuste y barras de tamaño. |
| `font_size.png`, `font_size_cambiar.png`, `font_size_terminado.png` | Secuencia de pictogramas de slider: estado grande, perilla moviéndose a la izquierda con flecha, y fórmula simbólica completa dentro de un marco con check. Usar solo `Aa`, barras, flechas y check, nunca valores numéricos o labels. |
| `raices.png`, `resultado_nan.png` | Símbolo matemático `√` con radicando negativo en rojo y triángulo de advertencia; para el resultado, un símbolo indefinido `∅` o `?` dentro de una tarjeta abstracta. No escribir `NaN` ni explicación textual. |
| `tres_puntos.png`, `trespuntos.jpg` | Pictograma de tres puntos verticales dentro de un aro dorado y una mano abstracta de toque sin texto, sin barra de aplicación ni título. |
| `botones.png` | Cuatro iconos universales de línea, compartir, guardar, documento y estrella. Resaltar el documento con dorado. No usar iconos con palabras ni una captura de interfaz. |
| `opciones_pdf.png`, `opcionespdf.jpg` | Documento con pliegue, tres toggles geométricos sin labels y una flecha de exportación dorada. No dibujar diálogo, botones ni copy. |
| `conexion_1.png`, `conexion_2.png`, `conexion_3.png`, `conexion_4.png` | Secuencia visual: Wi-Fi tachado, ondas Wi-Fi con interruptor abstracto, ondas completas con check y onda completa junto a un icono de reproducción. Identificar el orden solo por composición, sin números, etiquetas de red ni mensajes. |

Los entries históricos que siguen no son instrucciones de producción. Si hay que
regenerar una ruta FAQ, se usa el mapping anterior y se valida con
`bun run check:formulae-images` más revisión visual de la pantalla consumidora.

### `preguntas_frecuentes/entrada_negativa/entrada_con_negativo.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/entrada_negativa/entrada_con_negativo.png`
- **Descripcion:** Captura de UI (FAQ): campo de entrada de una formula mostrando como escribir un numero negativo usando el signo menos.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de una app movil de formularios de ingenieria. Muestra una tarjeta blanca con la etiqueta de una variable a la izquierda (por ejemplo 'Valor:') y un campo de entrada numerico a la derecha en el que se ha escrito un numero NEGATIVO: '-25.4', con el signo menos claramente visible al inicio y un cursor de texto parpadeante despues del ultimo digito. Debajo un teclado numerico compacto con teclas 0-9, punto decimal '.' y una tecla de signo '±' o '-' resaltada en naranja para indicar como se introduce el negativo. El signo menos y la tecla de signo se destacan en rojo/naranja. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos de color con moderacion (naranja/dorado #F3A73D como color de marca para botones/acentos, azul para elementos activos, rojo para errores/negativos). Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/entrada_negativa/entrada_con_punto.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/entrada_negativa/entrada_con_punto.png`
- **Descripcion:** Captura de UI (FAQ): campo de entrada mostrando como escribir un numero decimal usando el punto.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de una app movil de formularios de ingenieria. Muestra una tarjeta blanca con la etiqueta de una variable (por ejemplo 'Valor:') y un campo de entrada numerico en el que se ha escrito un numero DECIMAL con punto: '3.1416', con el punto decimal '.' claramente visible entre el 3 y el 1, y un cursor de texto al final. Debajo un teclado numerico compacto con teclas 0-9 y una tecla de PUNTO DECIMAL '.' resaltada en naranja para indicar como se introduce el decimal. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos de color con moderacion (naranja/dorado #F3A73D como color de marca para botones/acentos, azul para elementos activos, rojo para errores/negativos). Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/entrada_negativa/entrada_sin_nada.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/entrada_negativa/entrada_sin_nada.png`
- **Descripcion:** Captura de UI (FAQ): campo de entrada vacio con texto de marcador (placeholder), estado inicial sin valor.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de una app movil de formularios de ingenieria. Muestra una tarjeta blanca con la etiqueta de una variable (por ejemplo 'Valor:') y un campo de entrada numerico VACIO, sin ningun numero escrito, mostrando solo un texto de marcador tenue en gris claro ('Ingresa un valor') y un cursor de texto al inicio. Debajo un teclado numerico compacto con teclas 0-9 y punto, en estado neutro sin ninguna tecla resaltada. Transmite el estado inicial 'sin nada escrito'. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos de color con moderacion (naranja/dorado #F3A73D como color de marca para botones/acentos, azul para elementos activos, rojo para errores/negativos). Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/formula_cortada/formula_cortada.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/formula_cortada/formula_cortada.png`
- **Descripcion:** Captura de UI (FAQ): una formula matematica larga que aparece cortada/desbordada en el borde de la pantalla, ilustrando el problema.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de una app movil de formularios de ingenieria. Muestra una tarjeta blanca de resultado con una FORMULA MATEMATICA LARGA renderizada (por ejemplo una raiz cuadrada con fraccion y varios terminos) que se sale del ancho de la tarjeta y aparece CORTADA en el borde derecho de la pantalla, con parte de los simbolos ocultos por el margen, ilustrando el problema de 'formula cortada'. El borde derecho donde se corta el texto se marca sutilmente con una linea/degradado rojo tenue para indicar el desbordamiento. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos de color con moderacion (naranja/dorado #F3A73D como color de marca para botones/acentos, azul para elementos activos, rojo para errores/desbordes). Tipografia sans-serif legible y notacion matematica correcta (raiz, fraccion, subindices). Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/formula_cortada/menu_display.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/formula_cortada/menu_display.png`
- **Descripcion:** Captura de UI (FAQ): menu de opciones de visualizacion (display) abierto, con la opcion de tamano de fuente resaltada.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de una app movil de formularios de ingenieria con un MENU DE OPCIONES DE VISUALIZACION desplegado. En la parte superior una barra de app con titulo; desde un icono de tres puntos o de ajustes se despliega un menu con una lista de opciones en espanol: 'Tamano de fuente', 'Modo oscuro', 'Ver como PDF', 'Compartir'. La opcion 'Tamano de fuente' esta resaltada (fondo naranja/dorado claro) como paso a elegir para arreglar una formula cortada. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos de color con moderacion (naranja/dorado #F3A73D como color de marca para botones/acentos, azul para elementos activos). Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/formula_cortada/font_size.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/formula_cortada/font_size.png`
- **Descripcion:** Captura de UI (FAQ): pantalla de ajuste de tamano de fuente mostrando el tamano actual antes de cambiarlo.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de ajuste de TAMANO DE FUENTE de una app movil de formularios de ingenieria. Titulo 'Tamano de fuente'. Muestra un control deslizante (slider) horizontal con su perilla hacia un valor grande (por ejemplo cerca del maximo), una etiqueta numerica del tamano actual (por ejemplo '22'), y un texto de vista previa 'Aa Vista previa' mostrado en letra grande. Estado inicial antes de cambiar. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, la barra del slider y la perilla en naranja/dorado #F3A73D. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/formula_cortada/font_size_cambiar.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/formula_cortada/font_size_cambiar.png`
- **Descripcion:** Captura de UI (FAQ): usuario arrastrando el deslizador para reducir el tamano de fuente.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de ajuste de TAMANO DE FUENTE de una app movil de formularios de ingenieria, en el momento de CAMBIAR el valor. Titulo 'Tamano de fuente'. El control deslizante (slider) horizontal se muestra con la perilla siendo arrastrada hacia un valor MENOR (posicion mas a la izquierda que el estado anterior), con un icono de dedo/cursor sobre la perilla y una etiqueta numerica menor (por ejemplo '14'). El texto de vista previa 'Aa Vista previa' aparece mas pequeno que antes. Transmite la accion de reducir el tamano. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, la barra del slider y la perilla en naranja/dorado #F3A73D. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/formula_cortada/font_size_terminado.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/formula_cortada/font_size_terminado.png`
- **Descripcion:** Captura de UI (FAQ): resultado final, la formula ahora se ve completa tras reducir el tamano de fuente.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de una app movil de formularios de ingenieria mostrando el RESULTADO FINAL tras reducir el tamano de fuente. Una tarjeta blanca de resultado contiene la misma FORMULA MATEMATICA larga (raiz cuadrada con fraccion y varios terminos) ahora completamente VISIBLE dentro de los margenes de la tarjeta, sin cortarse en el borde, en un tamano de letra menor. Un pequeno indicador verde de exito (check) sugiere que el problema quedo resuelto. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos de color con moderacion (naranja/dorado #F3A73D de marca, verde para exito). Tipografia sans-serif legible y notacion matematica correcta (raiz, fraccion, subindices). Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/nan/raices.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/nan/raices.png`
- **Descripcion:** Captura de UI (FAQ): entrada de una raiz cuadrada con radicando negativo, causa comun de resultado NaN.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de una app movil de formularios de ingenieria mostrando el caso de una RAIZ CUADRADA que produce error. Una tarjeta blanca muestra una formula con el simbolo de raiz cuadrada correcto (radical) aplicada a un valor NEGATIVO, por ejemplo la raiz de -16, con el numero negativo resaltado en rojo para indicar que es la causa del problema (no existe raiz cuadrada real de un negativo). Debajo un campo de entrada con el valor '-16'. Notacion matematica correcta del radical cubriendo todo el radicando. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos de color con moderacion (naranja/dorado #F3A73D de marca, rojo para el valor problematico). Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/nan/resultado_nan.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/nan/resultado_nan.png`
- **Descripcion:** Captura de UI (FAQ): tarjeta de resultado mostrando el texto 'NaN' como resultado de una operacion no valida.
- **Prompt:**

  > Mockup UI plano 2D de la pantalla de una app movil de formularios de ingenieria mostrando una tarjeta de RESULTADO con el valor 'NaN' (No es un numero) desplegado en grande donde normalmente iria el resultado numerico, resaltado en rojo, acompanado de un pequeno icono de advertencia (triangulo) y un texto explicativo breve en gris: 'Resultado no valido: revisa los datos ingresados'. Ilustra el caso de un resultado NaN. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos de color con moderacion (naranja/dorado #F3A73D de marca, rojo para el error y la advertencia). Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/pdf/tres_puntos.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/pdf/tres_puntos.png`
- **Descripcion:** Captura de UI (FAQ): icono de menu de tres puntos (overflow) en la barra superior de la app, primer paso para exportar PDF.
- **Prompt:**

  > Mockup UI plano 2D de la barra superior (app bar) de una app movil de formularios de ingenieria. Muestra el titulo de la formula a la izquierda y, a la derecha, el ICONO DE MENU DE TRES PUNTOS verticales (overflow) claramente resaltado dentro de un circulo/marco naranja para senalarlo como el boton a pulsar. Un pequeno cursor o indicacion de toque sobre el icono. Ilustra el primer paso para exportar a PDF. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, el icono de tres puntos y su marco resaltados en naranja/dorado #F3A73D. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/pdf/trespuntos.jpg`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/pdf/trespuntos.jpg`
- **Descripcion:** Captura de UI (FAQ): variante JPG del icono de menu de tres puntos (overflow) en la barra superior; equivalente a tres_puntos.png.
- **Prompt:**

  > Mockup UI plano 2D de la barra superior (app bar) de una app movil de formularios de ingenieria (variante en formato JPG). Muestra el titulo de la formula a la izquierda y, a la derecha, el ICONO DE MENU DE TRES PUNTOS verticales (overflow) claramente resaltado dentro de un marco naranja para senalarlo como el boton a pulsar, con indicacion de toque. Ilustra el primer paso para exportar a PDF. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, el icono de tres puntos y su marco resaltados en naranja/dorado #F3A73D. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato JPG (fondo solido navy #27283D), ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/pdf/botones.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/pdf/botones.png`
- **Descripcion:** Captura de UI (FAQ): fila de botones de accion de la app (compartir, guardar, exportar PDF) relacionados con la exportacion.
- **Prompt:**

  > Mockup UI plano 2D de una app movil de formularios de ingenieria mostrando una FILA DE BOTONES DE ACCION en la parte inferior o dentro de una tarjeta. Se ven botones con icono y Sin texto natural; usar solo iconos y simbolos universales: 'Compartir', 'Guardar', 'Ver PDF' y 'Favorito', dispuestos en fila. El boton 'Ver PDF' esta resaltado en naranja/dorado como el relevante para exportar a PDF. Iconos simples de linea (flecha de compartir, disquete, documento PDF, estrella). Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos en naranja/dorado #F3A73D de marca. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/pdf/opciones_pdf.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/pdf/opciones_pdf.png`
- **Descripcion:** Captura de UI (FAQ): dialogo de opciones de exportacion a PDF de la app.
- **Prompt:**

  > Mockup UI plano 2D de una app movil de formularios de ingenieria mostrando un DIALOGO DE OPCIONES DE PDF. Un panel/hoja inferior oscuro (superficie navy #393A5D, textos claros) con titulo 'Opciones de PDF' y una lista de opciones en espanol con casillas o interruptores: 'Incluir datos ingresados', 'Incluir resultado', 'Incluir diagrama', 'Tamano de pagina: Carta'. Al pie dos botones: 'Cancelar' (contorno gris) y 'Generar PDF' (relleno naranja/dorado). Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos y boton primario en naranja/dorado #F3A73D, interruptores activos en azul. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/pdf/opcionespdf.jpg`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/pdf/opcionespdf.jpg`
- **Descripcion:** Captura de UI (FAQ): variante JPG del dialogo de opciones de exportacion a PDF; equivalente a opciones_pdf.png.
- **Prompt:**

  > Mockup UI plano 2D de una app movil de formularios de ingenieria mostrando un DIALOGO DE OPCIONES DE PDF (variante en formato JPG). Un panel/hoja inferior oscuro (superficie navy #393A5D, textos claros) con titulo 'Opciones de PDF' y una lista de opciones en espanol con casillas o interruptores: 'Incluir datos ingresados', 'Incluir resultado', 'Incluir diagrama', 'Tamano de pagina: Carta'. Al pie dos botones: 'Cancelar' (contorno gris) y 'Generar PDF' (relleno naranja/dorado). Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos y boton primario en naranja/dorado #F3A73D, interruptores activos en azul. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato JPG (fondo solido navy #27283D), ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/wifi/conexion_1.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/wifi/conexion_1.png`
- **Descripcion:** Captura de UI (FAQ): paso 1 de conexion, la app muestra un mensaje de que no hay conexion a internet.
- **Prompt:**

  > Mockup UI plano 2D de una app movil de formularios de ingenieria, PASO 1 de una secuencia de solucion de conexion. Pantalla con un icono grande de WiFi TACHADO/SIN SENAL en gris y un mensaje en espanol 'Sin conexion a internet' con un subtexto 'Revisa tu conexion para continuar'. Un boton 'Reintentar' en naranja/dorado al centro. Una etiqueta discreta de 'Paso 1' o numero '1' en una esquina. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acentos en naranja/dorado #F3A73D, icono de error en gris/rojo tenue. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/wifi/conexion_2.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/wifi/conexion_2.png`
- **Descripcion:** Captura de UI (FAQ): paso 2 de conexion, el usuario abre los ajustes de WiFi del dispositivo.
- **Prompt:**

  > Mockup UI plano 2D del panel de AJUSTES DE WIFI de un telefono, PASO 2 de una secuencia de solucion de conexion. Pantalla de ajustes con titulo 'Wi-Fi', un interruptor de Wi-Fi en la parte superior en posicion ENCENDIDO (resaltado en naranja/dorado) y una lista de redes disponibles con iconos de senal WiFi, una de ellas seleccionada con un check. Una etiqueta discreta de 'Paso 2' o numero '2' en una esquina. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, interruptor activo y acentos en naranja/dorado #F3A73D. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/wifi/conexion_3.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/wifi/conexion_3.png`
- **Descripcion:** Captura de UI (FAQ): paso 3 de conexion, el dispositivo se conecta a una red WiFi con indicador de conectado.
- **Prompt:**

  > Mockup UI plano 2D del panel de AJUSTES DE WIFI de un telefono, PASO 3 de una secuencia de solucion de conexion. Muestra la red WiFi seleccionada ahora con la etiqueta 'Conectado' debajo del nombre de la red y un icono de senal WiFi completa en verde/azul, indicando conexion establecida. Una etiqueta discreta de 'Paso 3' o numero '3' en una esquina. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acento de conectado en verde, marca en naranja/dorado #F3A73D. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

### `preguntas_frecuentes/wifi/conexion_4.png`

- **Target:** `landing/public/imagenes/preguntas_frecuentes/wifi/conexion_4.png`
- **Descripcion:** Captura de UI (FAQ): paso 4 de conexion, la app vuelve a funcionar con conexion restablecida.
- **Prompt:**

  > Mockup UI plano 2D de una app movil de formularios de ingenieria, PASO 4 (final) de una secuencia de solucion de conexion. La app vuelve a su pantalla normal con el contenido cargado correctamente, un icono de WiFi con senal completa en la barra superior y un mensaje breve de exito en verde 'Conexion restablecida' o un pequeno check verde. Una etiqueta discreta de 'Paso 4' o numero '4' en una esquina. Estilo: mockup UI plano 2D limpio de una app movil de ingenieria, tipo captura ilustrada de manual/FAQ. fondo solido navy #27283D, sin sombras 3D, sin fotorrealismo. Lineas claras off-white nitidas, acento de exito en verde, marca en naranja/dorado #F3A73D. Tipografia sans-serif legible. Sin texto natural; la UI localizada aporta las instrucciones. Formato PNG, fondo solido navy #27283D, ~1024x768 (4:3). Nota: es una captura de UI, no un diagrama tecnico; puede reemplazarse por una captura real de la app.

---

## Matematicas discretas y raiz / trigonometria (15 imagenes)

### `matematicas_discretas/negacion.png`

- **Target:** `landing/public/imagenes/matematicas_discretas/negacion.png`
- **Descripcion:** Tabla de verdad de la negacion logica (NOT), un operador unario con dos filas.
- **Prompt:**

  > Genera un diagrama de una tabla de verdad para la NEGACION logica (operador NOT, unario). Dibuja una tabla limpia de dos columnas con encabezados 'p' y '¬p' (negacion de p). Debajo, dos filas de datos con los valores exactos: fila 1 = p:1, ¬p:0; fila 2 = p:0, ¬p:1. Usa 0 para falso y 1 para verdadero. No incluir titulo natural. Bordes de tabla en Lineas claras off-white nitidas, celdas de igual tamaño, encabezado con fondo gris muy claro. Correccion logica absoluta: la negacion invierte el valor de verdad. Estilo obligatorio: PNG, fondo solido navy #27283D, resolucion ~1024x768 (4:3). Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolos logicos correctos (¬). Solo los simbolos necesarios y correctos.

### `matematicas_discretas/conjuncion.png`

- **Target:** `landing/public/imagenes/matematicas_discretas/conjuncion.png`
- **Descripcion:** Tabla de verdad de la conjuncion logica (AND, p ∧ q), cuatro filas.
- **Prompt:**

  > Genera un diagrama de una tabla de verdad para la CONJUNCION logica (AND, p ∧ q). Tabla limpia de tres columnas con encabezados 'p', 'q' y 'p ∧ q'. Cuatro filas de datos con los valores exactos: (1,1 → 1), (1,0 → 0), (0,1 → 0), (0,0 → 0). Usa 0 para falso y 1 para verdadero. No incluir titulo natural. La conjuncion solo es verdadera cuando ambas proposiciones son verdaderas. Bordes de tabla en Lineas claras off-white nitidas, celdas de igual tamaño, encabezado con fondo gris muy claro. Correccion logica absoluta. Estilo obligatorio: PNG, fondo solido navy #27283D, resolucion ~1024x768 (4:3). Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolo ∧ correcto. Solo los simbolos necesarios y correctos.

### `matematicas_discretas/tabla_de_verdad_disyuncion_1.png`

- **Target:** `landing/public/imagenes/matematicas_discretas/tabla_de_verdad_disyuncion_1.png`
- **Descripcion:** Tabla de verdad de la disyuncion inclusiva (OR, p ∨ q), cuatro filas.
- **Prompt:**

  > Genera un diagrama de una tabla de verdad para la DISYUNCION inclusiva (OR, p ∨ q). Tabla limpia de tres columnas con encabezados 'p', 'q' y 'p ∨ q'. Cuatro filas de datos con los valores exactos: (1,1 → 1), (1,0 → 1), (0,1 → 1), (0,0 → 0). Usa 0 para falso y 1 para verdadero. No incluir titulo natural. La disyuncion inclusiva es falsa solo cuando ambas proposiciones son falsas. Bordes de tabla en Lineas claras off-white nitidas, celdas de igual tamaño, encabezado con fondo gris muy claro. Correccion logica absoluta. Estilo obligatorio: PNG, fondo solido navy #27283D, resolucion ~1024x768 (4:3). Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolo ∨ correcto. Solo los simbolos necesarios y correctos.

### `matematicas_discretas/tabla_de_verdad_disyuncion2.png`

- **Target:** `landing/public/imagenes/matematicas_discretas/tabla_de_verdad_disyuncion2.png`
- **Descripcion:** Tabla de verdad de la disyuncion exclusiva (XOR, p ⊕ q), cuatro filas.
- **Prompt:**

  > Genera un diagrama de una tabla de verdad para la DISYUNCION EXCLUSIVA (XOR, p ⊕ q). Tabla limpia de tres columnas con encabezados 'p', 'q' y 'p ⊕ q'. Cuatro filas de datos con los valores exactos: (1,1 → 0), (1,0 → 1), (0,1 → 1), (0,0 → 0). Usa 0 para falso y 1 para verdadero. No incluir titulo natural. La disyuncion exclusiva es verdadera solo cuando las proposiciones tienen valores de verdad distintos. Bordes de tabla en Lineas claras off-white nitidas, celdas de igual tamaño, encabezado con fondo gris muy claro. Correccion logica absoluta. Estilo obligatorio: PNG, fondo solido navy #27283D, resolucion ~1024x768 (4:3). Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolo ⊕ correcto. Solo los simbolos necesarios y correctos.

### `matematicas_discretas/condicional.png`

- **Target:** `landing/public/imagenes/matematicas_discretas/condicional.png`
- **Descripcion:** Tabla de verdad del condicional logico (implicacion, p → q), cuatro filas.
- **Prompt:**

  > Genera un diagrama de una tabla de verdad para el CONDICIONAL logico (implicacion, p → q). Tabla limpia de tres columnas con encabezados 'p', 'q' y 'p → q'. Cuatro filas de datos con los valores exactos: (1,1 → 1), (1,0 → 0), (0,1 → 1), (0,0 → 1). Usa 0 para falso y 1 para verdadero. No incluir titulo natural. El condicional es falso unicamente cuando el antecedente es verdadero y el consecuente es falso. Bordes de tabla en Lineas claras off-white nitidas, celdas de igual tamaño, encabezado con fondo gris muy claro. Correccion logica absoluta. Estilo obligatorio: PNG, fondo solido navy #27283D, resolucion ~1024x768 (4:3). Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolo → correcto. Solo los simbolos necesarios y correctos.

### `matematicas_discretas/bicondicional.png`

- **Target:** `landing/public/imagenes/matematicas_discretas/bicondicional.png`
- **Descripcion:** Tabla de verdad del bicondicional logico (doble implicacion, p ↔ q), cuatro filas.
- **Prompt:**

  > Genera un diagrama de una tabla de verdad para el BICONDICIONAL logico (doble implicacion, p ↔ q). Tabla limpia de tres columnas con encabezados 'p', 'q' y 'p ↔ q'. Cuatro filas de datos con los valores exactos: (1,1 → 1), (1,0 → 0), (0,1 → 0), (0,0 → 1). Usa 0 para falso y 1 para verdadero. No incluir titulo natural. El bicondicional es verdadero solo cuando ambas proposiciones tienen el mismo valor de verdad. Bordes de tabla en Lineas claras off-white nitidas, celdas de igual tamaño, encabezado con fondo gris muy claro. Correccion logica absoluta. Estilo obligatorio: PNG, fondo solido navy #27283D, resolucion ~1024x768 (4:3). Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, acentos de color con moderacion. Flat, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, simbolo ↔ correcto. Solo los simbolos necesarios y correctos.

### `triangulo_rectangulo.png`

- **Target:** `landing/public/imagenes/triangulo_rectangulo.png`
- **Descripcion:** Triangulo rectangulo con catetos, hipotenusa y angulo recto marcado (base de trigonometria/Pitagoras).
- **Prompt:**

  > Genera un diagrama de un TRIANGULO RECTANGULO en posicion estandar. Vertice inferior izquierdo con un angulo recto marcado con un pequeño cuadrado. Cateto horizontal en la base etiquetado como 'b' (cateto adyacente), cateto vertical a la izquierda etiquetado como 'a' (cateto opuesto), e hipotenusa (lado inclinado) etiquetada como 'c'. Marca el angulo agudo inferior derecho con la letra griega theta (θ) y un arco pequeño. Geometria correcta: el angulo recto debe estar entre los dos catetos, la hipotenusa opuesta al angulo recto. Lineas claras off-white nitidas, relleno interior gris claro muy tenue (relleno minimo). Estilo obligatorio: PNG, fondo solido navy #27283D, resolucion ~1024x768 (4:3). Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: Lineas claras off-white nitidas, relleno minimo, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible con simbolos a, b, c y θ. Solo los simbolos necesarios y correctos.

### `funciones_trigonometricas_angulos_notables.png`

- **Target:** `landing/public/imagenes/funciones_trigonometricas_angulos_notables.png`
- **Descripcion:** Circulo unitario con angulos notables (0, 30, 45, 60, 90...) y sus coordenadas seno/coseno.
- **Prompt:**

  > Genera un diagrama del CIRCULO UNITARIO (circulo goniometrico) mostrando los angulos notables. Circulo de radio 1 centrado en el origen de unos ejes cartesianos X e Y. Marca los radios hacia los angulos notables del primer cuadrante y sus principales: 0°, 30°, 45°, 60°, 90°, 120°, 135°, 150°, 180°, 270° y 360°, indicando cada uno en grados y radianes (por ejemplo 30° = π/6, 45° = π/4, 60° = π/3, 90° = π/2). En cada punto sobre la circunferencia coloca las coordenadas (cosθ, senθ) con los valores exactos, por ejemplo en 30°: (√3/2, 1/2); en 45°: (√2/2, √2/2); en 60°: (1/2, √3/2). Correccion trigonometrica absoluta en todos los valores. Lineas de ejes negras con flechas, circunferencia en linea negra, radios en gris, puntos marcados en rojo tenue. Estilo obligatorio: PNG, fondo solido navy #27283D, preferible formato cuadrado ~1024x1024. Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: lineas nitidas, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible, notacion matematica correcta (cos, sen, π, √). Solo los simbolos necesarios y correctos.

### `regla_de_sarrus.png`

- **Target:** `landing/public/imagenes/regla_de_sarrus.png`
- **Descripcion:** Regla de Sarrus para calcular el determinante de una matriz 3x3 con las diagonales.
- **Prompt:**

  > Genera un diagrama que ilustre la REGLA DE SARRUS para el determinante de una matriz 3x3. Muestra una matriz 3x3 con elementos a11 a12 a13 / a21 a22 a23 / a31 a32 a33 dentro de barras verticales de determinante. A la derecha, repite las dos primeras columnas (a11 a12 y a21 a22 y a31 a32) para formar el arreglo extendido de 3x5. Traza tres diagonales descendentes (de izquierda-arriba a derecha-abajo) en color azul, que son los productos positivos (a11·a22·a33, a12·a23·a31, a13·a21·a32), y tres diagonales ascendentes (de izquierda-abajo a derecha-arriba) en color rojo, que son los productos negativos (a31·a22·a13, a32·a23·a11, a33·a21·a12). Abajo escribe la formula: det = suma de productos de diagonales azules menos suma de productos de diagonales rojas. Correccion algebraica absoluta: diagonales descendentes suman (+), ascendentes restan (−). Estilo obligatorio: PNG, fondo solido navy #27283D, resolucion ~1024x768 (4:3). Diagrama tecnico 2D limpio tipo libro de texto de ingenieria: lineas nitidas, azul para positivo, rojo para negativo, sin sombras 3D, sin fotorrealismo. Sin texto natural; usar solo simbolos universales, tipografia sans-serif legible con subindices correctos. Solo los simbolos necesarios y correctos.

### `agregar_tarea.png`

- **Target:** `landing/public/imagenes/agregar_tarea.png`
- **Descripcion:** Icono/captura de UI de la app para agregar tarea (no es diagrama tecnico; se puede reemplazar por un icono del sistema tipo 'mas').
- **Prompt:**

  > ELEMENTO DE UI, no un diagrama tecnico. Genera un icono plano y simple de 'agregar tarea': un signo mas (+) dentro de un circulo, o un icono de lista con un signo mas, en estilo flat minimalista de una sola tinta (gris oscuro o azul de la marca). Sin texto. Recomendacion: este activo puede reemplazarse por un icono estandar del sistema de diseño (add / plus) en lugar de generarse. Estilo obligatorio: PNG, fondo solido navy #27283D, formato cuadrado ~512x512, flat, sin sombras 3D, sin fotorrealismo, lineas nitidas.

### `carrito_comprar.png`

- **Target:** `landing/public/imagenes/carrito_comprar.png`
- **Descripcion:** Icono/captura de UI de carrito de compra (no es diagrama tecnico; reemplazable por icono del sistema tipo 'carrito').
- **Prompt:**

  > ELEMENTO DE UI, no un diagrama tecnico. Genera un icono plano y simple de 'carrito de compra' (shopping cart) en estilo flat minimalista de una sola tinta (gris oscuro o azul de la marca). Sin texto. Recomendacion: este activo puede reemplazarse por un icono estandar del sistema de diseño (shopping_cart) en lugar de generarse. Estilo obligatorio: PNG, fondo solido navy #27283D, formato cuadrado ~512x512, flat, sin sombras 3D, sin fotorrealismo, lineas nitidas.

### `formulas_favoritas.png`

- **Target:** `landing/public/imagenes/formulas_favoritas.png`
- **Descripcion:** Icono/captura de UI de formulas favoritas (no es diagrama tecnico; reemplazable por icono tipo 'estrella').
- **Prompt:**

  > ELEMENTO DE UI, no un diagrama tecnico. Genera un icono plano y simple de 'formulas favoritas': una estrella (favorito) combinada opcionalmente con un simbolo de formula (por ejemplo 'fx' o una hoja con una ecuacion), en estilo flat minimalista de una sola tinta (gris oscuro o dorado/azul de la marca). Sin texto largo. Recomendacion: este activo puede reemplazarse por un icono estandar del sistema (star / favorite). Estilo obligatorio: PNG, fondo solido navy #27283D, formato cuadrado ~512x512, flat, sin sombras 3D, sin fotorrealismo, lineas nitidas.

### `playstore.png`

- **Target:** `landing/public/imagenes/playstore.png`
- **Descripcion:** Icono/badge de UI de Google Play Store (no es diagrama tecnico; debe usarse el badge oficial de Google Play, no generarse).
- **Prompt:**

  > ELEMENTO DE UI, no un diagrama tecnico. Este activo corresponde al badge/logo de Google Play Store. NO generar arte propio: debe sustituirse por el badge oficial 'Disponible en Google Play' descargado desde el kit de marca oficial de Google Play, respetando sus lineamientos de marca. Si se requiere un marcador temporal, generar un icono plano generico de 'tienda de aplicaciones' (bolsa/triangulo de reproduccion) de una sola tinta gris, claramente marcado como placeholder. Estilo del placeholder: PNG, fondo solido navy #27283D, formato horizontal ~1024x300, flat, sin sombras 3D.

### `capdesispng.png`

- **Target:** `landing/public/imagenes/capdesispng.png`
- **Descripcion:** Logotipo de UI de la marca CAPDESIS con texto (no es diagrama tecnico; debe usarse el logo oficial, no generarse).
- **Prompt:**

  > ELEMENTO DE UI / logotipo de marca, no un diagrama tecnico. Este activo es el logotipo oficial de CAPDESIS con texto. NO generar arte propio ni inventar un logo: debe sustituirse por el archivo de logotipo oficial de la marca CAPDESIS provisto por la empresa (paleta Navy #2D2D64 y Gold #F3A73D). Si se requiere un marcador temporal, generar un wordmark plano 'CAPDESIS' en tipografia sans-serif en color Navy sobre fondo solido navy #27283D, claramente marcado como placeholder. Estilo del placeholder: PNG, fondo solido navy #27283D, formato horizontal ~1024x400, flat, sin sombras 3D.

### `capdesispngsintexto.png`

- **Target:** `landing/public/imagenes/capdesispngsintexto.png`
- **Descripcion:** Isotipo/logo de UI de la marca CAPDESIS sin texto (no es diagrama tecnico; debe usarse el isotipo oficial, no generarse).
- **Prompt:**

  > ELEMENTO DE UI / isotipo de marca, no un diagrama tecnico. Este activo es el isotipo oficial de CAPDESIS sin texto (solo el simbolo/marca grafica). NO generar arte propio ni inventar un logo: debe sustituirse por el archivo de isotipo oficial de la marca CAPDESIS provisto por la empresa (paleta Navy #2D2D64 y Gold #F3A73D). Si se requiere un marcador temporal, generar un simbolo geometrico plano simple en Navy/Gold sobre fondo solido navy #27283D, claramente marcado como placeholder. Estilo del placeholder: PNG, fondo solido navy #27283D, formato cuadrado ~512x512, flat, sin sombras 3D.

---

**Total de imagenes en el catalogo: 176**
