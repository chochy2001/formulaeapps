import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AlgebraLinealVectoresProductoEscalarTriple extends StatefulWidget {
  const AlgebraLinealVectoresProductoEscalarTriple({super.key});

  @override
  AlgebraLinealVectoresProductoEscalarTripleState createState() =>
      AlgebraLinealVectoresProductoEscalarTripleState();
}

class AlgebraLinealVectoresProductoEscalarTripleState
    extends State<AlgebraLinealVectoresProductoEscalarTriple> {
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
                    )!.algebraLinealVectoresProductoEscalarTriple,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.algebraLinealVectoresProductoEscalarTriple,
                        widgetName:
                            kWidgetAlgebraLinealVectoresProductoEscalarTriple,
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
                                )!.algebraLinealVectoresProductoEscalarTriple,
                                widgetName:
                                    kWidgetAlgebraLinealVectoresProductoEscalarTriple,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.algebraLinealVectoresProductoEscalarTriple,
                                widgetName:
                                    kWidgetAlgebraLinealVectoresProductoEscalarTriple,
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
                        r"\left| \vec{V}_A \times \vec{V}_B \right| = V_A\,V_B\,\operatorname{sen}\alpha",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\vec{V}_A \cdot \left( \vec{V}_B \times \vec{V}_C \right)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"V = V_A\,V_B\,V_C\,\operatorname{sen}\alpha\,\cos\beta",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(
              url: kWidgetAlgebraLinealVectoresProductoEscalarTriple,
            ),
            const DescargarPDF(
              url: kWidgetAlgebraLinealVectoresProductoEscalarTriple,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
