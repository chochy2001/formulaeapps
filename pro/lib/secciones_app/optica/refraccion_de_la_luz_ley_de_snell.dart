import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class RefraccionDeLaLuzLeyDeSnell extends StatefulWidget {
  const RefraccionDeLaLuzLeyDeSnell({super.key});

  @override
  RefraccionDeLaLuzLeyDeSnellState createState() =>
      RefraccionDeLaLuzLeyDeSnellState();
}

class RefraccionDeLaLuzLeyDeSnellState
    extends State<RefraccionDeLaLuzLeyDeSnell> {
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
                    AppLocalizations.of(context)!.refraccionDeLaLuzLeyDeSnell,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.refraccionDeLaLuzLeyDeSnell,
                        widgetName: kWidgetRefraccionDeLaLuzLeyDeSnell,
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
                                )!.refraccionDeLaLuzLeyDeSnell,
                                widgetName: kWidgetRefraccionDeLaLuzLeyDeSnell,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.refraccionDeLaLuzLeyDeSnell,
                                widgetName: kWidgetRefraccionDeLaLuzLeyDeSnell,
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
                    formulaText:
                        r"\mu = \frac{\operatorname{sen} i}{\operatorname{sen} r}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\mu = \frac{\operatorname{sen} i}{\operatorname{sen} r} = \frac{V_{1}}{V_{2}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetRefraccionDeLaLuzLeyDeSnell),
            const DescargarPDF(url: kWidgetRefraccionDeLaLuzLeyDeSnell),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
