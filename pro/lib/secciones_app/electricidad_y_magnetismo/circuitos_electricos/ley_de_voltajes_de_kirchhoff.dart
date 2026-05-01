import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeVoltajesDeKirchhoff extends StatefulWidget {
  const LeyDeVoltajesDeKirchhoff({Key? key}) : super(key: key);

  @override
  State<LeyDeVoltajesDeKirchhoff> createState() =>
      _LeyDeVoltajesDeKirchhoffState();
}

class _LeyDeVoltajesDeKirchhoffState extends State<LeyDeVoltajesDeKirchhoff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.leyVoltajesKirchhoff,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.leyVoltajesKirchhoff,
                      widgetName: kWidgetLeyDeVoltajesDeKirchhoff),
                );
                return IconButton(
                  icon: isFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  color: isFavorite ? Colors.white : Colors.white,
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        favoritesNotifier.removeFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyVoltajesKirchhoff,
                              widgetName: kWidgetLeyDeVoltajesDeKirchhoff),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyVoltajesKirchhoff,
                              widgetName: kWidgetLeyDeVoltajesDeKirchhoff),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.sumaAlgebraicaPotencial,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenLeyDeVoltajesDeKirchhoff),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\sum_{k=1}^n V_k = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\epsilon = \sum_{i=1}^n V_i"),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conservacionDeEnergia,
                ),
                const Latex(formulaText: r"V_{AB} = \frac{U_A- U_B}{q}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.energiaTotalCircuito,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\Delta U = 0"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\Delta U_T = \Delta U_1 + \Delta U_2 + \cdots"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetLeyDeVoltajesDeKirchhoff,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetLeyDeVoltajesDeKirchhoff,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
