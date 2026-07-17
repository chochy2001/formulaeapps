import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class BateriaRealVoltajeEnTerminales extends StatefulWidget {
  const BateriaRealVoltajeEnTerminales({super.key});

  @override
  BateriaRealVoltajeEnTerminalesState createState() => BateriaRealVoltajeEnTerminalesState();
}

class BateriaRealVoltajeEnTerminalesState extends State<BateriaRealVoltajeEnTerminales> {
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
                    AppLocalizations.of(context)!.bateriaRealVoltajeEnTerminales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.bateriaRealVoltajeEnTerminales,
                        widgetName: kWidgetBateriaRealVoltajeEnTerminales,
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
                                title: AppLocalizations.of(context)!.bateriaRealVoltajeEnTerminales,
                                widgetName: kWidgetBateriaRealVoltajeEnTerminales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.bateriaRealVoltajeEnTerminales,
                                widgetName: kWidgetBateriaRealVoltajeEnTerminales,
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
                  Latex(formulaText: r"V_{T} = E - I R"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"r = \frac{E - V_{RL}}{I}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"I = \frac{\sum E}{\sum R}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetBateriaRealVoltajeEnTerminales),
            const DescargarPDF(url: kWidgetBateriaRealVoltajeEnTerminales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
