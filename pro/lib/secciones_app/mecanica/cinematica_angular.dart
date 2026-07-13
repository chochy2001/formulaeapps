import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CinematicaAngular extends StatefulWidget {
  const CinematicaAngular({super.key});

  @override
  CinematicaAngularState createState() => CinematicaAngularState();
}

class CinematicaAngularState extends State<CinematicaAngular> {
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
                    AppLocalizations.of(context)!.cinematicaAngular,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.cinematicaAngular,
                        widgetName: kWidgetCinematicaAngular,
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
                                title: AppLocalizations.of(context)!.cinematicaAngular,
                                widgetName: kWidgetCinematicaAngular,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.cinematicaAngular,
                                widgetName: kWidgetCinematicaAngular,
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
                  Latex(formulaText: r"\alpha = \frac{\omega_f - \omega_0}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\omega_f = \omega_0 + \alpha t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\theta = \omega_0 t + \frac{\alpha t^{2}}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\omega_f^{2} = \omega_0^{2} + 2 \alpha \theta"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCinematicaAngular),
            const DescargarPDF(url: kWidgetCinematicaAngular),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
