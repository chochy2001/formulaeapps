import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class Hidrostatica extends StatefulWidget {
  const Hidrostatica({super.key});

  @override
  HidrostaticaState createState() => HidrostaticaState();
}

class HidrostaticaState extends State<Hidrostatica> {
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
                    AppLocalizations.of(context)!.hidrostatica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.hidrostatica,
                        widgetName: kWidgetHidrostatica,
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
                                )!.hidrostatica,
                                widgetName: kWidgetHidrostatica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.hidrostatica,
                                widgetName: kWidgetHidrostatica,
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
                  Latex(formulaText: r"P = \frac{F}{A}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\rho = \frac{m}{V}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\gamma = \frac{W}{V}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\gamma = \rho g"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P_h = \gamma h"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P_h = \rho g h"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P = \rho g h + P_0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\rho_r = \frac{\rho_{(\text{objeto})}}{\rho_{(\text{agua})}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E = W_R - W_A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E = m g"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E = \gamma V"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"E = \rho g V"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetHidrostatica),
            const DescargarPDF(url: kWidgetHidrostatica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
