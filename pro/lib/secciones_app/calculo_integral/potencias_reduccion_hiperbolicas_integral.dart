import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PotenciasReduccionHiperbolicasIntegral extends StatefulWidget {
  const PotenciasReduccionHiperbolicasIntegral({super.key});

  @override
  PotenciasReduccionHiperbolicasIntegralState createState() => PotenciasReduccionHiperbolicasIntegralState();
}

class PotenciasReduccionHiperbolicasIntegralState extends State<PotenciasReduccionHiperbolicasIntegral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChatGPTButton(
                  child: TituloPersonalizado(
                    AppLocalizations.of(context)!.potenciasReduccionHiperbolicasIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.potenciasReduccionHiperbolicasIntegral,
                        widgetName: kWidgetPotenciasReduccionHiperbolicasIntegral,
                      ),
                    );
                    return IconButton(
                      icon: isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoritesNotifier.removeFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.potenciasReduccionHiperbolicasIntegral,
                                widgetName: kWidgetPotenciasReduccionHiperbolicasIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.potenciasReduccionHiperbolicasIntegral,
                                widgetName: kWidgetPotenciasReduccionHiperbolicasIntegral,
                              ),
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  Latex(formulaText: r"\int \sinh^{2} x\,dx = \frac{1}{4}\sinh 2x - \frac{x}{2} + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \sinh^{n} x\,dx = \frac{1}{n}\cosh x\,\sinh^{n-1} x - \frac{n-1}{n}\int \sinh^{n-2} x\,dx"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \sinh(ax)\,dx = \frac{1}{a}\cosh(ax) + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \cosh^{2} x\,dx = \frac{1}{4}\sinh 2x + \frac{x}{2} + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \cosh^{n} x\,dx = \frac{1}{n}\sinh x\,\cosh^{n-1} x + \frac{n-1}{n}\int \cosh^{n-2} x\,dx"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \cosh(ax)\,dx = \frac{1}{a}\sinh(ax) + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \tanh^{2} x\,dx = x - \tanh x + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \tanh^{n} x\,dx = -\frac{1}{n-1}\tanh^{n-1} x + \int \tanh^{n-2} x\,dx"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \tanh(ax)\,dx = \frac{1}{a}\ln \cosh(ax) + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \coth^{2} x\,dx = x - \coth x + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \coth^{n} x\,dx = -\frac{1}{n-1}\coth^{n-1} x + \int \coth^{n-2} x\,dx"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \coth(ax)\,dx = \frac{1}{a}\ln \sinh(ax) + C"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPotenciasReduccionHiperbolicasIntegral),
            const DescargarPDF(url: kWidgetPotenciasReduccionHiperbolicasIntegral),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
