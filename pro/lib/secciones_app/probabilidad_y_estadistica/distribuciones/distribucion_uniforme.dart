import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DistribucionesDistribucionUniforme extends StatefulWidget {
  const DistribucionesDistribucionUniforme({super.key});

  @override
  DistribucionesDistribucionUniformeState createState() =>
      DistribucionesDistribucionUniformeState();
}

class DistribucionesDistribucionUniformeState
    extends State<DistribucionesDistribucionUniforme> {
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
                    )!.distribucionesDistribucionUniforme,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.distribucionesDistribucionUniforme,
                        widgetName: kWidgetDistribucionesDistribucionUniforme,
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
                                )!.distribucionesDistribucionUniforme,
                                widgetName:
                                    kWidgetDistribucionesDistribucionUniforme,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.distribucionesDistribucionUniforme,
                                widgetName:
                                    kWidgetDistribucionesDistribucionUniforme,
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
                        r"f_x(X_0) = \begin{cases} \dfrac{1}{b-a} & a \le X_0 \le b \\ 0 & \text{cualquier otro caso} \end{cases}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E(X) = \dfrac{a+b}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x^{2} = \dfrac{(b-a)^{2}}{12}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDistribucionesDistribucionUniforme),
            const DescargarPDF(url: kWidgetDistribucionesDistribucionUniforme),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
