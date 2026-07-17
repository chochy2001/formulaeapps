import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorites_pdf_generator.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/ver_pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'PDF preview separates pages and preserves text formulas without images',
    (tester) async {
      await tester.pumpWidget(
        _app(
          child: const VerPDFGenerado(
            title: 'Primer tema',
            previewContents: [
              FavoriteFormulaContent(
                title: 'Primer tema',
                blocks: [
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.heading,
                    text: 'Primer tema',
                  ),
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.text,
                    text: 'Contexto de la primera fórmula',
                  ),
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.formula,
                    text: r'\frac{a}{b}',
                  ),
                ],
              ),
              FavoriteFormulaContent(
                title: 'Segundo tema',
                blocks: [
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.text,
                    text: 'Contenido de la segunda página',
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      expect(find.text('Primer tema'), findsNWidgets(2));
      expect(find.text('Contexto de la primera fórmula'), findsOneWidget);
      expect(find.text(r'\frac{a}{b}'), findsOneWidget);
      expect(find.text('Segundo tema'), findsOneWidget);
      expect(find.text('Contenido de la segunda página'), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    },
  );

  testWidgets(
    'changing PDF size rebuilds native bytes and persists the selected size',
    (tester) async {
      final rebuild = Completer<Uint8List>();
      PdfFormulaSize? requestedSize;

      await tester.pumpWidget(
        _app(
          child: VerPDFGenerado(
            title: 'Vista de fórmula',
            previewContents: const [
              FavoriteFormulaContent(
                title: 'Vista de fórmula',
                blocks: [
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.text,
                    text: 'Contenido de respaldo',
                  ),
                ],
              ),
            ],
            buildBytes: (size) {
              requestedSize = size;
              return rebuild.future;
            },
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.format_size_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Grande'));
      await tester.pump();

      expect(requestedSize, PdfFormulaSize.large);
      expect(
        tester
            .widget<PopupMenuButton<PdfFormulaSize>>(
              find.byType(PopupMenuButton<PdfFormulaSize>),
            )
            .enabled,
        isFalse,
      );

      await tester.pump();

      expect(
        await FavoritesPdfGenerator.loadFormulaSize(),
        PdfFormulaSize.large,
      );
    },
  );
}

Widget _app({required Widget child}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: const Locale('es'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: L10n.all,
    home: child,
  );
}
