import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MovimientoCircularUniforme extends StatefulWidget {
  const MovimientoCircularUniforme({super.key});

  @override
  MovimientoCircularUniformeState createState() =>
      MovimientoCircularUniformeState();
}

class MovimientoCircularUniformeState
    extends State<MovimientoCircularUniforme> {
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
                    AppLocalizations.of(context)!.movimientoCircularUniforme,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.movimientoCircularUniforme,
                        widgetName: kWidgetMovimientoCircularUniforme,
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
                                )!.movimientoCircularUniforme,
                                widgetName: kWidgetMovimientoCircularUniforme,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.movimientoCircularUniforme,
                                widgetName: kWidgetMovimientoCircularUniforme,
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
                  Latex(formulaText: r"2\pi\ \mathrm{rad} = 360^{\circ}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{rad} = \frac{360^{\circ}}{2\pi} = \frac{180^{\circ}}{\pi} = 57.3^{\circ}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"T = \frac{\text{segundos transcurridos}}{1\ \text{ciclo}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"F = \frac{\text{Numero de ciclos}}{1\ \text{segundo}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F = \frac{1}{T}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"T = \frac{1}{F}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\omega = \frac{\theta}{t}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\omega = \frac{2\pi}{T}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\omega = 2\pi F"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\omega_m = \frac{\omega_f + \omega_0}{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\theta = \omega t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\theta = \frac{S}{R}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V = r\,\omega"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetMovimientoCircularUniforme),
            const DescargarPDF(url: kWidgetMovimientoCircularUniforme),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
