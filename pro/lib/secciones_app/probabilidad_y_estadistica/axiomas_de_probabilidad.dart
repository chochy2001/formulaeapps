import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AxiomasDeProbabilidad extends StatefulWidget {
  const AxiomasDeProbabilidad({super.key});

  @override
  AxiomasDeProbabilidadState createState() => AxiomasDeProbabilidadState();
}

class AxiomasDeProbabilidadState extends State<AxiomasDeProbabilidad> {
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
                    AppLocalizations.of(context)!.axiomasDeProbabilidad,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.axiomasDeProbabilidad,
                        widgetName: kWidgetAxiomasDeProbabilidad,
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
                                title: AppLocalizations.of(context)!.axiomasDeProbabilidad,
                                widgetName: kWidgetAxiomasDeProbabilidad,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.axiomasDeProbabilidad,
                                widgetName: kWidgetAxiomasDeProbabilidad,
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
                  Latex(formulaText: r"P(A) \geq 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P(U) = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P(A + B) = P(A) + P(B) \quad \text{si } AB = \varnothing"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P(A \mid B) = \frac{P(AB)}{P(B)}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P(A \mid B) = P(A)"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAxiomasDeProbabilidad),
            const DescargarPDF(url: kWidgetAxiomasDeProbabilidad),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
