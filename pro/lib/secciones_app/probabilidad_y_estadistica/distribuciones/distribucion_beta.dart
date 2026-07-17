import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DistribucionesDistribucionBeta extends StatefulWidget {
  const DistribucionesDistribucionBeta({super.key});

  @override
  DistribucionesDistribucionBetaState createState() => DistribucionesDistribucionBetaState();
}

class DistribucionesDistribucionBetaState extends State<DistribucionesDistribucionBeta> {
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
                    AppLocalizations.of(context)!.distribucionesDistribucionBeta,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.distribucionesDistribucionBeta,
                        widgetName: kWidgetDistribucionesDistribucionBeta,
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
                                title: AppLocalizations.of(context)!.distribucionesDistribucionBeta,
                                widgetName: kWidgetDistribucionesDistribucionBeta,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.distribucionesDistribucionBeta,
                                widgetName: kWidgetDistribucionesDistribucionBeta,
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
                  Latex(formulaText: r"f_x(X_0) = \begin{cases} \dfrac{1}{B}\, X_0^{\,r-1}\,(1-X_0)^{\,t-r-1} & 0 \le X_0 \le 1 \\ 0 & \text{cualquier otro caso} \end{cases}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"B = \dfrac{(r-1)!\,(t-r-1)!}{(t-1)!}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E(X) = \dfrac{r}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x^{2} = \dfrac{r\,(t-r)}{t^{2}\,(t+1)}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDistribucionesDistribucionBeta),
            const DescargarPDF(url: kWidgetDistribucionesDistribucionBeta),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
