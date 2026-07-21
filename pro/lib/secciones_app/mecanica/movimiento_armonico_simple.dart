import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MovimientoArmonicoSimple extends StatefulWidget {
  const MovimientoArmonicoSimple({super.key});

  @override
  MovimientoArmonicoSimpleState createState() =>
      MovimientoArmonicoSimpleState();
}

class MovimientoArmonicoSimpleState extends State<MovimientoArmonicoSimple> {
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
                    AppLocalizations.of(context)!.movimientoArmonicoSimple,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.movimientoArmonicoSimple,
                        widgetName: kWidgetMovimientoArmonicoSimple,
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
                                )!.movimientoArmonicoSimple,
                                widgetName: kWidgetMovimientoArmonicoSimple,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.movimientoArmonicoSimple,
                                widgetName: kWidgetMovimientoArmonicoSimple,
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
                  Latex(formulaText: r"\gamma = r \cos(2\pi F t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\gamma = r \cos\theta"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\gamma = r \cos(\omega t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos\theta = \frac{\gamma}{r}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"V = 2\pi F r\,\operatorname{sen}(2\pi F t)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"V = -2\pi F r\,\operatorname{sen}(2\pi F t)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\operatorname{sen}\theta = \frac{V}{V_T}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a = -4\pi^{2} F^{2} r \cos(2\pi F t)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a = -4\pi^{2} F^{2} \gamma"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos\theta = \frac{a}{a_r}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"F = \frac{1}{2\pi}\sqrt{\frac{-a}{\gamma}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"T = 2\pi\sqrt{\frac{\gamma}{-a}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\omega = 2\pi F"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\theta = \omega t"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetMovimientoArmonicoSimple),
            const DescargarPDF(url: kWidgetMovimientoArmonicoSimple),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
