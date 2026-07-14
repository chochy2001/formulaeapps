# Assets visuales canónicos de Formulae

Esta carpeta contiene las 176 imágenes que Formulae Pro y Formulae Community
consumen desde https://formulaeapps.com/imagenes/. Hay una sola ruta canónica
por concepto, compartida por todos los idiomas de ambas apps.

Contrato visual:

- No incluir palabras, títulos, frases, leyendas ni capturas de interfaz. Las
  marcas oficiales Formulae y CAPDESIS son la única excepción: son identidad
  fija, no instrucción localizada.
- Se permiten únicamente símbolos científicos y matemáticos universales,
  variables, unidades, polaridades, flechas, valores 0/1 y geometría.
- Las tablas de verdad usan 0 y 1, nunca abreviaturas localizadas.
- El texto explicativo y los pasos de FAQ pertenecen a los widgets y archivos
  de localización de Flutter, no al bitmap.
- Fondo opaco navy #27283D, igual al fondo de la app. No usar transparencia
  con rejilla ni fondo blanco.

El comando bun run recover:formulae-images restaura las fuentes históricas y
aplica la neutralización determinista. Esa segunda etapa conserva topología y
notación correctas, elimina texto detectado y sustituye las antiguas capturas
FAQ por pictogramas sin idioma. Requiere Tesseract instalado localmente.

Después de cualquier regeneración ejecuta:

    cd landing
    bun run check:formulae-images

El validador exige las 176 rutas declaradas por
pro/lib/constantes/urls_imagenes.dart, coherencia con Community, dimensiones
válidas y esquinas navy.
Las URLs históricas /imagenes_ingles/ redirigen temporalmente al asset
canónico para no romper instalaciones antiguas; no se deben volver a publicar
bitmaps diferentes por idioma.

Estado de publicación, 2026-07-13: el validador local pasa las 176 rutas, pero
las URLs en `formulaeapps.com` devuelven 404. Después de promover esta carpeta
y las reglas de `.htaccess` o `nginx.conf`, ejecutar:

    cd landing
    bun run check:formulae-images:remote

El smoke remoto valida HTTP 200, MIME y que cada archivo se pueda decodificar.
