import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/constantes/constantes_imagenes.dart';
import 'package:formulae/constantes/imagenes_nombres.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/zoom_image_personalizado.dart';

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

  Future<void> expectTimeoutFallback(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(seconds: 13));

    expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);
    expect(find.text('Imagen no disponible'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(tester.takeException(), isNull);
  }

  testWidgets('VerImagen turns a remote timeout into a visible fallback', (
    tester,
  ) async {
    await tester.pumpWidget(
      harness(const Scaffold(body: VerImagen(url: kImagenCapacitor1))),
    );

    expect(find.byType(ImagenRemotaRobusta), findsOneWidget);
    await expectTimeoutFallback(tester);
  });

  testWidgets('VerImagenNuevo turns a remote timeout into a visible fallback', (
    tester,
  ) async {
    await tester.pumpWidget(
      harness(
        const VerImagenNuevo(
          imageUrl: 'https://example.invalid/diagrama-inexistente.png',
        ),
      ),
    );

    expect(find.byType(ImagenRemotaRobusta), findsOneWidget);
    await expectTimeoutFallback(tester);
  });
}
