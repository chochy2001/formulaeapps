import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class EsperanzaMediaYVarianza extends StatefulWidget {
  const EsperanzaMediaYVarianza({super.key});

  @override
  EsperanzaMediaYVarianzaState createState() => EsperanzaMediaYVarianzaState();
}

class EsperanzaMediaYVarianzaState extends State<EsperanzaMediaYVarianza> {
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
                    AppLocalizations.of(context)!.esperanzaMediaYVarianza,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.esperanzaMediaYVarianza,
                        widgetName: kWidgetEsperanzaMediaYVarianza,
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
                                title: AppLocalizations.of(context)!.esperanzaMediaYVarianza,
                                widgetName: kWidgetEsperanzaMediaYVarianza,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.esperanzaMediaYVarianza,
                                widgetName: kWidgetEsperanzaMediaYVarianza,
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
                  Latex(formulaText: r"E[g(X)] = \begin{cases} \displaystyle\sum_{X_0} g(X_0)\, P_x(X_0) & X \text{ discreta} \\ \displaystyle\int_{X_0=-\infty}^{\infty} g(X_0)\, f_x(X_0)\, dX_0 & X \text{ continua} \end{cases}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\bar{X} = E(X) = \begin{cases} \displaystyle\sum_{X_0} X_0\, P_x(X_0) & X \text{ discreta} \\ \displaystyle\int_{X_0=-\infty}^{\infty} X_0\, f_x(X_0)\, dX_0 & X \text{ continua} \end{cases}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x^{2} = E\!\left[(X-\bar{X})^{2}\right] = \begin{cases} \displaystyle\sum_{X_0} (X_0-\bar{X})^{2}\, P_x(X_0) & X \text{ discreta} \\ \displaystyle\int_{X_0=-\infty}^{\infty} (X_0-\bar{X})^{2}\, f_x(X_0)\, dX_0 & X \text{ continua} \end{cases}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x^{2} = E(X^{2}) - [E(X)]^{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sigma_x = \sqrt{E(X^{2}) - [E(X)]^{2}}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEsperanzaMediaYVarianza),
            const DescargarPDF(url: kWidgetEsperanzaMediaYVarianza),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
