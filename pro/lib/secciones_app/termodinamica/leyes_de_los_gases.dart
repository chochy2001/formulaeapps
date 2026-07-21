import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LeyesDeLosGases extends StatefulWidget {
  const LeyesDeLosGases({super.key});

  @override
  LeyesDeLosGasesState createState() => LeyesDeLosGasesState();
}

class LeyesDeLosGasesState extends State<LeyesDeLosGases> {
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
                    AppLocalizations.of(context)!.leyesDeLosGases,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.leyesDeLosGases,
                        widgetName: kWidgetLeyesDeLosGases,
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
                                )!.leyesDeLosGases,
                                widgetName: kWidgetLeyesDeLosGases,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.leyesDeLosGases,
                                widgetName: kWidgetLeyesDeLosGases,
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
                    formulaText: r"\frac{P_1 V_1}{T_1} = \frac{P_2 V_2}{T_2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{V_1}{T_1} = \frac{V_2}{T_2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{P_1 V_1}{m_1 T_1} = \frac{P_2 V_2}{m_2 T_2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{P_1}{T_1} = \frac{P_2}{T_2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P_1 V_1 = P_2 V_2"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"PV = nRT"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"n = \frac{m}{M}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"R = 8.314\ \mathrm{J\,mol^{-1}\,K^{-1}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLeyesDeLosGases),
            const DescargarPDF(url: kWidgetLeyesDeLosGases),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
