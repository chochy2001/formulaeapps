import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeLaIluminacion extends StatefulWidget {
  const LeyDeLaIluminacion({super.key});

  @override
  LeyDeLaIluminacionState createState() => LeyDeLaIluminacionState();
}

class LeyDeLaIluminacionState extends State<LeyDeLaIluminacion> {
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
                    AppLocalizations.of(context)!.leyDeLaIluminacion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.leyDeLaIluminacion,
                        widgetName: kWidgetLeyDeLaIluminacion,
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
                                title: AppLocalizations.of(context)!.leyDeLaIluminacion,
                                widgetName: kWidgetLeyDeLaIluminacion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.leyDeLaIluminacion,
                                widgetName: kWidgetLeyDeLaIluminacion,
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
                  Latex(formulaText: r"E = \frac{I}{d^{2}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{Watt} = 1.1\ \text{Candelas}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLeyDeLaIluminacion),
            const DescargarPDF(url: kWidgetLeyDeLaIluminacion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
