import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/widgets_personalizados/formula_overflow.dart';
import 'package:formulae/widgets_personalizados/textos_personalizados.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Formula extremadamente ancha (cadena de conversion de unidades) que no
  // puede caber ni siquiera al piso de escala en una pantalla movil.
  const wideFormula =
      r'1\ \mathrm{cm^{3}} = 1\times 10^{-6}\ \mathrm{m^{3}} = 1\times 10^{-3}\ \mathrm{L} '
      r'= 1\ \mathrm{mL} = 1000\ \mathrm{mm^{3}} = 0.061024\ \mathrm{in^{3}} '
      r'= 3.5315\times 10^{-5}\ \mathrm{ft^{3}} = 2.6417\times 10^{-4}\ \mathrm{gal}';

  const shortFormula = r'x = 1';

  Future<void> pump(
    WidgetTester tester,
    Widget child, {
    Size surface = const Size(390, 800),
  }) async {
    await tester.binding.setSurfaceSize(surface);
    tester.view.physicalSize = surface;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Center(child: child)),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'very wide formula never overflows and shows the scrollable fade layout',
    (tester) async {
      await pump(tester, const Latex(formulaText: wideFormula));

      // Ningun error de overflow (RenderFlex/paint) fue lanzado.
      expect(tester.takeException(), isNull);

      // Cae en el modo scroll + desvanecido, no en un recorte silencioso.
      expect(find.byKey(kAdaptiveFormulaFadeKey), findsOneWidget);
      expect(find.byType(ShaderMask), findsWidgets);

      // El contenido es realmente mas ancho que el viewport (hay que deslizar).
      final scrollable = tester.widget<Scrollable>(
        find.descendant(
          of: find.byKey(kAdaptiveFormulaFadeKey),
          matching: find.byType(Scrollable),
        ),
      );
      expect(scrollable.axis, Axis.horizontal);
      await tester.pump();
      final position = tester
          .state<ScrollableState>(
            find.descendant(
              of: find.byKey(kAdaptiveFormulaFadeKey),
              matching: find.byType(Scrollable),
            ),
          )
          .position;
      expect(position.maxScrollExtent, greaterThan(0.0));
    },
  );

  testWidgets('short formula is centered without scroll or fade', (
    tester,
  ) async {
    await pump(tester, const Latex(formulaText: shortFormula));

    expect(tester.takeException(), isNull);
    expect(find.byKey(kAdaptiveFormulaFitKey), findsOneWidget);
    expect(find.byKey(kAdaptiveFormulaFadeKey), findsNothing);
  });

  testWidgets('a formula is always either fitted or faded, never clipped', (
    tester,
  ) async {
    // Barrido de anchos para asegurar que siempre hay una de las dos
    // afordancias presentes y jamas un recorte silencioso.
    for (final width in <double>[320, 390, 768, 1280]) {
      await pump(
        tester,
        const Latex(formulaText: wideFormula),
        surface: Size(width, 900),
      );
      expect(tester.takeException(), isNull, reason: 'width=$width');
      final hasFade = find.byKey(kAdaptiveFormulaFadeKey).evaluate().isNotEmpty;
      final hasFit = find.byKey(kAdaptiveFormulaFitKey).evaluate().isNotEmpty;
      expect(hasFade || hasFit, isTrue, reason: 'width=$width');
    }
  });
}
