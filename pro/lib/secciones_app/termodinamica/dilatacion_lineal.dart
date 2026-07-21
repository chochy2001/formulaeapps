import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DilatacionLineal extends StatefulWidget {
  const DilatacionLineal({super.key});

  @override
  DilatacionLinealState createState() => DilatacionLinealState();
}

class DilatacionLinealState extends State<DilatacionLineal> {
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
                    AppLocalizations.of(context)!.dilatacionLineal,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.dilatacionLineal,
                        widgetName: kWidgetDilatacionLineal,
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
                                )!.dilatacionLineal,
                                widgetName: kWidgetDilatacionLineal,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.dilatacionLineal,
                                widgetName: kWidgetDilatacionLineal,
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
                  Latex(formulaText: r"\frac{\Delta L}{L} = \alpha\,\Delta T"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"L = L_0 + \alpha L_0\,\Delta t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta L = \alpha L_0\,\Delta t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\alpha = \frac{\Delta L}{L_0\,\Delta t}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\alpha_L = \frac{1}{L}\left(\frac{dL}{dT}\right)_p = \left(\frac{d\ln L}{dT}\right)_p \approx \frac{1}{L}\left(\frac{\Delta L}{\Delta T}\right)_p",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDilatacionLineal),
            const DescargarPDF(url: kWidgetDilatacionLineal),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
