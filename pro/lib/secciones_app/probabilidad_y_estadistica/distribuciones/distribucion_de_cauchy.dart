import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DistribucionesDistribucionDeCauchy extends StatefulWidget {
  const DistribucionesDistribucionDeCauchy({super.key});

  @override
  DistribucionesDistribucionDeCauchyState createState() =>
      DistribucionesDistribucionDeCauchyState();
}

class DistribucionesDistribucionDeCauchyState
    extends State<DistribucionesDistribucionDeCauchy> {
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
                    )!.distribucionesDistribucionDeCauchy,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.distribucionesDistribucionDeCauchy,
                        widgetName: kWidgetDistribucionesDistribucionDeCauchy,
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
                                )!.distribucionesDistribucionDeCauchy,
                                widgetName:
                                    kWidgetDistribucionesDistribucionDeCauchy,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.distribucionesDistribucionDeCauchy,
                                widgetName:
                                    kWidgetDistribucionesDistribucionDeCauchy,
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
                        r"f_x(X_0) = \dfrac{1}{\pi}\,\dfrac{a}{a^{2} + (X_0 - b)^{2}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E(X) = b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x^{2} = \infty"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDistribucionesDistribucionDeCauchy),
            const DescargarPDF(url: kWidgetDistribucionesDistribucionDeCauchy),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
