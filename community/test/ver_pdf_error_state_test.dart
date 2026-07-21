import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/ver_pdf.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget harness(Widget child) {
    return MaterialApp(
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

  testWidgets('failed PDF loading is localized and can be retried', (
    tester,
  ) async {
    var attempts = 0;
    Future<Uint8List> failingLoader(String _) async {
      attempts++;
      throw StateError('endpoint unavailable');
    }

    await tester.pumpWidget(
      harness(
        VerPDFNuevo(
          pdfUrl: 'https://example.test/missing.pdf',
          pdfLoader: failingLoader,
        ),
      ),
    );
    await tester.pump();

    expect(
      find.text('El PDF no está disponible en este momento.'),
      findsOneWidget,
    );
    expect(find.text('Reintentar'), findsOneWidget);
    expect(attempts, 1);

    await tester.tap(find.text('Reintentar'));
    await tester.pump();
    expect(attempts, 2);
  });

  testWidgets(
    'disposing while a PDF is loading never calls setState after dispose',
    (tester) async {
      final completion = Completer<Uint8List>();

      await tester.pumpWidget(
        harness(
          VerPDFNuevo(
            pdfUrl: 'https://example.test/pending.pdf',
            pdfLoader: (_) => completion.future,
          ),
        ),
      );
      await tester.pump();
      await tester.pumpWidget(const SizedBox.shrink());

      completion.complete(Uint8List.fromList([0x25, 0x50, 0x44, 0x46, 0x2D]));
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}
