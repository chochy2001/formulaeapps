import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_consts.dart';
import 'package:formulae/chat_gpt/export_chat_gpt.dart';
import 'package:formulae/constantes/constantes_codigo.dart';
import 'package:formulae/constantes/constantes_favoritos.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/constantes/imagenes_nombres.dart';
import 'package:formulae/constantes/nombres_videos.dart';
import 'package:formulae/constantes/paleta_colores.dart';
import 'package:formulae/constantes/urls_imagenes.dart';
import 'package:formulae/constantes/urls_videos.dart';
import 'package:formulae/menus/export_menus.dart';
import 'package:formulae/screens_personalizados/export_screens_personalizados.dart';
import 'package:formulae/secciones_app/algebra/export_algebra.dart';
import 'package:formulae/secciones_app/algebra_lineal/export_algebra_lineal.dart';
import 'package:formulae/secciones_app/calculo_diferencial/export_calculo_diferencial.dart';
import 'package:formulae/secciones_app/calculo_integral/export_calculo_integral.dart';
import 'package:formulae/secciones_app/calculo_multivariable/export_calculo_multivariable.dart';
import 'package:formulae/secciones_app/ecuaciones_diferenciales/export_ecuaciones_diferenciales.dart';
import 'package:formulae/secciones_app/ejercicios/export_ejercicios.dart';
import 'package:formulae/secciones_app/electricidad_y_magnetismo/export_electricidad_y_magnetismo.dart';
import 'package:formulae/secciones_app/generales/export_generales.dart';
import 'package:formulae/secciones_app/geometria/export_geometria.dart';
import 'package:formulae/secciones_app/matematicas_discretas/export_matematicas_discretas.dart';
import 'package:formulae/secciones_app/matematicas_financieras/export_matematicas_financieras.dart';
import 'package:formulae/secciones_app/probabilidad_y_estadistica/export_probabilidad_y_estadistica.dart';
import 'package:formulae/secciones_app/series_de_fourier/export_series_de_fourier.dart';
import 'package:formulae/secciones_app/trigonometria/export_trigonometria.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';
import 'package:formulae/widgets_personalizados/widgets_intermedios/preguntas_frecuentes_intermedio.dart';

void main() {
  test('barrel and constant libraries load', () {
    expect(kWidgetFormulaGeneral, isNotEmpty);
    expect(kRutaGenerales, isNotEmpty);
    expect(kColorFondo, isNotNull);
    expect(kUrlImagenFormulae, isNotEmpty);
    expect(bffBaseUrl, isNotEmpty);
    expect(PreguntasFrecuentesIntermedio, isNotNull);
  });
}
