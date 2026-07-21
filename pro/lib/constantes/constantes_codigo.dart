import 'package:flutter/material.dart';

export '../../../constantes/urls_imagenes.dart';
export '../../../constantes/urls_videos.dart';

const kColorFondo = Color(0xFF27283D);
const kColorBotones = Color(0xFF393A5D);
const kColorBordes = Color(0xFF000594);
const kColorRespuestaCorrecta = Color(0xFF25276F);
const kColorAmarilloCapdesis = Color(0xFFF3A73D);

const kColorTextoBotones = Color(0xFFE9E9E9);
const kColorTransparente = Color(0x00ffffff);
const kColorBlanco = Colors.white;

// Paleta de acentos y colores semanticos.
//
// El sistema mantiene la identidad navy oscura, pero suma profundidad y funcion:
// el dorado es el acento PRIMARIO (seleccion / accion), el teal es el acento
// SECUNDARIO (afordancias secundarias / enlaces) y hay rojo/verde semanticos.
// Todos los valores estan verificados para cumplir contraste WCAG AA sobre las
// superficies navy (kColorFondo #27283D y kColorBotones #393A5D) y usan colores
// solidos, nunca opacidad, para respetar la convencion existente de la app.

// Tono navy un paso mas claro para dar profundidad en estados hover / activo /
// superficies elevadas sobre kColorFondo.
const kColorElevacion = Color(0xFF45476B);

// Acento PRIMARIO: dorado Capdesis. Se usa de forma deliberada como acento
// (item de navegacion activo, boton de accion primario, indicadores activos),
// no para repintar toda la interfaz. Alias semantico del dorado ya existente.
const kColorAcentoPrimario = kColorAmarilloCapdesis;

// Acento SECUNDARIO: teal / cyan (combina con el glifo del icono de la app).
// Para afordancias interactivas secundarias: enlaces, mover-a-carpeta, botones
// secundarios. Contraste 6.56:1 sobre navy.
const kColorAcentoSecundario = Color(0xFF3AC0C9);

// Color semantico DESTRUCTIVO: rojo legible sobre navy (4.68:1 sobre la tarjeta,
// 6.22:1 sobre el fondo). Reemplaza al Colors.red plano que quedaba por debajo
// del minimo de contraste (2.94:1) en dialogos de borrar / limpiar.
const kColorDestructivo = Color(0xFFFF8787);

// Color semantico de EXITO: verde legible sobre navy (5.78:1 sobre la tarjeta).
const kColorExito = Color(0xFF3DD68C);

// Texto / icono de navegacion NO seleccionado con contraste suficiente sobre
// navy (4.84:1). Sustituye al antiguo #646D9E que quedaba en 2.90:1.
const kColorNavInactivo = Color(0xFF8A93C4);

// Texto / icono oscuro para colocar SOBRE superficies de acento claras (dorado
// o teal), donde el blanco no daria contraste suficiente.
const kColorTextoSobreAcento = Color(0xFF27283D);

const kEstiloTextoMenus = TextStyle(color: Color(0xFFE9E9E9), fontSize: 30);

const kEstiloSubMenu = TextStyle(color: Color(0xFFE9E9E9), fontSize: 10);

const kEstiloBotones = TextStyle(
  color: kColorBlanco,
  fontSize: 20,
  fontWeight: FontWeight.w100,
);

const kTextoBotones = TextStyle(color: Color(0xFFE9E9E9), fontSize: 20.0);

const kTextoBotonesDelgado = TextStyle(
  color: Color(0xFFE9E9E9),
  fontSize: 15.0,
);

const kTextoBotones2 = TextStyle(color: Color(0xFFE9E9E9), fontSize: 15.0);

const kTextoCerrar = TextStyle(color: kColorDestructivo, fontSize: 15.0);

const kTexto = TextStyle(
  color: Color(0xFFE9E9E9),
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);

const kTextoEcuaciones = TextStyle(
  color: Color(0xFFE9E9E9),
  fontSize: 17.0,
  decorationColor: kColorBotones,
);

const kHintStyle = TextStyle(color: Color(0xFFA9A9A9), fontSize: 15.0);

const kTextoMostrarOcultar = TextStyle(
  color: Color(0xFFE9E9E9),
  fontSize: 15.0,
);
const kTextoLatexFormulas = TextStyle(
  backgroundColor: kColorFondo,
  color: Colors.white,
  fontSize: 20.0,
);

// Variante para capturar formulas destinadas al PDF: texto oscuro y fondo
// transparente para que sea legible sobre la pagina blanca.
const kTextoLatexFormulasPdf = TextStyle(
  color: Color(0xFF1A1A2E),
  fontSize: 20.0,
);

const kTextoDelgado = TextStyle(
  color: Color(0xFFA9A9A9),
  fontSize: 15.0,
  decorationColor: kColorBotones,
  fontStyle: FontStyle.italic,
  backgroundColor: kColorFondo,
);

const kTextoNotas = TextStyle(
  backgroundColor: kColorBotones,
  color: Colors.white,
  fontSize: 16.0,
);

const double kBordeBotones = 15.0;
const double kEspacioInteractivo = 5.0;
const double kEspacioEntreBotones = 30.0;
const double kEspacioEntrePistas = 45.0;
const double kEspacioTitulos = 15.0;

const String kURLFormulae = "https://linktr.ee/formulae_";
const String kPaginaWebFormulae = "https://formulaeapps.com/";
const String kInstagramFormulae =
    "https://instagram.com/formulaeapps?igshid=NTc4MTIwNjQ2YQ==";
const String kFacebookFormulae =
    "https://www.facebook.com/people/FormulaeApp/100092426805612/";

const double interactiveHeight = 0.1;
const double interactiveWidth = 0.8;
const String kFormularioMejoraFormulae = "https://forms.gle/cqTWNp9rZr7zEQDp8";
