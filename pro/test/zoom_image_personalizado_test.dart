import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/widgets_personalizados/zoom_image_personalizado.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget harness(Widget child, {Locale locale = const Locale('es')}) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets(
    'a broken remote image resolves to the placeholder, not an endless spinner',
    (tester) async {
      await tester.pumpWidget(
        harness(
          const ZoomImagePersonalizado(
            urlImagen:
                'https://capdesis.com/sistema/formulae/Imagenes/__inexistente__.png',
          ),
        ),
      );

      // Primer frame: puede mostrar el estado de carga acotado.
      await tester.pump();
      // Drenar cualquier excepcion de red propia del entorno de test.
      while (tester.takeException() != null) {}

      // Avanzar mas alla del timeout de respaldo (12s) para garantizar que el
      // estado de carga NO gira indefinidamente y cae en el placeholder.
      await tester.pump(const Duration(seconds: 13));
      while (tester.takeException() != null) {}

      expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);
      expect(find.text('Imagen no disponible'), findsOneWidget);
      // El spinner de carga quedo acotado: ya no hay ninguno en pantalla.
      expect(find.byType(CircularProgressIndicator), findsNothing);
      // La imagen remota rota ya no ocupa el arbol.
      expect(find.byType(CachedNetworkImage), findsNothing);
    },
  );

  testWidgets('the English locale shows the localized placeholder label',
      (tester) async {
    await tester.pumpWidget(
      harness(
        const ZoomImagePersonalizado(
          urlImagen:
              'https://capdesis.com/sistema/formulae/Imagenes/__inexistente__.png',
        ),
        locale: const Locale('en'),
      ),
    );

    await tester.pump();
    while (tester.takeException() != null) {}
    await tester.pump(const Duration(seconds: 13));
    while (tester.takeException() != null) {}

    expect(find.text('Image unavailable'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
