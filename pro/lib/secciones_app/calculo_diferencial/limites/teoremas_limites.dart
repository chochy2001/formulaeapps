import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LimitesTeoremasLimites extends StatefulWidget {
  const LimitesTeoremasLimites({super.key});

  @override
  LimitesTeoremasLimitesState createState() => LimitesTeoremasLimitesState();
}

class LimitesTeoremasLimitesState extends State<LimitesTeoremasLimites> {
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
                    AppLocalizations.of(context)!.limitesTeoremasLimites,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.limitesTeoremasLimites,
                        widgetName: kWidgetLimitesTeoremasLimites,
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
                                title: AppLocalizations.of(context)!.limitesTeoremasLimites,
                                widgetName: kWidgetLimitesTeoremasLimites,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.limitesTeoremasLimites,
                                widgetName: kWidgetLimitesTeoremasLimites,
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
                  Latex(formulaText: r"\lim_{x \to a} f(x) = L"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to a} f(x) = L_1 \;\wedge\; \lim_{x \to a} f(x) = L_2 \;\Rightarrow\; L_1 = L_2"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to a} x = a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to a} \sqrt[n]{f(x)} = \sqrt[n]{L}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLimitesTeoremasLimites),
            const DescargarPDF(url: kWidgetLimitesTeoremasLimites),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
