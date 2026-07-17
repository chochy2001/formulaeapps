import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DistribucionesDistribucionDePascal extends StatefulWidget {
  const DistribucionesDistribucionDePascal({super.key});

  @override
  DistribucionesDistribucionDePascalState createState() => DistribucionesDistribucionDePascalState();
}

class DistribucionesDistribucionDePascalState extends State<DistribucionesDistribucionDePascal> {
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
                    AppLocalizations.of(context)!.distribucionesDistribucionDePascal,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.distribucionesDistribucionDePascal,
                        widgetName: kWidgetDistribucionesDistribucionDePascal,
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
                                title: AppLocalizations.of(context)!.distribucionesDistribucionDePascal,
                                widgetName: kWidgetDistribucionesDistribucionDePascal,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.distribucionesDistribucionDePascal,
                                widgetName: kWidgetDistribucionesDistribucionDePascal,
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
                  Latex(formulaText: r"P_x(X_0) = \begin{cases} \dbinom{X_0-1}{n-1} P^{n} (1-P)^{\,X_0-n} & X_0 = n, n+1, n+2, \ldots \\ 0 & \text{cualquier otro caso} \end{cases}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E(X) = \frac{n}{P}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x^{2} = \frac{n(1-P)}{P^{2}}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDistribucionesDistribucionDePascal),
            const DescargarPDF(url: kWidgetDistribucionesDistribucionDePascal),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
