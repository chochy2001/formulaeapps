import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class HiperbolicasInversasIntegral extends StatefulWidget {
  const HiperbolicasInversasIntegral({super.key});

  @override
  HiperbolicasInversasIntegralState createState() => HiperbolicasInversasIntegralState();
}

class HiperbolicasInversasIntegralState extends State<HiperbolicasInversasIntegral> {
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
                    AppLocalizations.of(context)!.hiperbolicasInversasIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.hiperbolicasInversasIntegral,
                        widgetName: kWidgetHiperbolicasInversasIntegral,
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
                                title: AppLocalizations.of(context)!.hiperbolicasInversasIntegral,
                                widgetName: kWidgetHiperbolicasInversasIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.hiperbolicasInversasIntegral,
                                widgetName: kWidgetHiperbolicasInversasIntegral,
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
                  Latex(formulaText: r"\int \sinh^{-1}x\,dx = x\,\sinh^{-1}x - \sqrt{x^{2}+1} + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \cosh^{-1}x\,dx = x\,\cosh^{-1}x - \sqrt{x^{2}-1} + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \tanh^{-1}x\,dx = x\,\tanh^{-1}x + \frac{1}{2}\ln\left(1-x^{2}\right) + C"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int \coth^{-1}x\,dx = x\,\coth^{-1}x + \frac{1}{2}\ln\left(x^{2}-1\right) + C"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetHiperbolicasInversasIntegral),
            const DescargarPDF(url: kWidgetHiperbolicasInversasIntegral),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
