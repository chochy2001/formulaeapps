import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LeyesDeNewton extends StatefulWidget {
  const LeyesDeNewton({super.key});

  @override
  LeyesDeNewtonState createState() => LeyesDeNewtonState();
}

class LeyesDeNewtonState extends State<LeyesDeNewton> {
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
                    AppLocalizations.of(context)!.leyesDeNewton,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.leyesDeNewton,
                        widgetName: kWidgetLeyesDeNewton,
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
                                )!.leyesDeNewton,
                                widgetName: kWidgetLeyesDeNewton,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.leyesDeNewton,
                                widgetName: kWidgetLeyesDeNewton,
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
                  Latex(formulaText: r"a = \frac{F}{m}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"F = m\,a = \mathrm{kg}\,\frac{m}{s^{2}} = \text{Newton (N)}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"F = m\,a = \mathrm{g}\,\frac{cm}{s^{2}} = \text{Dina}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"1\ \text{N} = 1 \times 10^{5}\ \text{Dinas}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F - P = m\,a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P - F = m\,a"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLeyesDeNewton),
            const DescargarPDF(url: kWidgetLeyesDeNewton),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
