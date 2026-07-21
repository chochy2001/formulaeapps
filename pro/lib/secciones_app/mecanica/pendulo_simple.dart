import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PenduloSimple extends StatefulWidget {
  const PenduloSimple({super.key});

  @override
  PenduloSimpleState createState() => PenduloSimpleState();
}

class PenduloSimpleState extends State<PenduloSimple> {
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
                    AppLocalizations.of(context)!.penduloSimple,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.penduloSimple,
                        widgetName: kWidgetPenduloSimple,
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
                                )!.penduloSimple,
                                widgetName: kWidgetPenduloSimple,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.penduloSimple,
                                widgetName: kWidgetPenduloSimple,
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
                  Latex(
                    formulaText: r"\operatorname{sen}\theta = \frac{\gamma}{l}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\operatorname{sen}\theta = \frac{F_{res}}{P}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"T = 2\pi \sqrt{\frac{l}{g}}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPenduloSimple),
            const DescargarPDF(url: kWidgetPenduloSimple),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
