import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class TrabajoTermodinamico extends StatefulWidget {
  const TrabajoTermodinamico({super.key});

  @override
  TrabajoTermodinamicoState createState() => TrabajoTermodinamicoState();
}

class TrabajoTermodinamicoState extends State<TrabajoTermodinamico> {
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
                    AppLocalizations.of(context)!.trabajoTermodinamico,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.trabajoTermodinamico,
                        widgetName: kWidgetTrabajoTermodinamico,
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
                                title: AppLocalizations.of(context)!.trabajoTermodinamico,
                                widgetName: kWidgetTrabajoTermodinamico,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.trabajoTermodinamico,
                                widgetName: kWidgetTrabajoTermodinamico,
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
                  Latex(formulaText: r"W_{1,2} = -\int_{V_1}^{V_2} p\, dV"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"W = \int P\, dV"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"W = nRT\,\ln\frac{V_2}{V_1}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"W = P\,\Delta V"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetTrabajoTermodinamico),
            const DescargarPDF(url: kWidgetTrabajoTermodinamico),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
