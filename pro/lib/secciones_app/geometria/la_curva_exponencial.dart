import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LaCurvaExponencial extends StatefulWidget {
  const LaCurvaExponencial({super.key});

  @override
  LaCurvaExponencialState createState() => LaCurvaExponencialState();
}

class LaCurvaExponencialState extends State<LaCurvaExponencial> {
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
                    AppLocalizations.of(context)!.laCurvaExponencial,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.laCurvaExponencial,
                        widgetName: kWidgetLaCurvaExponencial,
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
                                )!.laCurvaExponencial,
                                widgetName: kWidgetLaCurvaExponencial,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.laCurvaExponencial,
                                widgetName: kWidgetLaCurvaExponencial,
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
                  Latex(formulaText: r"y = a^{x}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x = 0, \quad y = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan\alpha = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e = 2.718\,281\,828\,459\ldots"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLaCurvaExponencial),
            const DescargarPDF(url: kWidgetLaCurvaExponencial),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
