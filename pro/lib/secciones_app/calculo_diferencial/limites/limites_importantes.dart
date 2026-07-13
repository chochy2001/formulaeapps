import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LimitesLimitesImportantes extends StatefulWidget {
  const LimitesLimitesImportantes({super.key});

  @override
  LimitesLimitesImportantesState createState() => LimitesLimitesImportantesState();
}

class LimitesLimitesImportantesState extends State<LimitesLimitesImportantes> {
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
                    AppLocalizations.of(context)!.limitesLimitesImportantes,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.limitesLimitesImportantes,
                        widgetName: kWidgetLimitesLimitesImportantes,
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
                                title: AppLocalizations.of(context)!.limitesLimitesImportantes,
                                widgetName: kWidgetLimitesLimitesImportantes,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.limitesLimitesImportantes,
                                widgetName: kWidgetLimitesLimitesImportantes,
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
                  Latex(formulaText: r"\lim_{\theta \to 0} \frac{\cos\theta}{\theta} = \infty"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to \infty} \left( 1 + \frac{1}{x} \right)^{x} = e"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to 0} (1+x)^{1/x} = e"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to 0} \frac{e^{x} - 1}{x} = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to 1} \frac{x - 1}{\ln x} = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLimitesLimitesImportantes),
            const DescargarPDF(url: kWidgetLimitesLimitesImportantes),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
