import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_consts.dart';
import 'package:formulae/chat_gpt/export_chat_gpt.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/constantes/export_constantes.dart';
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
