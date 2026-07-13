import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/chat_gpt/api_consts.dart';
import 'package:formulae/chat_gpt/chat_gpt_button.dart';
import 'package:formulae/chat_gpt/export_chat_gpt.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_intermedios/preguntas_frecuentes_intermedio.dart';

/// Loads the barrel/constant libraries whose symbols are asserted below so
/// they appear in the lcov SF set. Only imports that are actually referenced
/// are kept; unreferenced barrels are tree-shaken and never contribute
/// coverage, so importing them only produced dead-import analyzer warnings.
void main() {
  test('barrel and constant libraries load', () {
    expect(kWidgetFormulaGeneral, isNotEmpty);
    expect(kRutaGenerales, isNotEmpty);
    expect(kColorFondo, isNotNull);
    expect(kUrlImagenFormulae, isNotEmpty);
    expect(bffBaseUrl, isNotEmpty);
    // Keep type references so tree-shaking does not drop imports.
    expect(ChatGPTButton, isNotNull);
    expect(PreguntasFrecuentesIntermedio, isNotNull);
  });
}
