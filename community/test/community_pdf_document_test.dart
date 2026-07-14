import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/pdf/community_pdf_document.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('builds a valid offline study-sheet PDF', () async {
    final bytes = await CommunityPdfDocument.build(
      const CommunityPdfContent(
        appTitle: 'Formulae Community',
        title: 'Reglas básicas de derivación',
        generatedLocallyMessage:
            'Este PDF se generó localmente desde Formulae Community.',
        lessonHint: 'Consulta la lección dentro de la aplicación.',
      ),
    );

    expect(CommunityPdfDocument.hasPdfSignature(bytes), isTrue);
    expect(bytes.length, greaterThan(300));
    final tail = latin1.decode(
      bytes.sublist(bytes.length - 64),
      allowInvalid: true,
    );
    expect(tail, contains('%%EOF'));
  });

  test('derives a readable localized title and a safe export filename', () {
    final spanishTitle = CommunityPdfDocument.titleFromLegacyUrl(
      legacyUrl:
          'https://capdesis.com/sistema/formulae/calculo_diferencial/Reglas%20B%c3%a1sicas%20de%20Derivaci%c3%b3n%20uPrima.pdf',
      fallbackId: 'kWidgetDerivacionBasicaDiferencial',
      languageCode: 'es',
    );
    final englishTitle = CommunityPdfDocument.titleFromLegacyUrl(
      legacyUrl:
          'https://capdesis.com/sistema/formulae_ingles/algebra/FormulaGeneralI.pdf',
      fallbackId: 'kWidgetFormulaGeneral',
      languageCode: 'en',
    );

    expect(spanishTitle, 'Reglas Básicas de Derivación');
    expect(englishTitle, 'Formula General');
    expect(
      CommunityPdfDocument.fileNameForTitle(spanishTitle),
      'formulae_reglas_basicas_de_derivacion.pdf',
    );
  });
}
