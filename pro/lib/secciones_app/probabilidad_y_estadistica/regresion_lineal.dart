import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class RegresionLineal extends StatefulWidget {
  const RegresionLineal({super.key});

  @override
  RegresionLinealState createState() => RegresionLinealState();
}

class RegresionLinealState extends State<RegresionLineal> {
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
                    AppLocalizations.of(context)!.regresionLineal,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.regresionLineal,
                        widgetName: kWidgetRegresionLineal,
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
                                title: AppLocalizations.of(
                                  context,
                                )!.regresionLineal,
                                widgetName: kWidgetRegresionLineal,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.regresionLineal,
                                widgetName: kWidgetRegresionLineal,
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
                  Latex(formulaText: r"y = m x + b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"m = \left( \dfrac{\sum X_i \sum Y_i}{N} - \sum X_i Y_i \right) \Big/ \left( \dfrac{\left(\sum X_i\right)^{2}}{N} - \sum X_i^{2} \right)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"b = \bar{Y} - m\,\bar{X}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\bar{X} = \frac{1}{N} \sum_{i=1}^{N} X_i",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\bar{Y} = \frac{1}{N} \sum_{i=1}^{N} Y_i",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\sigma_x^{2} = \frac{1}{N} \sum_{i=1}^{N} \left( X_i^{2} - \bar{X}^{2} \right)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\sigma_Y^{2} = \frac{1}{N} \sum_{i=1}^{N} \left( Y_i^{2} - \bar{Y}^{2} \right)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"r = m\,\sigma_x / \sigma_y"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetRegresionLineal),
            const DescargarPDF(url: kWidgetRegresionLineal),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
