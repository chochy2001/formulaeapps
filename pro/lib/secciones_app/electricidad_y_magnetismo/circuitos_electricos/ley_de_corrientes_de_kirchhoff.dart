import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeCorrientesDeKirchhoff extends StatefulWidget {
  const LeyDeCorrientesDeKirchhoff({super.key});

  @override
  State<LeyDeCorrientesDeKirchhoff> createState() =>
      _LeyDeCorrientesDeKirchhoffState();
}

class _LeyDeCorrientesDeKirchhoffState
    extends State<LeyDeCorrientesDeKirchhoff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.leyCorrientesKirchhoff,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.leyCorrientesKirchhoff,
                    widgetName: kWidgetLeyDeCorrienteDeKirchhoff,
                  ),
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
                            title: AppLocalizations.of(
                              context,
                            )!.leyCorrientesKirchhoff,
                            widgetName: kWidgetLeyDeCorrienteDeKirchhoff,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.leyCorrientesKirchhoff,
                            widgetName: kWidgetLeyDeCorrienteDeKirchhoff,
                          ),
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
                  AppLocalizations.of(context)!.sumaAlgebraicaCorrientes,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenLeyDeCorrienteDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\sum_{k=1}^n i_k = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_e = \sum_{j=1}^n i_{sj}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conservacionDeCarga,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\Delta q = 0"),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\Delta q_t = \Delta q_1 + \Delta q_2 + \cdots",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.energiaTotalConservada,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i = \frac{dq}{dt}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetLeyDeCorrienteDeKirchhoff),
                //Descargar PDF
                DescargarPDF(url: kWidgetLeyDeCorrienteDeKirchhoff),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
