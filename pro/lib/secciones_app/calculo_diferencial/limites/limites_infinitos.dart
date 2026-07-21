import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LimitesLimitesInfinitos extends StatefulWidget {
  const LimitesLimitesInfinitos({super.key});

  @override
  LimitesLimitesInfinitosState createState() => LimitesLimitesInfinitosState();
}

class LimitesLimitesInfinitosState extends State<LimitesLimitesInfinitos> {
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
                    AppLocalizations.of(context)!.limitesLimitesInfinitos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.limitesLimitesInfinitos,
                        widgetName: kWidgetLimitesLimitesInfinitos,
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
                                )!.limitesLimitesInfinitos,
                                widgetName: kWidgetLimitesLimitesInfinitos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.limitesLimitesInfinitos,
                                widgetName: kWidgetLimitesLimitesInfinitos,
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
                  Latex(
                    formulaText:
                        r"\lim_{x \to 0^{+}} \frac{1}{x^{r}} = +\infty",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\lim_{x \to 0^{-}} \frac{1}{x^{r}} = \begin{cases} -\infty & \text{si } r \text{ es impar} \\ +\infty & \text{si } r \text{ es par} \end{cases}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\lim_{x \to a} \frac{g(x)}{f(x)} = +\infty",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\lim_{x \to a} \frac{g(x)}{f(x)} = -\infty",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\lim_{x \to a} \frac{g(x)}{f(x)} = -\infty",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\lim_{x \to a} \frac{g(x)}{f(x)} = +\infty",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLimitesLimitesInfinitos),
            const DescargarPDF(url: kWidgetLimitesLimitesInfinitos),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
