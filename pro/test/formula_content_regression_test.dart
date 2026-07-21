import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formulae/Favorites/favorite.dart';
import 'package:formulae/l10n/app_localizations.dart';
import 'package:formulae/l10n/l10n.dart';
import 'package:formulae/secciones_app/algebra/potencias_n_esimas.dart';
import 'package:formulae/secciones_app/calculo_diferencial/derivadas_trigonometricas_complementarias.dart';
import 'package:formulae/secciones_app/calculo_diferencial/limites/limites_importantes.dart';
import 'package:formulae/secciones_app/calculo_diferencial/razon_cambio_tangente_normal.dart';
import 'package:formulae/secciones_app/series_de_fourier/transformadas/transformada_de_laplace.dart';
import 'package:formulae/secciones_app/constantes_matematicas/constantes_fisicas_universales.dart';
import 'package:formulae/widgets_personalizados/textos_personalizados.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<List<String>> pumpFormulaScreen(
    WidgetTester tester,
    Widget screen,
  ) async {
    await tester.binding.setSurfaceSize(const Size(900, 1600));
    await tester.pumpWidget(
      ChangeNotifierProvider<FavoritesNotifier>(
        create: (_) => FavoritesNotifier(),
        child: MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: screen,
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    return tester
        .widgetList<Latex>(find.byType(Latex))
        .map((widget) => widget.formulaText)
        .toList(growable: false);
  }

  testWidgets('critical formula screens expose the audited identities', (
    tester,
  ) async {
    expect(
      await pumpFormulaScreen(tester, const LimitesLimitesImportantes()),
      contains(r'\lim_{\theta \to 0} \frac{\sin\theta}{\theta} = 1'),
    );

    final inverseDerivatives = await pumpFormulaScreen(
      tester,
      const DerivadasTrigonometricasComplementarias(),
    );
    expect(
      inverseDerivatives,
      contains(
        r'\frac{d}{dx}\,\operatorname{arc\,vers} u = \frac{1}{\sqrt{2u-u^{2}}}\cdot\frac{du}{dx}',
      ),
    );
    expect(
      inverseDerivatives,
      contains(
        r'\frac{d}{dx}\,\operatorname{arc\,sen} x = \frac{1}{\sqrt{1-x^{2}}}',
      ),
    );
    expect(
      inverseDerivatives,
      contains(
        r'\frac{d}{dx}\,\operatorname{arc\,cos} x = -\frac{1}{\sqrt{1-x^{2}}}',
      ),
    );
    expect(
      inverseDerivatives,
      contains(r'\frac{d}{dx}\,\operatorname{arc\,tan} x = \frac{1}{1+x^{2}}'),
    );

    expect(
      await pumpFormulaScreen(tester, const PotenciasNEsimas()),
      contains(
        r'a^{n} + b^{n} = (a+b)\left(a^{n-1} - a^{n-2}b + a^{n-3}b^{2} - \dots - ab^{n-2} + b^{n-1}\right),\quad n\in\mathbb{N}\ \text{impar}',
      ),
    );
    expect(
      await pumpFormulaScreen(tester, const RazonCambioTangenteNormal()),
      contains(r'\Delta y = \Delta x\tan a'),
    );
    final physicalConstants = await pumpFormulaScreen(
      tester,
      const ConstantesFisicasUniversales(),
    );
    expect(
      physicalConstants,
      contains(
        r'c = 299\,792\,458\ \mathrm{m\,s^{-1}}\quad\text{(exacta por definición SI)}',
      ),
    );
    expect(
      physicalConstants,
      contains(
        r'G = 6.674\,30(15) \times 10^{-11}\ \mathrm{m^{3}\,kg^{-1}\,s^{-2}}\quad\text{(valor medido; incertidumbre estándar 0.000\,15 \times 10^{-11})}',
      ),
    );
    expect(
      physicalConstants,
      contains(
        r'h = 6.626\,070\,15 \times 10^{-34}\ \mathrm{J\,s}\quad\text{(exacta por definición SI)}',
      ),
    );
    expect(
      physicalConstants,
      contains(
        r'k = 1.380\,649 \times 10^{-23}\ \mathrm{J\,K^{-1}}\quad\text{(exacta por definición SI)}',
      ),
    );
    expect(
      physicalConstants,
      contains(
        r'N_A = 6.022\,140\,76 \times 10^{23}\ \mathrm{mol^{-1}}\quad\text{(exacta por definición SI)}',
      ),
    );
    expect(
      physicalConstants,
      contains(
        r'\sigma = 5.670\,374\,419\ldots \times 10^{-8}\ \mathrm{W\,m^{-2}\,K^{-4}}\quad\text{(exacta; derivada de constantes SI)}',
      ),
    );
    final laplace = await pumpFormulaScreen(
      tester,
      const TransformadaDeLaplace(),
    );
    expect(laplace, contains(r'\mathcal{L}\{e^{at}\} = \frac{1}{s-a}'));
    expect(laplace, contains(r"\mathcal{L}\{f'(t)\} = sF(s) - f(0^-)"));
  });
}
