import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/constantes/constantes_imagenes.dart';
import 'package:formulae/constantes/imagenes_nombres.dart';
import 'package:formulae/constantes/urls_imagenes.dart';

void main() {
  test('the image registry contains only canonical Formulae URLs', () {
    expect(imageUrlMap, isNotEmpty);

    for (final url in imageUrlMap.values) {
      expect(url, startsWith('https://formulaeapps.com/imagenes/'));
      expect(url, isNot(contains('/imagenes_ingles/')));
    }
  });

  testWidgets(
    'image IDs resolve identically in Spanish, English, and a future locale',
    (tester) async {
      const locales = [Locale('es'), Locale('en'), Locale('fr')];

      for (final locale in locales) {
        final resolvedUrls = <String, String?>{};

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Localizations(
              locale: locale,
              delegates: const [GlobalWidgetsLocalizations.delegate],
              child: Builder(
                builder: (context) {
                  for (final id in imageUrlMap.keys) {
                    resolvedUrls[id] = getImageUrlById(context, id);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );

        for (final entry in imageUrlMap.entries) {
          expect(
            resolvedUrls[entry.key],
            entry.value,
            reason: '${locale.languageCode} must use the canonical image route',
          );
        }
      }
    },
  );

  test('unknown image IDs have no canonical route', () {
    expect(
      imageUrlMap[kImagenPortadoresDeCargaLibre],
      kUrlImagenPortadoresDeCargaLibre,
    );
    expect(imageUrlMap['unknown-image-id'], isNull);
  });
}
