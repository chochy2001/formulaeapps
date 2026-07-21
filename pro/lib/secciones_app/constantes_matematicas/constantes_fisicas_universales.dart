import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ConstantesFisicasUniversales extends StatefulWidget {
  const ConstantesFisicasUniversales({super.key});

  @override
  ConstantesFisicasUniversalesState createState() =>
      ConstantesFisicasUniversalesState();
}

class ConstantesFisicasUniversalesState
    extends State<ConstantesFisicasUniversales> {
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
                    AppLocalizations.of(context)!.constantesFisicasUniversales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.constantesFisicasUniversales,
                        widgetName: kWidgetConstantesFisicasUniversales,
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
                                )!.constantesFisicasUniversales,
                                widgetName: kWidgetConstantesFisicasUniversales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.constantesFisicasUniversales,
                                widgetName: kWidgetConstantesFisicasUniversales,
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
                        r"c = 299\,792\,458\ \mathrm{m\,s^{-1}}\quad\text{(exacta por definición SI)}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"G = 6.674\,30(15) \times 10^{-11}\ \mathrm{m^{3}\,kg^{-1}\,s^{-2}}\quad\text{(valor medido; incertidumbre estándar 0.000\,15 \times 10^{-11})}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"h = 6.626\,070\,15 \times 10^{-34}\ \mathrm{J\,s}\quad\text{(exacta por definición SI)}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"k = 1.380\,649 \times 10^{-23}\ \mathrm{J\,K^{-1}}\quad\text{(exacta por definición SI)}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"N_A = 6.022\,140\,76 \times 10^{23}\ \mathrm{mol^{-1}}\quad\text{(exacta por definición SI)}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\sigma = 5.670\,374\,419\ldots \times 10^{-8}\ \mathrm{W\,m^{-2}\,K^{-4}}\quad\text{(exacta; derivada de constantes SI)}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetConstantesFisicasUniversales),
            const DescargarPDF(url: kWidgetConstantesFisicasUniversales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
