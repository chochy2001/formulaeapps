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
    'failed native PDF resize preserves the preview and re-enables size selection',
    (tester) async {
      final rebuild = Completer<Uint8List>();

      await tester.pumpWidget(
        _app(
          VerPDFGenerado(
            title: 'Límites',
            previewContents: const [
              FavoriteFormulaContent(
                title: 'Límites',
                blocks: [
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.text,
                    text: 'Contenido que debe seguir visible',
                  ),
                ],
              ),
            ],
            buildBytes: (_) => rebuild.future,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.format_size_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Grande'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);

      rebuild.completeError(StateError('No se pudo crear el PDF'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.text('Contenido que debe seguir visible'), findsOneWidget);
      expect(
        tester
            .widget<PopupMenuButton<PdfFormulaSize>>(
              find.byType(PopupMenuButton<PdfFormulaSize>),
            )
            .enabled,
        isTrue,
      );
    },
  );

  testWidgets('PDF preview supplies the localized title when no title is given',
      (tester) async {
    await tester.pumpWidget(
      _app(
        const VerPDFGenerado(
          previewContents: [
            FavoriteFormulaContent(title: '', blocks: []),
          ],
        ),
      ),
    );

    expect(find.text('Formulae PDF'), findsOneWidget);
    expect(find.byType(FormulaePdfPreview), findsOneWidget);
  });
}

Widget _app(Widget child) {
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
