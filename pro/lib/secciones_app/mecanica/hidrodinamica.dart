import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class Hidrodinamica extends StatefulWidget {
  const Hidrodinamica({super.key});

  @override
  HidrodinamicaState createState() => HidrodinamicaState();
}

class HidrodinamicaState extends State<Hidrodinamica> {
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
                    AppLocalizations.of(context)!.hidrodinamica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.hidrodinamica,
                        widgetName: kWidgetHidrodinamica,
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
                                )!.hidrodinamica,
                                widgetName: kWidgetHidrodinamica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.hidrodinamica,
                                widgetName: kWidgetHidrodinamica,
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
                  Latex(formulaText: r"G = V A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"G = \frac{V}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"G = \frac{\Delta V}{A\,t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"G = A_1 V_1 = A_2 V_2"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"A_1 V_1 = A_2 V_2"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{\partial \rho}{\partial t} + \nabla \cdot (\rho \vec{V}) = 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V = \sqrt{2gh}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V = \sqrt{2gH}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"G = A\sqrt{2gh}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(P_1 - P_2) = \rho g (h_1 - h_2)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"P + \rho g h + \frac{1}{2}\rho v^{2} = \text{cte.}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"P_1 + \rho g h_1 + \frac{1}{2}\rho v_1^{2} = P_2 + \rho g h_2 + \frac{1}{2}\rho v_2^{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"N = \frac{d\,v\,D}{n}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetHidrodinamica),
            const DescargarPDF(url: kWidgetHidrodinamica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
