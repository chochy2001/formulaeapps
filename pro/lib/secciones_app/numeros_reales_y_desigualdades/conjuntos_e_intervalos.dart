import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ConjuntosEIntervalos extends StatefulWidget {
  const ConjuntosEIntervalos({super.key});

  @override
  ConjuntosEIntervalosState createState() => ConjuntosEIntervalosState();
}

class ConjuntosEIntervalosState extends State<ConjuntosEIntervalos> {
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
                    AppLocalizations.of(context)!.conjuntosEIntervalos,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.conjuntosEIntervalos,
                        widgetName: kWidgetConjuntosEIntervalos,
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
                                title: AppLocalizations.of(context)!.conjuntosEIntervalos,
                                widgetName: kWidgetConjuntosEIntervalos,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.conjuntosEIntervalos,
                                widgetName: kWidgetConjuntosEIntervalos,
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
                  Latex(formulaText: r"A \subset B \iff \forall x \in A,\ x \in B"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x \in A \cap B \iff x \in A \ \text{y}\ x \in B"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x \in A \cup B \iff x \in A \ \text{o}\ x \in B"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(a, b) = \{\, x \mid a < x < b \,\}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"[a, b] = \{\, x \mid a \le x \le b \,\}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetConjuntosEIntervalos),
            const DescargarPDF(url: kWidgetConjuntosEIntervalos),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
