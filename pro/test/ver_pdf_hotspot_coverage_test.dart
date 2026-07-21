import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorites_pdf_generator.dart';
import 'package:formulae/Favorites/pdf_capture_scope.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/ver_pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Minimal valid 1×1 PNG used as a captured formula image in the preview.
final Uint8List _tinyPng = Uint8List.fromList(const <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x02,
  0x00,
  0x00,
  0x00,
  0x90,
  0x77,
  0x53,
  0xDE,
  0x00,
  0x00,
  0x00,
  0x0C,
  0x49,
  0x44,
  0x41,
  0x54,
  0x08,
  0xD7,
  0x63,
  0xF8,
  0xCF,
  0xC0,
  0x00,
  0x00,
  0x00,
  0x03,
  0x00,
  0x01,
  0x00,
  0x05,
  0xFE,
  0x02,
  0xFE,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

final Uint8List _tinyPdf = Uint8List.fromList(
  '%PDF-1.4\n1 0 obj<<>>endobj\ntrailer<<>>\n%%EOF\n'.codeUnits,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'VerPDF and DescargarPDF shrink under capture scope or empty url',
    (tester) async {
      await tester.pumpWidget(
        _app(
          child: const PdfCaptureScope(
            isCapturing: true,
            child: Column(
              children: [
                VerPDF(url: 'any-widget'),
                DescargarPDF(url: 'any-widget'),
              ],
            ),
          ),
        ),
      );
      expect(find.textContaining('PDF'), findsNothing);

      await tester.pumpWidget(
        _app(
          child: const Column(
            children: [
              VerPDF(url: ''),
              DescargarPDF(url: ''),
            ],
          ),
        ),
      );
      expect(find.textContaining('PDF'), findsNothing);
    },
  );

  testWidgets(
    'FormulaePdfPreview renders a captured formula image at the selected scale',
    (tester) async {
      await tester.pumpWidget(
        _app(
          child: FormulaePdfPreview(
            size: PdfFormulaSize.large,
            contents: [
              FavoriteFormulaContent(
                title: 'Imagen captura',
                blocks: [
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.formula,
                    text: r'\alpha',
                    image: _tinyPng,
                    imageWidth: 40,
                    imageHeight: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.width, 40 * PdfFormulaSize.large.scale);
    },
  );

  testWidgets(
    'VerPDFGenerado regenerates native bytes when size changes and keeps preview',
    (tester) async {
      final rebuild = Completer<Uint8List>();
      PdfFormulaSize? requested;

      await tester.pumpWidget(
        _app(
          child: VerPDFGenerado(
            title: 'Bytes nativos',
            initialSize: PdfFormulaSize.medium,
            previewContents: const [
              FavoriteFormulaContent(
                title: 'Bytes nativos',
                blocks: [
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.text,
                    text: 'Respaldo preview',
                  ),
                ],
              ),
            ],
            buildBytes: (size) {
              requested = size;
              return rebuild.future;
            },
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Respaldo preview'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.format_size_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pequeño'));
      await tester.pump();

      expect(requested, PdfFormulaSize.small);
      expect(
        tester
            .widget<PopupMenuButton<PdfFormulaSize>>(
              find.byType(PopupMenuButton<PdfFormulaSize>),
            )
            .enabled,
        isFalse,
      );
      expect(
        await FavoritesPdfGenerator.loadFormulaSize(),
        PdfFormulaSize.small,
      );

      // Leave the regenerating future pending and tear down to avoid Syncfusion
      // timers from mounting SfPdfViewer.memory in widget tests.
      await tester.pumpWidget(_app(child: const SizedBox.shrink()));
      await tester.pump();
    },
  );

  testWidgets(
    'PdfFormulaSizeMenu exposes localized labels for every size option',
    (tester) async {
      PdfFormulaSize selected = PdfFormulaSize.medium;

      await tester.pumpWidget(
        _app(
          child: Scaffold(
            appBar: AppBar(
              actions: [
                PdfFormulaSizeMenu(
                  value: selected,
                  onSelected: (size) => selected = size,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.format_size_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Pequeño'), findsOneWidget);
      expect(find.text('Mediano'), findsOneWidget);
      expect(find.text('Grande'), findsOneWidget);

      await tester.tap(find.text('Grande'));
      await tester.pumpAndSettle();
      expect(selected, PdfFormulaSize.large);
    },
  );

  testWidgets(
    'VerPDFNuevo shows retry after a failed download and exposes the CORS proxy helper',
    (tester) async {
      // TestWidgetsFlutterBinding forces HTTP 400, so any URL fails download.
      await tester.pumpWidget(
        _app(child: const VerPDFNuevo(pdfUrl: 'https://example.test/doc.pdf')),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('Intentar de nuevo'), findsOneWidget);

      final state = tester.state<VerPDFNuevoState>(find.byType(VerPDFNuevo));
      expect(
        state.getCorsProxyUrl('https://cdn.example/doc.pdf'),
        'https://cors-anywhere.herokuapp.com/https://cdn.example/doc.pdf',
      );

      await tester.tap(find.text('Intentar de nuevo'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Intentar de nuevo'), findsOneWidget);
    },
  );

  testWidgets('selecting the already-active PDF size is a no-op', (
    tester,
  ) async {
    var rebuilds = 0;
    await tester.pumpWidget(
      _app(
        child: VerPDFGenerado(
          title: 'Sin cambio',
          previewContents: const [
            FavoriteFormulaContent(
              title: 'Sin cambio',
              blocks: [
                FormulaPdfBlock(
                  type: FormulaPdfBlockType.text,
                  text: 'Contenido',
                ),
              ],
            ),
          ],
          buildBytes: (_) async {
            rebuilds++;
            return _tinyPdf;
          },
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.format_size_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mediano'));
    await tester.pumpAndSettle();

    expect(rebuilds, 0);
  });
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
    home: Scaffold(body: child),
  );
}
