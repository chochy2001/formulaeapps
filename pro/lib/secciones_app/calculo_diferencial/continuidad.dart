import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class Continuidad extends StatefulWidget {
  const Continuidad({super.key});

  @override
  ContinuidadState createState() => ContinuidadState();
}

class ContinuidadState extends State<Continuidad> {
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
                    AppLocalizations.of(context)!.continuidad,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.continuidad,
                        widgetName: kWidgetContinuidad,
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
                                title: AppLocalizations.of(context)!.continuidad,
                                widgetName: kWidgetContinuidad,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.continuidad,
                                widgetName: kWidgetContinuidad,
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
                  Latex(formulaText: r"f(a) \ \text{existe}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to a} f(x) \ \text{existe}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\lim_{x \to a} f(x) = f(a)"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetContinuidad),
            const DescargarPDF(url: kWidgetContinuidad),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
