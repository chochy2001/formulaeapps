import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CicloDeCarnotYLeyesDeLaTermodinamica extends StatefulWidget {
  const CicloDeCarnotYLeyesDeLaTermodinamica({super.key});

  @override
  CicloDeCarnotYLeyesDeLaTermodinamicaState createState() => CicloDeCarnotYLeyesDeLaTermodinamicaState();
}

class CicloDeCarnotYLeyesDeLaTermodinamicaState extends State<CicloDeCarnotYLeyesDeLaTermodinamica> {
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
                    AppLocalizations.of(context)!.cicloDeCarnotYLeyesDeLaTermodinamica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.cicloDeCarnotYLeyesDeLaTermodinamica,
                        widgetName: kWidgetCicloDeCarnotYLeyesDeLaTermodinamica,
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
                                title: AppLocalizations.of(context)!.cicloDeCarnotYLeyesDeLaTermodinamica,
                                widgetName: kWidgetCicloDeCarnotYLeyesDeLaTermodinamica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.cicloDeCarnotYLeyesDeLaTermodinamica,
                                widgetName: kWidgetCicloDeCarnotYLeyesDeLaTermodinamica,
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
                  Latex(formulaText: r"C_P - C_V = R"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta Q = \Delta W + \Delta U"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta U = \Delta Q - \Delta W"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"W = Q_{ent} - Q_{sal}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\eta = \frac{Q_{ent} - Q_{sal}}{Q_{ent}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\eta = \frac{T_{ent} - T_{sal}}{T_{ent}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\eta = \frac{Q_{frio}}{W} = \frac{Q_{frio}}{Q_{caliente} - Q_{frio}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\eta = \frac{T_{frio}}{T_{caliente} - T_{frio}}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCicloDeCarnotYLeyesDeLaTermodinamica),
            const DescargarPDF(url: kWidgetCicloDeCarnotYLeyesDeLaTermodinamica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
