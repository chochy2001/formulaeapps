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

// Contraste 4.84:1 sobre kColorFondo; apto para navegación no seleccionada.
const kColorNavInactivo = Color(0xFF8A93C4);

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

const kTextoCerrar = TextStyle(color: Colors.red, fontSize: 15.0);

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

const kBannerAdAndroidProduccion = String.fromEnvironment(
  'ADMOB_ANDROID_BANNER_ID',
);
const kBannerAdIOSProduccion = String.fromEnvironment('ADMOB_IOS_BANNER_ID');
const kIntersticialAndroidProduccion = String.fromEnvironment(
  'ADMOB_ANDROID_INTERSTITIAL_ID',
);
const kIntersticialIOSProduccion = String.fromEnvironment(
  'ADMOB_IOS_INTERSTITIAL_ID',
);
const kCargaAppAnuncioAndroidProduccion = String.fromEnvironment(
  'ADMOB_ANDROID_APP_OPEN_ID',
);
const kCargaAppAnuncioIOSProduccion = String.fromEnvironment(
  'ADMOB_IOS_APP_OPEN_ID',
);

const kBannerAdAndroidPrueba = String.fromEnvironment(
  'ADMOB_ANDROID_BANNER_ID',
  defaultValue: 'ca-app-pub-3940256099942544/6300978111',
);
const kBannerAdIOSPrueba = String.fromEnvironment(
  'ADMOB_IOS_BANNER_ID',
  defaultValue: 'ca-app-pub-3940256099942544/2934735716',
);
const kIntersticialAndroidPrueba = String.fromEnvironment(
  'ADMOB_ANDROID_INTERSTITIAL_ID',
  defaultValue: 'ca-app-pub-3940256099942544/1033173712',
);
const kIntersticialIOSPrueba = String.fromEnvironment(
  'ADMOB_IOS_INTERSTITIAL_ID',
  defaultValue: 'ca-app-pub-3940256099942544/4411468910',
);
const kCargaAppAnuncioAndroidPrueba = String.fromEnvironment(
  'ADMOB_ANDROID_APP_OPEN_ID',
  defaultValue: 'ca-app-pub-3940256099942544/3419835294',
);
const kCargaAppAnuncioIOSPrueba = String.fromEnvironment(
  'ADMOB_IOS_APP_OPEN_ID',
  defaultValue: 'ca-app-pub-3940256099942544/5662855259',
);
