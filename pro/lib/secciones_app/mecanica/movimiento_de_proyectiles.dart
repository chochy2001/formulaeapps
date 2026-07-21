import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MovimientoDeProyectiles extends StatefulWidget {
  const MovimientoDeProyectiles({super.key});

  @override
  MovimientoDeProyectilesState createState() => MovimientoDeProyectilesState();
}

class MovimientoDeProyectilesState extends State<MovimientoDeProyectiles> {
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
                    AppLocalizations.of(context)!.movimientoDeProyectiles,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.movimientoDeProyectiles,
                        widgetName: kWidgetMovimientoDeProyectiles,
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
                                )!.movimientoDeProyectiles,
                                widgetName: kWidgetMovimientoDeProyectiles,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.movimientoDeProyectiles,
                                widgetName: kWidgetMovimientoDeProyectiles,
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
                    formulaText: r"T = \frac{2 V \operatorname{sen}\theta}{g}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"H = \frac{(V \operatorname{sen}\theta)^{2}}{2g}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan\theta = \frac{h}{d}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"R = \frac{V^{2}}{g}\,\operatorname{sen} 2\theta",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetMovimientoDeProyectiles),
            const DescargarPDF(url: kWidgetMovimientoDeProyectiles),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
