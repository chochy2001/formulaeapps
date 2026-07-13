import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class IntegracionNumericaIntegral extends StatefulWidget {
  const IntegracionNumericaIntegral({super.key});

  @override
  IntegracionNumericaIntegralState createState() => IntegracionNumericaIntegralState();
}

class IntegracionNumericaIntegralState extends State<IntegracionNumericaIntegral> {
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
                    AppLocalizations.of(context)!.integracionNumericaIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.integracionNumericaIntegral,
                        widgetName: kWidgetIntegracionNumericaIntegral,
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
                                title: AppLocalizations.of(context)!.integracionNumericaIntegral,
                                widgetName: kWidgetIntegracionNumericaIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.integracionNumericaIntegral,
                                widgetName: kWidgetIntegracionNumericaIntegral,
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
                  Latex(formulaText: r"\int_{a}^{b} f(x)\,dx \approx h\left(y_{0} + y_{1} + \cdots + y_{n-1}\right)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int_{a}^{b} f(x)\,dx \approx \frac{h}{2}\left(y_{0} + 2y_{1} + 2y_{2} + \cdots + 2y_{n-1} + y_{n}\right)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int_{a}^{b} f(x)\,dx \approx \frac{h}{3}\left(y_{0} + 4y_{1} + 2y_{2} + 4y_{3} + \cdots + y_{n}\right)"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetIntegracionNumericaIntegral),
            const DescargarPDF(url: kWidgetIntegracionNumericaIntegral),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
