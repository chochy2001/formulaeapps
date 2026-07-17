import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class FuncionesDeProbabilidadConjuntasYCondicionales extends StatefulWidget {
  const FuncionesDeProbabilidadConjuntasYCondicionales({super.key});

  @override
  FuncionesDeProbabilidadConjuntasYCondicionalesState createState() => FuncionesDeProbabilidadConjuntasYCondicionalesState();
}

class FuncionesDeProbabilidadConjuntasYCondicionalesState extends State<FuncionesDeProbabilidadConjuntasYCondicionales> {
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
                    AppLocalizations.of(context)!.funcionesDeProbabilidadConjuntasYCondicionales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.funcionesDeProbabilidadConjuntasYCondicionales,
                        widgetName: kWidgetFuncionesDeProbabilidadConjuntasYCondicionales,
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
                                title: AppLocalizations.of(context)!.funcionesDeProbabilidadConjuntasYCondicionales,
                                widgetName: kWidgetFuncionesDeProbabilidadConjuntasYCondicionales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.funcionesDeProbabilidadConjuntasYCondicionales,
                                widgetName: kWidgetFuncionesDeProbabilidadConjuntasYCondicionales,
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
                  Latex(formulaText: r"0 \leq P_{X,Y,Z}(X_{0}, Y_{0}, Z_{0}) \leq 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sum_{X_{0}} \sum_{Y_{0}} \sum_{Z_{0}} P_{X,Y,Z}(X_{0}, Y_{0}, Z_{0}) = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"0 \leq f_{X,Y,Z}(X_{0}, Y_{0}, Z_{0}) < \infty"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\int_{X_{0}=-\infty}^{\infty} dX_{0} \int_{Y_{0}=-\infty}^{\infty} dY_{0} \int_{Z_{0}=-\infty}^{\infty} dZ_{0} \; f_{X,Y,Z}(X_{0}, Y_{0}, Z_{0}) = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P_{X \mid Y}(X_{0} \mid Y_{0}) = \frac{P_{X,Y}(X_{0}, Y_{0})}{P_{Y}(Y_{0})}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"f_{X \mid Y}(X_{0} \mid Y_{0}) = \frac{f_{X,Y}(X_{0},Y_{0})}{f_{Y}(Y_{0})}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetFuncionesDeProbabilidadConjuntasYCondicionales),
            const DescargarPDF(url: kWidgetFuncionesDeProbabilidadConjuntasYCondicionales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
