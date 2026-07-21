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

  test('uses the configured local image origin only for canonical URLs', () {
    const configuredOrigin = String.fromEnvironment(
      'FORMULAE_IMAGE_ORIGIN',
      defaultValue: 'https://formulaeapps.com',
    );

    expect(
      resolveFormulaeImageUrl(
        'https://formulaeapps.com/imagenes/geometria/cubo.png',
      ),
      '$configuredOrigin/imagenes/geometria/cubo.png',
    );
    expect(
      resolveFormulaeImageUrl('https://example.test/diagram.png'),
      'https://example.test/diagram.png',
    );
  });

  testWidgets('broken images reach a localized fallback instead of spinning', (
    tester,
  ) async {
    await tester.pumpWidget(
      harness(
        const ZoomImagePersonalizado(
          urlImagen: 'https://example.test/missing-diagram.png',
        ),
        locale: const Locale('en'),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 13));

    expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);
    expect(find.text('Image unavailable'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(CachedNetworkImage), findsNothing);
  });

  testWidgets('small logo fallbacks keep their caller size without overflow', (
    tester,
  ) async {
    await tester.pumpWidget(
      harness(
        const SizedBox(
          width: 50,
          height: 50,
          child: ImagenRemotaRobusta(
            urlImagen: 'https://example.test/missing-logo.png',
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 13));

    expect(
      tester.getSize(find.byType(ImagenRemotaRobusta)),
      const Size(50, 50),
    );
    expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
