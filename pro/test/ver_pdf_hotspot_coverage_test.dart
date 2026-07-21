import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorites_pdf_generator.dart';
import 'package:formulae/Favorites/pdf_capture_scope.dart';
import 'package:formulae/constantes/export_constantes.dart';
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
    debugAvoidSyncfusionPdfViewer = false;
    VerPDFNuevoState.debugDownloadBytesOverride = null;
    FavoritesPdfGenerator.debugDisableFormulaCapture = false;
    FavoritesPdfGenerator.debugDownloadOverride = null;
  });

  tearDown(() {
    debugAvoidSyncfusionPdfViewer = false;
    VerPDFNuevoState.debugDownloadBytesOverride = null;
    FavoritesPdfGenerator.debugDisableFormulaCapture = false;
    FavoritesPdfGenerator.debugDownloadOverride = null;
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

  testWidgets(
    'VerPDFGenerado applies rebuilt bytes after a successful size change',
    (tester) async {
      debugAvoidSyncfusionPdfViewer = true;
      var rebuilds = 0;

      await tester.pumpWidget(
        _app(
          child: VerPDFGenerado(
            title: 'Resize ok',
            initialSize: PdfFormulaSize.medium,
            pdfData: _tinyPdf,
            previewContents: const [
              FavoriteFormulaContent(
                title: 'Resize ok',
                blocks: [
                  FormulaPdfBlock(
                    type: FormulaPdfBlockType.text,
                    text: 'Vista previa',
                  ),
                ],
              ),
            ],
            buildBytes: (size) async {
              rebuilds++;
              expect(size, PdfFormulaSize.large);
              return _tinyPdf;
            },
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byIcon(Icons.format_size_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Grande'));
      await tester.pumpAndSettle();

      expect(rebuilds, 1);
      expect(find.text('Vista previa'), findsOneWidget);
      expect(
        await FavoritesPdfGenerator.loadFormulaSize(),
        PdfFormulaSize.large,
      );
    },
  );

  testWidgets(
    'VerPDF opens a generated preview through formula extraction',
    (tester) async {
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      debugAvoidSyncfusionPdfViewer = true;

      await tester.pumpWidget(
        _favoritesApp(
          child: const VerPDF(url: kWidgetTeoremaDelRotacional),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Ver PDF'));
      await tester.pump();
      for (var i = 0; i < 80; i++) {
        await tester.pump(const Duration(milliseconds: 50));
        if (find.byType(VerPDFGenerado).evaluate().isNotEmpty) {
          break;
        }
      }

      expect(find.byType(VerPDFGenerado), findsOneWidget);
      expect(find.text('Generando PDF...'), findsNothing);
    },
    timeout: const Timeout(Duration(seconds: 90)),
  );

  testWidgets(
    'VerPDF surfaces an error snackbar when favorites context is missing',
    (tester) async {
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      debugAvoidSyncfusionPdfViewer = true;

      // No FavoritesNotifier → extractFavoriteFormulaContent throws into catch.
      await tester.pumpWidget(
        _app(child: const VerPDF(url: kWidgetTeoremaDelRotacional)),
      );
      await tester.pump();

      await tester.tap(find.text('Ver PDF'));
      await tester.pump();
      for (var i = 0; i < 40; i++) {
        await tester.pump(const Duration(milliseconds: 50));
        if (find.byType(SnackBar).evaluate().isNotEmpty) {
          break;
        }
      }

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.byType(VerPDFGenerado), findsNothing);
    },
  );

  testWidgets(
    'DescargarPDF exports bytes through the favorites download seam',
    (tester) async {
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      final downloads = <({Uint8List bytes, String fileName})>[];
      FavoritesPdfGenerator.debugDownloadOverride = (bytes, fileName) async {
        downloads.add((bytes: bytes, fileName: fileName));
      };

      await tester.pumpWidget(
        _favoritesApp(
          child: const DescargarPDF(url: kWidgetTeoremaDelRotacional),
        ),
      );
      await tester.pump();

      await tester.tap(find.textContaining('Descargar'));
      await tester.pump();
      for (var i = 0; i < 80; i++) {
        await tester.pump(const Duration(milliseconds: 50));
        if (downloads.isNotEmpty) {
          break;
        }
      }
      await tester.pumpAndSettle();

      expect(downloads, hasLength(1));
      expect(String.fromCharCodes(downloads.single.bytes.take(4)), '%PDF');
      expect(find.text('PDF generado'), findsOneWidget);
    },
    timeout: const Timeout(Duration(seconds: 90)),
  );

  testWidgets(
    'DescargarPDF shows an error snackbar when export fails',
    (tester) async {
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      FavoritesPdfGenerator.debugDownloadOverride = (_, __) async {
        throw StateError('download-blocked');
      };

      await tester.pumpWidget(
        _favoritesApp(
          child: const DescargarPDF(url: kWidgetTeoremaDelRotacional),
        ),
      );
      await tester.pump();

      await tester.tap(find.textContaining('Descargar'));
      await tester.pump();
      for (var i = 0; i < 80; i++) {
        await tester.pump(const Duration(milliseconds: 50));
        if (find.byType(SnackBar).evaluate().isNotEmpty) {
          break;
        }
      }
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('PDF generado'), findsNothing);
    },
    timeout: const Timeout(Duration(seconds: 90)),
  );

  testWidgets(
    'VerPDFNuevo renders downloaded bytes through the download seam',
    (tester) async {
      debugAvoidSyncfusionPdfViewer = true;
      var requestedUrl = '';
      VerPDFNuevoState.debugDownloadBytesOverride = (url) async {
        requestedUrl = url;
        return _tinyPdf;
      };

      await tester.pumpWidget(
        _app(child: const VerPDFNuevo(pdfUrl: 'https://example.test/ok.pdf')),
      );
      await tester.pump();
      await tester.pumpAndSettle();

      expect(requestedUrl, 'https://example.test/ok.pdf');
      expect(find.byKey(const Key('pdf-bytes-ready')), findsOneWidget);
      expect(find.text('Intentar de nuevo'), findsNothing);
    },
  );

  testWidgets(
    'VerPDFNuevo retry succeeds after a failed download',
    (tester) async {
      debugAvoidSyncfusionPdfViewer = true;
      var calls = 0;
      VerPDFNuevoState.debugDownloadBytesOverride = (url) async {
        calls++;
        if (calls == 1) {
          throw Exception('first-fail');
        }
        return _tinyPdf;
      };

      await tester.pumpWidget(
        _app(child: const VerPDFNuevo(pdfUrl: 'https://example.test/retry.pdf')),
      );
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.text('Intentar de nuevo'), findsOneWidget);

      await tester.tap(find.text('Intentar de nuevo'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(calls, 2);
      expect(find.byKey(const Key('pdf-bytes-ready')), findsOneWidget);
      expect(find.text('Intentar de nuevo'), findsNothing);
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
    home: Scaffold(body: child),
  );
}

Widget _favoritesApp({required Widget child}) {
  return ChangeNotifierProvider<FavoritesNotifier>(
    create: (_) => FavoritesNotifier(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: Scaffold(
        body: child,
        // Overlay is required for offscreen formula extraction.
      ),
    ),
  );
}
