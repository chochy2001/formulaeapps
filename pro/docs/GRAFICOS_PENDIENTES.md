# Graficos pendientes para Formulae Pro

Las 35 formulas listadas abajo aparecian junto a un diagrama en el
formulario impreso. Las formulas ya estan en la app; falta el diagrama.
Sourcing con licencia abierta (ver estrategia y plantilla al final).

> **Contrato visual vigente:** este documento describe intención pedagógica,
> no texto que deba rasterizarse. Cada activo nuevo debe usar un único bitmap
> para todos los idiomas, fondo navy `#27283D` y sólo notación científica o
> matemática universal: variables, fórmulas, unidades, flechas, polaridades,
> números y geometría. No incluir palabras, títulos, leyendas, instrucciones,
> botones ni capturas de UI. Las explicaciones viven en Flutter/ARB. Consulta
> [`../../landing/public/imagenes/README.md`](../../landing/public/imagenes/README.md)
> y el catálogo vigente antes de generar o publicar.

Total: 35 graficos en 6 secciones.

## algebra (6)

- **Forma exponencial (Euler) de un numero complejo** / Forma exponencial (polar) de un numero complejo
  - Diagrama: Diagrama de Argand (plano complejo): eje imaginario vertical y eje real horizontal; vector desde el origen hasta z en el primer cuadrante de longitud r; angulo theta entre el eje real y el vector marcado con un arco; catetos a (horizontal) y b (vertical) con lineas punteadas cerrando el triangulo rectangulo.
- **Determinantes y regla de Cramer / Sarrus** / Determinante del sistema D (2x2)
  - Diagrama: Esquema de multiplicacion en aspa: dos flechas diagonales cruzadas sobre la matriz 2x2; diagonal principal (a11->a22) con '+' y diagonal secundaria (a21/a12) con '-'.
- **Determinantes y regla de Cramer / Sarrus** / Determinante D1 (columna r en lugar de la de x)
  - Diagrama: Mismo esquema en aspa sobre [r1 a12; r2 a22], diagonal principal '+', secundaria '-'.
- **Determinantes y regla de Cramer / Sarrus** / Determinante D2 (columna r en lugar de la de y)
  - Diagrama: Mismo esquema en aspa sobre [a11 r1; a21 r2], diagonal principal '+', secundaria '-'.
- **Determinantes y regla de Cramer / Sarrus** / Determinante D por regla de Sarrus (3x3)
  - Diagrama: Esquema de Sarrus: matriz 3x3 con las dos primeras columnas copiadas a la derecha (arreglo 3x5); diagonales descendentes con '+ + +' y ascendentes con '- - -'.
- **Determinantes y regla de Cramer / Sarrus** / Determinante D1 (sustituir columna de x por r) por Sarrus
  - Diagrama: Mismo esquema de diagonales de Sarrus con la primera columna reemplazada por r1,r2,r3; '+ + +' descendentes, '- - -' ascendentes.

## algebra_lineal (5)

- **Producto punto y cruz de la base canonica** / Producto cruz de la base (sistema de mano derecha)
  - Diagrama: Regla de la mano derecha: mano derecha con los dedos rodeando de i (eje horizontal) hacia j, y el pulgar apuntando en la direccion de k (perpendicular al plano). Ilustra la orientacion del sistema de mano derecha y el sentido del producto cruz.
- **Producto escalar triple y volumen** / Area del paralelogramo (magnitud del producto vectorial)
  - Diagrama: Paralelogramo sombreado formado por V_A (lado inferior horizontal) y V_B (lado inclinado), con el angulo alfa en el vertice inferior izquierdo. Desde ese vertice sale, perpendicular al plano, el vector e = V_A x V_B. Flecha etiquetando el area como el producto vectorial.
- **Producto escalar triple y volumen** / Volumen del paralelepipedo
  - Diagrama: Paralelepipedo oblicuo en perspectiva. Desde un vertice inferior parten V_B (horizontal) y V_C (a trazos, hacia el fondo) formando la base con angulo alfa; V_A sube como arista lateral. El vector V_B x V_C se dibuja vertical, normal a la base; beta es el angulo entre V_A y esa normal. Ilustra volumen = area de base por altura.
- **Suma de vectores por componentes (metodo del poligono)** / Componente Y de un vector
  - Diagrama: Plano cartesiano con origen abajo a la izquierda. Desde el origen parten V_A (corto) y V_B (largo) y su resultante V_R; lineas punteadas de proyeccion hacia los ejes marcan las componentes V_Ax, V_Bx en el eje x y V_Ay, V_By en el eje y. Clasico diagrama de descomposicion y suma de vectores en 2D. (Fuente: pagina 6 del folleto, 41503.)
- **Ley de senos y cosenos** / Ley de cosenos (lado c)
  - Diagrama: Triangulo escaleno generico con etiquetas de lados a, b, c y angulos internos A, B, C, cada angulo opuesto a su lado homonimo (lado a opuesto a A, etc.). (Fuente: pagina 11 del folleto, 41505.)

## calculo_integral (3)

- **Integracion por sustitucion trigonometrica** / Caso 1: integrando con raiz(u^2 + a^2)
  - Diagrama: Triangulo rectangulo con el angulo recto en el vertice inferior derecho y el angulo theta en el vertice inferior izquierdo. Cateto horizontal inferior (adyacente a theta) rotulado 'a'; cateto vertical derecho (opuesto a theta) rotulado 'u'; hipotenusa rotulada 'raiz(u^2+a^2)'. Consistente con tan(theta)=u/a y sec(theta)=raiz(u^2+a^2)/a.
- **Integracion por sustitucion trigonometrica** / Caso 2: integrando con raiz(u^2 - a^2)
  - Diagrama: Triangulo rectangulo con angulo recto en el vertice inferior derecho y theta en el vertice inferior izquierdo. Hipotenusa rotulada 'u'; cateto vertical derecho (opuesto a theta) rotulado 'raiz(u^2-a^2)'; cateto horizontal inferior (adyacente a theta) rotulado 'a'. Consistente con sec(theta)=u/a y tan(theta)=raiz(u^2-a^2)/a.
- **Integracion por sustitucion trigonometrica** / Caso 3: integrando con raiz(a^2 - u^2)
  - Diagrama: Triangulo rectangulo con angulo recto en el vertice inferior derecho y theta en el vertice inferior izquierdo. Hipotenusa rotulada 'a'; cateto vertical derecho (opuesto a theta) rotulado 'u'; cateto horizontal inferior (adyacente a theta) rotulado 'raiz(a^2-u^2)'. Consistente con sen(theta)=u/a y cos(theta)=raiz(a^2-u^2)/a.

## mecanica (11)

- **Caida libre y tiro vertical** / Altura por velocidad media (tiro vertical)
  - Diagrama: Esquema de tiro vertical: una particula (bolita solida) con trayectoria en U invertida que sube, alcanza el punto alto y regresa con una flecha larga hacia abajo. Puede usar sólo las variables universales `g` y `h`; la explicación localizada de esos símbolos pertenece al widget.
- **Caida libre y tiro vertical** / Altura por velocidad media (caida libre)
  - Diagrama: Flecha vertical recta hacia abajo con una bolita solida al final, representando un cuerpo que cae libremente desde el reposo (V_0 = 0).
- **Movimiento de proyectiles (tiro parabolico)** / Alcance horizontal
  - Diagrama: Diagrama de movimiento de proyectil: un canon apoyado sobre el suelo dispara un proyectil que describe una trayectoria parabolica hasta caer. A lo largo de la parabola se muestran vectores de velocidad descompuestos (componentes horizontal y vertical) en ascenso, cima y descenso. 'H' marca la altura maxima; 'R' marca el alcance horizontal total.
- **Leyes de Newton** / Tercera ley (fuerza neta hacia arriba)
  - Diagrama: Serie de diagramas de cuerpo libre con una esfera (masa m): flecha 'F' hacia arriba y flecha 'P = F_g' (peso) hacia abajo, con la aceleracion 'a' resultante. Ilustra accion-reaccion y la relacion entre fuerza aplicada y peso segun la 2da y 3ra ley.
- **Friccion** / Fuerza neta (friccion por deslizamiento)
  - Diagrama: Diagrama de cuerpo libre de un bloque (m) sobre superficie horizontal: F_n vertical hacia el bloque, F_f horizontal opuesta al movimiento y F_t horizontal aplicada. Muestra la ecuacion Fuerza neta = F_t - F_f.
- **Friccion** / Componente del peso paralela al plano (fuerza tangencial)
  - Diagrama: Plano inclinado (triangulo rectangulo con angulo \theta en la base). Bloque (m) sobre la rampa. Vectores: F_f a lo largo de la rampa hacia arriba; F_t (componente del peso) a lo largo de la rampa hacia abajo; F_g vertical hacia abajo; F_n perpendicular a la superficie. Triangulo de fuerzas F_n, F_g, F_t con el angulo \theta.
- **Movimiento armonico simple (M.A.S.)** / Elongacion (proyeccion / coseno del angulo)
  - Diagrama: Circunferencia con centro O y diametro PQ; un objeto gira sobre la circunferencia con velocidad tangencial V_T; su sombra proyectada sobre el diametro describe el M.A.S. (elongacion \gamma). Notas: en P y Q velocidad nula y aceleracion maxima; en O velocidad maxima y aceleracion nula.
- **Movimiento armonico simple (M.A.S.)** / Velocidad (proyeccion / seno del angulo)
  - Diagrama: Circunferencia del MCU asociado al M.A.S.: el vector velocidad tangencial V_T tangente al punto que gira se proyecta (linea punteada) sobre el diametro dando la velocidad de oscilacion V (y su opuesto -V). Angulo \theta entre V_T y su proyeccion. Ilustra V = V_T sen\theta.
- **Movimiento armonico simple (M.A.S.)** / Aceleracion (proyeccion / coseno del angulo)
  - Diagrama: Circunferencia del MCU: el vector aceleracion radial a_r dirigido al centro se proyecta sobre el diametro dando la aceleracion de oscilacion a (y su opuesto -a). Angulo \theta entre a_r y su proyeccion. Ilustra a = a_r cos\theta.
- **Pendulo simple** / Elongacion del pendulo (seno del angulo)
  - Diagrama: Pendulo simple colgado de un soporte: cuerda de longitud l inclinada un angulo \theta respecto a la vertical (linea punteada al reposo). Masa en el extremo; elongacion horizontal \gamma marcada desde la posicion de reposo. Fuerzas sobre la masa: peso P (vertical), fuerza a lo largo de la cuerda F_c y fuerza de restitucion F_res (componente tangencial).
- **Momento de torsion (torque)** / Convencion de signos del momento
  - Diagrama: Dos flechas curvas de convencion de signos: a la izquierda flecha antihoraria etiquetada (+) = momento positivo; a la derecha flecha horaria etiquetada (-) = momento negativo.

## optica (8)

- **Ecuación de las lentes (forma Gaussiana)** / Ecuación de las lentes: objeto afuera del foco principal
  - Diagrama: Diagrama de rayos de una lente convergente (biconvexa, óvalo vertical con centro óptico marcado). El objeto se sitúa a la izquierda más allá del foco principal F; los rayos pasan por F y atraviesan la lente formando la imagen real invertida del lado derecho.
- **Ecuación de las lentes (forma Gaussiana)** / Ecuación de las lentes: objeto entre la lente y el foco
  - Diagrama: Segundo diagrama de rayos con lente convergente (biconvexa con centro óptico marcado). El objeto se coloca entre la lente y el foco F; los rayos divergen desde la zona de F hacia la lente ilustrando la formación de imagen virtual.
- **Ecuación de las lentes (forma Gaussiana)** / Ecuación de las lentes divergentes
  - Diagrama: Diagrama de una lente divergente (bicóncava con centro óptico marcado). Rayos paralelos entran desde la izquierda y al atravesar la lente divergen; sus prolongaciones hacia atrás pasan por el foco virtual F situado a la izquierda, ilustrando imagen virtual, derecha y reducida.
- **Refracción de la luz (ley de Snell)** / Índice de refracción (ley de Snell)
  - Diagrama: Diagrama de refracción con un bloque de vidrio horizontal. El rayo incidente baja desde arriba a la izquierda hasta el punto de incidencia; una normal vertical punteada pasa por ese punto marcando los ángulos i (incidencia) e i' (reflexión); el rayo reflejado sale hacia arriba a la derecha y el rayo refractado continúa dentro del vidrio más cercano a la normal formando el ángulo r.
- **Tipos de lentes y marcha de rayos** / Tipos de lentes convergentes
  - Diagrama: Tres secciones transversales de lentes convergentes (más gruesas en el centro): (1) Biconvexa, ambas caras convexas; (2) Menisco convergente, una cara convexa y otra cóncava; (3) Planoconvexa, una cara plana y otra convexa.
- **Tipos de lentes y marcha de rayos** / Tipos de lentes divergentes
  - Diagrama: Tres secciones transversales de lentes divergentes (más delgadas en el centro): (1) Bicóncava, ambas caras cóncavas; (2) Planocóncava, una cara plana y otra cóncava; (3) Menisco divergente, una cara convexa y otra cóncava más pronunciada.
- **Tipos de lentes y marcha de rayos** / Marcha de rayos en lente convergente
  - Diagrama: Lente convergente (biconvexa) vertical al centro; varios rayos horizontales paralelos inciden por la izquierda y al atravesar la lente convergen todos en un punto real F a la derecha (foco).
- **Tipos de lentes y marcha de rayos** / Marcha de rayos en lente divergente
  - Diagrama: Lente divergente (bicóncava) vertical al centro; rayos horizontales paralelos inciden por la izquierda y divergen hacia la derecha; sus prolongaciones punteadas hacia atrás se cruzan en el foco virtual F a la izquierda de la lente.

## trigonometria (2)

- **Circulo unitario** / Ecuacion del circulo unitario
  - Diagrama: Circulo unitario centrado en el origen con eje X horizontal (flechas a ambos lados) y eje Y vertical (flechas a ambos lados). Desde el centro parten 16 radios hacia los angulos notables: 0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315 y 330 grados. En cada interseccion radio-circunferencia hay un punto marcado; desde cada punto bajan/corren lineas punteadas a los ejes X e Y (proyecciones coseno y seno). Los cuatro cortes con los ejes se rotulan (1,0), (0,1), (-1,0), (0,-1). Cada radio se etiqueta en radianes (fraccion de pi) y su equivalente en grados. Los cuatro cuadrantes se rotulan con el signo de las coordenadas.
- **Signos de las funciones trigonometricas por cuadrante** / Tabla de signos por cuadrante
  - Diagrama: Plano cartesiano con ejes vertical y horizontal cruzados, dividido en cuatro cuadrantes rotulados con numeros romanos (I arriba-derecha, II arriba-izquierda, III abajo-izquierda, IV abajo-derecha). En cada cuadrante se listan los signos de sen, cos y tg.

## Estrategia de sourcing

1. Preferir dominio publico o CC0 (sin obligacion de atribucion, pero se
   registra igual). Luego CC BY. Evitar CC BY-SA salvo que se acepte el
   copyleft. GeoGebra vetado para uso comercial sin licencia.
2. Fuentes: Wikimedia Commons (filtrar por licencia), Openclipart (CC0),
   tikz.net y texample.net (revisar licencia por figura). Alternativa
   preferida a largo plazo: generar propios con TikZ o Matplotlib, cuya
   salida no tiene restriccion de licencia.
3. Formato Flutter: SVG via flutter_svg con re-tematizado claro/oscuro, o
   PNG. La app es dark-only hoy, el diagrama debe leerse sobre fondo oscuro.
4. Registrar cada archivo en un CREDITOS dentro de la app antes de publicar.

## Plantilla de atribucion (para el archivo de creditos de la app)

```
Titulo del diagrama
  Autor: <nombre o usuario>
  Fuente: <URL de la pagina del archivo>
  Licencia: <CC0 / CC BY 4.0 / Dominio publico / propio>
  Cambios: <ninguno / re-tematizado / recorte>
```
