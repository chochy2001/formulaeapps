import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AlgebraLinealVectoresSumaVectoresComponentes extends StatefulWidget {
  const AlgebraLinealVectoresSumaVectoresComponentes({super.key});

  @override
  AlgebraLinealVectoresSumaVectoresComponentesState createState() =>
      AlgebraLinealVectoresSumaVectoresComponentesState();
}

class AlgebraLinealVectoresSumaVectoresComponentesState
    extends State<AlgebraLinealVectoresSumaVectoresComponentes> {
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
                    )!.algebraLinealVectoresSumaVectoresComponentes,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.algebraLinealVectoresSumaVectoresComponentes,
                        widgetName:
                            kWidgetAlgebraLinealVectoresSumaVectoresComponentes,
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
                                )!.algebraLinealVectoresSumaVectoresComponentes,
                                widgetName:
                                    kWidgetAlgebraLinealVectoresSumaVectoresComponentes,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.algebraLinealVectoresSumaVectoresComponentes,
                                widgetName:
                                    kWidgetAlgebraLinealVectoresSumaVectoresComponentes,
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
                  Latex(formulaText: r"R_{x} = \sum_{i=1}^{n} F_{x_i}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"R_{y} = \sum_{i=1}^{n} F_{y_i}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F_{x} = F\cos\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F_{y} = F\operatorname{sen}\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(
              url: kWidgetAlgebraLinealVectoresSumaVectoresComponentes,
            ),
            const DescargarPDF(
              url: kWidgetAlgebraLinealVectoresSumaVectoresComponentes,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
