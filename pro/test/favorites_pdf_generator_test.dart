import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorites_pdf_generator.dart';
import 'package:formulae/Favorites/pdf_capture_scope.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/formula_overflow.dart';
import 'package:formulae/widgets_personalizados/textos_personalizados.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Full 8-byte PNG magic number; a captured formula must start with it.
const List<int> _pngSignature = [
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
];

const String _captureFormula = r'\frac{a}{b}';

Finder _latexScrollView() => find.descendant(
      of: find.byType(Latex),
      matching: find.byType(SingleChildScrollView),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<BuildContext> pumpHostApp(
    WidgetTester tester,
    FavoritesNotifier notifier,
  ) async {
    late BuildContext capturedContext;
    await tester.pumpWidget(
      ChangeNotifierProvider<FavoritesNotifier>.value(
        value: notifier,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    return capturedContext;
  }

  Future<void> pumpLatex(
    WidgetTester tester,
    String formulaText, {
    required bool capturing,
  }) async {
    Widget child = Center(child: Latex(formulaText: formulaText));
    if (capturing) {
      child = PdfCaptureScope(isCapturing: true, child: child);
    }
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: child)));
    await tester.pump();
  }

  testWidgets(
    'capture mode wraps the formula in a labelled RepaintBoundary with the '
    'dark PDF style and no horizontal scroll clip',
    (tester) async {
      await pumpLatex(tester, _captureFormula, capturing: true);

      final boundaryFinder = find.byType(PdfFormulaBoundary);
      expect(boundaryFinder, findsOneWidget);
      expect(
        tester.widget<PdfFormulaBoundary>(boundaryFinder).formulaText,
        _captureFormula,
      );

      // No SingleChildScrollView means the wide formula renders at its full
      // intrinsic width (no clipping) so the capture is complete.
      expect(_latexScrollView(), findsNothing);

      // Dark glyphs on a transparent background so the formula is legible on a
      // white PDF page (the on-screen style is white on a dark background).
      final math = tester.widget<Math>(find.byType(Math));
      expect(math.textStyle, kTextoLatexFormulasPdf);
      expect(math.textStyle!.color, const Color(0xFF1A1A2E));
      expect(math.textStyle!.backgroundColor, isNull);
    },
  );

  testWidgets(
    'normal mode renders the adaptive on-screen layout with the white style '
    'and no PDF capture boundary',
    (tester) async {
      await pumpLatex(tester, _captureFormula, capturing: false);
      // Let the intrinsic-width measurement settle so the adaptive layout
      // picks its final mode.
      await tester.pumpAndSettle();

      expect(find.byType(PdfFormulaBoundary), findsNothing);

      // A short formula fits, so it is centered (fit layout) without the
      // scrollable fade affordance and never clipped.
      expect(find.byKey(kAdaptiveFormulaFitKey), findsOneWidget);
      expect(find.byKey(kAdaptiveFormulaFadeKey), findsNothing);

      // The on-screen style is white on the dark background (both the visible
      // formula and the offscreen measurement copy use it).
      final maths = tester.widgetList<Math>(find.byType(Math));
      expect(maths, isNotEmpty);
      expect(
        maths.every((math) => math.textStyle == kTextoLatexFormulas),
        isTrue,
      );
    },
  );

  testWidgets(
    'a rendered formula boundary captures to PNG bytes that a formula block '
    'carries',
    (tester) async {
      await pumpLatex(tester, _captureFormula, capturing: true);

      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byType(PdfFormulaBoundary),
      );

      // runAsync runs the capture in a real async zone; RepaintBoundary.toImage
      // deadlocks under the default fake test clock. This mirrors the
      // production capture (pixelRatio 3.0, PNG) inside _captureFormulaImage.
      final block = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 3.0);
        try {
          final byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          final bytes = byteData!.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          );
          return FormulaPdfBlock(
            type: FormulaPdfBlockType.formula,
            text: _captureFormula,
            image: bytes,
            imageWidth: image.width / 3.0,
            imageHeight: image.height / 3.0,
          );
        } finally {
          image.dispose();
        }
      });

      expect(block, isNotNull);
      expect(block!.image, isNotNull);
      expect(block.image!.length, greaterThan(_pngSignature.length));
      expect(block.image!.sublist(0, _pngSignature.length), _pngSignature);
      expect(block.imageWidth, greaterThan(0));
      expect(block.imageHeight, greaterThan(0));
    },
  );

  testWidgets(
    'extraction falls back to the raw LaTeX text path when image capture is '
    'unavailable',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      addTearDown(() {
        FavoritesPdfGenerator.debugDisableFormulaCapture = false;
      });

      final capturedContext = await pumpHostApp(tester, FavoritesNotifier());
      final favorite = Favorite(
        title: 'Teorema del rotacional',
        widgetName: kWidgetTeoremaDelRotacional,
      );

      // Overlay.insert + WidgetsBinding.endOfFrame settle under pumpAndSettle;
      // with capture disabled there is no toImage future to await, so this runs
      // to completion on the fake clock and exercises the text fallback.
      final contentFuture = FavoritesPdfGenerator.extractFavoriteFormulaContent(
        context: capturedContext,
        favorite: favorite,
      );
      await tester.pumpAndSettle();
      final content = await contentFuture;

      final formulaBlocks = content.blocks
          .where((block) => block.type == FormulaPdfBlockType.formula)
          .toList();
      expect(formulaBlocks, isNotEmpty);

      // With no capture available every formula block falls back to text and
      // keeps the raw LaTeX (a backslash command) so the PDF is never empty.
      for (final block in formulaBlocks) {
        expect(block.image, isNull);
        expect(block.text.trim(), isNotEmpty);
      }
      expect(formulaBlocks.any((block) => block.text.contains(r'\')), isTrue);
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );

  testWidgets(
    'text fallback returns a valid PDF without missing math glyphs',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      // Capture is disabled so the offscreen toImage future cannot deadlock the
      // fake test clock; this drives the full PDF assembly (header, footer,
      // pages, text fallback blocks) end to end.
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      addTearDown(() {
        FavoritesPdfGenerator.debugDisableFormulaCapture = false;
      });

      final capturedContext = await pumpHostApp(tester, FavoritesNotifier());
      final favorite = Favorite(
        title: 'Teorema del rotacional',
        widgetName: kWidgetTeoremaDelRotacional,
      );

      final printed = <String>[];
      late Future<Uint8List> pdfFuture;
      runZoned(
        () {
          pdfFuture = FavoritesPdfGenerator.buildFavoritePdfBytes(
            context: capturedContext,
            favorite: favorite,
            folderName: 'General',
          );
        },
        zoneSpecification: ZoneSpecification(
          print: (_, __, ___, line) => printed.add(line),
        ),
      );
      await tester.pumpAndSettle();
      final Uint8List pdfBytes = await pdfFuture;

      expect(pdfBytes, isNotEmpty);
      expect(String.fromCharCodes(pdfBytes.take(4)), '%PDF');
      expect(
        printed.where((line) => line.contains('Unable to find a font to draw')),
        isEmpty,
      );
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );

  testWidgets(
    'the export filename is derived from the source screen title, not the '
    'generic placeholder that the View/Download buttons pass',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      // Capture disabled keeps the offscreen extraction on the fake test clock.
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      addTearDown(() {
        FavoritesPdfGenerator.debugDisableFormulaCapture = false;
      });

      final capturedContext = await pumpHostApp(tester, FavoritesNotifier());
      final localizations = AppLocalizations.of(capturedContext)!;

      // VerPDF/DescargarPDF build the Favorite with the generic app title; the
      // widgetName is the only real link to the source screen.
      const genericTitle = 'Formulae PDF placeholder';
      final favorite = Favorite(
        title: genericTitle,
        widgetName: kWidgetTeoremaDelRotacional,
      );

      final contentFuture = FavoritesPdfGenerator.extractFavoriteFormulaContent(
        context: capturedContext,
        favorite: favorite,
      );
      await tester.pumpAndSettle();
      final content = await contentFuture;

      // The resolved title comes from the screen's own heading
      // (TituloPersonalizado), never from the generic favorite title.
      expect(content.title, localizations.teoremaRotacional);
      expect(content.title, isNot(genericTitle));

      // The download filename reuses _sanitizeFileName over that real title, so
      // the shared/printed file is recognisable (e.g. formulae_<screen>.pdf).
      final fileName =
          FavoritesPdfGenerator.downloadFileNameForTitle(content.title);
      expect(
        fileName,
        FavoritesPdfGenerator.downloadFileNameForTitle(
          localizations.teoremaRotacional,
        ),
      );
      expect(fileName, startsWith('formulae_'));
      expect(fileName, endsWith('.pdf'));
      expect(
        fileName,
        isNot(FavoritesPdfGenerator.downloadFileNameForTitle(genericTitle)),
      );
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );

  group('PdfFormulaSize', () {
    test('scale grows monotonically with medium at the neutral 1.0', () {
      expect(PdfFormulaSize.medium.scale, 1.0);
      expect(PdfFormulaSize.small.scale, lessThan(PdfFormulaSize.medium.scale));
      expect(PdfFormulaSize.large.scale, greaterThan(PdfFormulaSize.medium.scale));
    });

    test('storage value round-trips through the enum name', () {
      for (final size in PdfFormulaSize.values) {
        expect(
          FavoritesPdfGenerator.formulaSizeFromStorage(size.storageValue),
          size,
        );
      }
    });

    test('unknown or missing storage value falls back to medium', () {
      expect(
        FavoritesPdfGenerator.formulaSizeFromStorage(null),
        PdfFormulaSize.medium,
      );
      expect(
        FavoritesPdfGenerator.formulaSizeFromStorage('gigantic'),
        PdfFormulaSize.medium,
      );
    });

    test('load defaults to medium and persists the saved choice', () async {
      SharedPreferences.setMockInitialValues({});
      expect(
        await FavoritesPdfGenerator.loadFormulaSize(),
        PdfFormulaSize.medium,
      );

      await FavoritesPdfGenerator.saveFormulaSize(PdfFormulaSize.large);
      expect(
        await FavoritesPdfGenerator.loadFormulaSize(),
        PdfFormulaSize.large,
      );
    });
  });

  testWidgets(
    'the PDF build accepts a formula size and still produces a valid document',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      FavoritesPdfGenerator.debugDisableFormulaCapture = true;
      addTearDown(() {
        FavoritesPdfGenerator.debugDisableFormulaCapture = false;
      });

      final capturedContext = await pumpHostApp(tester, FavoritesNotifier());
      final favorite = Favorite(
        title: 'Teorema del rotacional',
        widgetName: kWidgetTeoremaDelRotacional,
      );

      late Future<Uint8List> pdfFuture;
      runZoned(() {
        pdfFuture = FavoritesPdfGenerator.buildFavoritePdfBytes(
          context: capturedContext,
          favorite: favorite,
          folderName: 'General',
          size: PdfFormulaSize.large,
        );
      });
      await tester.pumpAndSettle();
      final pdfBytes = await pdfFuture;

      expect(pdfBytes, isNotEmpty);
      expect(String.fromCharCodes(pdfBytes.take(4)), '%PDF');
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );
}
