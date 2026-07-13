import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CapacitoresCilindricoYEsferico extends StatefulWidget {
  const CapacitoresCilindricoYEsferico({super.key});

  @override
  CapacitoresCilindricoYEsfericoState createState() => CapacitoresCilindricoYEsfericoState();
}

class CapacitoresCilindricoYEsfericoState extends State<CapacitoresCilindricoYEsferico> {
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
                    AppLocalizations.of(context)!.capacitoresCilindricoYEsferico,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.capacitoresCilindricoYEsferico,
                        widgetName: kWidgetCapacitoresCilindricoYEsferico,
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
                                title: AppLocalizations.of(context)!.capacitoresCilindricoYEsferico,
                                widgetName: kWidgetCapacitoresCilindricoYEsferico,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.capacitoresCilindricoYEsferico,
                                widgetName: kWidgetCapacitoresCilindricoYEsferico,
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
                  Latex(formulaText: r"C = \frac{2\pi\,\varepsilon_{0}\,L}{\ln\!\left(R_{2}/R_{1}\right)}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"C = 4\pi\,\varepsilon\,r"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCapacitoresCilindricoYEsferico),
            const DescargarPDF(url: kWidgetCapacitoresCilindricoYEsferico),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
