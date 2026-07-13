import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DistribucionesDistribucionDeErlang extends StatefulWidget {
  const DistribucionesDistribucionDeErlang({super.key});

  @override
  DistribucionesDistribucionDeErlangState createState() => DistribucionesDistribucionDeErlangState();
}

class DistribucionesDistribucionDeErlangState extends State<DistribucionesDistribucionDeErlang> {
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
                    AppLocalizations.of(context)!.distribucionesDistribucionDeErlang,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.distribucionesDistribucionDeErlang,
                        widgetName: kWidgetDistribucionesDistribucionDeErlang,
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
                                title: AppLocalizations.of(context)!.distribucionesDistribucionDeErlang,
                                widgetName: kWidgetDistribucionesDistribucionDeErlang,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.distribucionesDistribucionDeErlang,
                                widgetName: kWidgetDistribucionesDistribucionDeErlang,
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
                  Latex(formulaText: r"f_x(X_0) = \begin{cases} \dfrac{a^{n}\, X_0^{\,n-1}\, e^{-a X_0}}{(n-1)!} & X_0 > 0 \\ 0 & \text{cualquier otro caso} \end{cases}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E(X) = \dfrac{n}{a}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x^{2} = \dfrac{n}{a^{2}}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDistribucionesDistribucionDeErlang),
            const DescargarPDF(url: kWidgetDistribucionesDistribucionDeErlang),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
