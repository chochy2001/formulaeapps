import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CircuitoLrEnSerie extends StatefulWidget {
  const CircuitoLrEnSerie({super.key});

  @override
  CircuitoLrEnSerieState createState() => CircuitoLrEnSerieState();
}

class CircuitoLrEnSerieState extends State<CircuitoLrEnSerie> {
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
                    AppLocalizations.of(context)!.circuitoLrEnSerie,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.circuitoLrEnSerie,
                        widgetName: kWidgetCircuitoLrEnSerie,
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
                                )!.circuitoLrEnSerie,
                                widgetName: kWidgetCircuitoLrEnSerie,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.circuitoLrEnSerie,
                                widgetName: kWidgetCircuitoLrEnSerie,
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
                  Latex(formulaText: r"V_{R} = i R"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V_{L} = L\,\frac{\Delta i}{\Delta t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\varepsilon - i R - L\,\frac{\Delta i}{\Delta t} = 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\varepsilon = i R + L\,\frac{\Delta i}{\Delta t}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCircuitoLrEnSerie),
            const DescargarPDF(url: kWidgetCircuitoLrEnSerie),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
