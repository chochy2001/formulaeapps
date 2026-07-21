import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CapacidadCalorificaYCalorLatente extends StatefulWidget {
  const CapacidadCalorificaYCalorLatente({super.key});

  @override
  CapacidadCalorificaYCalorLatenteState createState() =>
      CapacidadCalorificaYCalorLatenteState();
}

class CapacidadCalorificaYCalorLatenteState
    extends State<CapacidadCalorificaYCalorLatente> {
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
                    AppLocalizations.of(
                      context,
                    )!.capacidadCalorificaYCalorLatente,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.capacidadCalorificaYCalorLatente,
                        widgetName: kWidgetCapacidadCalorificaYCalorLatente,
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
                                )!.capacidadCalorificaYCalorLatente,
                                widgetName:
                                    kWidgetCapacidadCalorificaYCalorLatente,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.capacidadCalorificaYCalorLatente,
                                widgetName:
                                    kWidgetCapacidadCalorificaYCalorLatente,
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
                  Latex(formulaText: r"Q = m c \Delta T"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\sum (m c \Delta T)_{\text{perdido}} = \sum (m c \Delta T)_{\text{ganado}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"L_{f} = \frac{Q}{m}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"Q = m L_{f}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"L_{V} = \frac{Q}{m}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"Q = m L_{V}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCapacidadCalorificaYCalorLatente),
            const DescargarPDF(url: kWidgetCapacidadCalorificaYCalorLatente),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
