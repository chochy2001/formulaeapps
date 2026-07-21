import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DistribucionesDistribucionDeBernoulli extends StatefulWidget {
  const DistribucionesDistribucionDeBernoulli({super.key});

  @override
  DistribucionesDistribucionDeBernoulliState createState() =>
      DistribucionesDistribucionDeBernoulliState();
}

class DistribucionesDistribucionDeBernoulliState
    extends State<DistribucionesDistribucionDeBernoulli> {
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
                    )!.distribucionesDistribucionDeBernoulli,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.distribucionesDistribucionDeBernoulli,
                        widgetName:
                            kWidgetDistribucionesDistribucionDeBernoulli,
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
                                )!.distribucionesDistribucionDeBernoulli,
                                widgetName:
                                    kWidgetDistribucionesDistribucionDeBernoulli,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.distribucionesDistribucionDeBernoulli,
                                widgetName:
                                    kWidgetDistribucionesDistribucionDeBernoulli,
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
                        r"P_x(X_0) = \begin{cases} P & X_0 = 1 \\ 1-P & X_0 = 0 \\ 0 & \text{cualquier otro caso} \end{cases}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E(X) = P"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x^{2} = P(1-P)"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDistribucionesDistribucionDeBernoulli),
            const DescargarPDF(
              url: kWidgetDistribucionesDistribucionDeBernoulli,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
