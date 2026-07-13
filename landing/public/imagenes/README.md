# Imagenes de Formulae Pro (hospedadas en Hostinger)

Los PNG de diagramas de la app Pro van aqui, preservando la estructura de
subcarpetas (ej. `electricidad_y_magnetismo/campo_electrico.png`). Al desplegar
la landing, esta carpeta se publica en `https://formulaeapps.com/imagenes/...`,
que es de donde la app Pro las toma (constante en
`pro/lib/constantes/urls_imagenes.dart`). La app las cachea en el dispositivo
(cached_network_image) para verlas offline tras la primera carga.

Reemplazan las 176 imagenes que estaban en el host viejo `capdesis.com` (404).
Los prompts de generacion por imagen estan en el catalogo de prompts.
