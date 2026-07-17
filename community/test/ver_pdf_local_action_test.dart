import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/pdf/community_pdf_document.dart';
import 'package:formulae/screens_personalizados/configuracion.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    AdMobConfig.adsEnabled = false;
  });

  tearDown(() {
    AdMobConfig.adsEnabled = true;
  });

  testWidgets(
      'VerPDF builds a local document instead of loading its legacy URL',
      (tester) async {
    CommunityPdfContent? receivedContent;
    Future<Uint8List> failingBuilder(CommunityPdfContent content) async {
      receivedContent = content;
      throw StateError('test-only local builder failure');
    }

    await tester.pumpWidget(
      _harness(
        const SizedBox.shrink(),
        body: VerPDF(
          url: kWidgetFormulaGeneral,
          pdfBuilder: failingBuilder,
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Ver PDF'));
    await tester.pump();
    await tester.pump();

    expect(receivedContent, isNotNull);
    expect(receivedContent!.title, 'Formula general');
    expect(find.text('El PDF no está disponible en este momento.'),
        findsOneWidget);
  });

  testWidgets('DescargarPDF exports the generated local bytes', (tester) async {
    CommunityPdfContent? receivedContent;
    Uint8List? exportedBytes;
    String? exportedName;

    Future<Uint8List> buildLocalPdf(CommunityPdfContent content) async {
      receivedContent = content;
      return Uint8List.fromList(<int>[
        0x25,
        0x50,
        0x44,
        0x46,
        0x2D,
        0x31,
        0x2E,
        0x37,
      ]);
    }

    Future<void> exportLocalPdf(Uint8List bytes, String fileName) async {
      exportedBytes = bytes;
      exportedName = fileName;
    }

    await tester.pumpWidget(
      _harness(
        const SizedBox.shrink(),
        body: DescargarPDF(
          url: kWidgetFormulaGeneral,
          pdfBuilder: buildLocalPdf,
          pdfExporter: exportLocalPdf,
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Descargar/Imprimir/Compartir PDF'));
    await tester.pump();
    await tester.pump();

    expect(receivedContent, isNotNull);
    expect(CommunityPdfDocument.hasPdfSignature(exportedBytes!), isTrue);
    expect(exportedName, 'formulae_formula_general.pdf');
    expect(find.text('El PDF está listo para guardarse o compartirse.'),
        findsOneWidget);
  });

  testWidgets('DescargarPDF reports a localized export failure',
      (tester) async {
    Future<Uint8List> buildLocalPdf(CommunityPdfContent _) async {
      return Uint8List.fromList(<int>[0x25, 0x50, 0x44, 0x46, 0x2D]);
    }

    await tester.pumpWidget(
      _harness(
        const SizedBox.shrink(),
        body: DescargarPDF(
          url: kWidgetFormulaGeneral,
          pdfBuilder: buildLocalPdf,
          pdfExporter: (_, __) async => throw StateError('share unavailable'),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Descargar/Imprimir/Compartir PDF'));
    await tester.pump();
    await tester.pump();

    expect(find.text('No se pudo exportar el PDF.'), findsOneWidget);
  });

  testWidgets(
      'VerPDFNuevo never falls back to the network without a local loader',
      (tester) async {
    await HttpOverrides.runZoned<Future<void>>(
      () async {
        await tester.pumpWidget(
          _harness(
            const SizedBox.shrink(),
            body: const VerPDFNuevo(
              pdfUrl: 'https://unreachable.example/legacy.pdf',
            ),
          ),
        );
        await tester.pump();

        expect(
          find.text('El PDF no está disponible en este momento.'),
          findsOneWidget,
        );
      },
      createHttpClient: (_) => throw StateError('Unexpected network request'),
    );
  });
}

Widget _harness(Widget home, {Widget? body}) {
  return ChangeNotifierProvider<LocaleProvider>(
    create: (_) => LocaleProvider(const Locale('es')),
    child: MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: Scaffold(body: body ?? home),
    ),
  );
}
