import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AlgebraLinealVectoresLeySenosCosenos extends StatefulWidget {
  const AlgebraLinealVectoresLeySenosCosenos({super.key});

  @override
  AlgebraLinealVectoresLeySenosCosenosState createState() =>
      AlgebraLinealVectoresLeySenosCosenosState();
}

class AlgebraLinealVectoresLeySenosCosenosState
    extends State<AlgebraLinealVectoresLeySenosCosenos> {
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
                    AppLocalizations.of(
                      context,
                    )!.algebraLinealVectoresLeySenosCosenos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.algebraLinealVectoresLeySenosCosenos,
                        widgetName: kWidgetAlgebraLinealVectoresLeySenosCosenos,
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
                                )!.algebraLinealVectoresLeySenosCosenos,
                                widgetName:
                                    kWidgetAlgebraLinealVectoresLeySenosCosenos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.algebraLinealVectoresLeySenosCosenos,
                                widgetName:
                                    kWidgetAlgebraLinealVectoresLeySenosCosenos,
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
                        r"\frac{a}{\operatorname{sen} A} = \frac{b}{\operatorname{sen} B} = \frac{c}{\operatorname{sen} C}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\cos A = \frac{b^{2} + c^{2} - a^{2}}{2bc}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\cos B = \frac{a^{2} + c^{2} - b^{2}}{2ac}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\cos C = \frac{a^{2} + b^{2} - c^{2}}{2ab}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a^{2} = b^{2} + c^{2} - 2bc\cos A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"b^{2} = a^{2} + c^{2} - 2ac\cos B"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"c^{2} = a^{2} + b^{2} - 2ab\cos C"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAlgebraLinealVectoresLeySenosCosenos),
            const DescargarPDF(
              url: kWidgetAlgebraLinealVectoresLeySenosCosenos,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
