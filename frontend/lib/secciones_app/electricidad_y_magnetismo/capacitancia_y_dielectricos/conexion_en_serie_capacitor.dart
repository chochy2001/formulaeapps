import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ConexionEnSerieCapacitor extends StatefulWidget {
  const ConexionEnSerieCapacitor({Key? key}) : super(key: key);

  @override
  State<ConexionEnSerieCapacitor> createState() =>
      _ConexionEnSerieCapacitorState();
}

class _ConexionEnSerieCapacitorState extends State<ConexionEnSerieCapacitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.conexionSerieCapacitor,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.conexionSerieCapacitor,
                      widgetName: kWidgetConexionEnSerieCapacitor),
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
                                  .conexionSerieCapacitor,
                              widgetName: kWidgetConexionEnSerieCapacitor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .conexionSerieCapacitor,
                              widgetName: kWidgetConexionEnSerieCapacitor),
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
                  AppLocalizations.of(context)!.sentidoFisico,
                ),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCapacitorConexionEnSerieFisico),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.simbologia,
                ),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCapacitorConexionEnSerieSimbologia),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conexionEnSerie,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen:
                        kUrlImagenConexionEnSerieCargaDiferenciaDePotencialCapacitanciaEquivalente),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"Q_T = Q_1 = Q_2 = Q_3 = ... = Q_n"),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"V_T = V_1 + V_2 + V_3 + ... + V_n"),
                const SizedBox(height: 30.0),
                const Latex(
                    formulaText:
                        r"\frac{1}{C_T} = \frac{1}{C_1} + \frac{1}{C_2} + \frac{1}{C_3} + ... + \frac{1}{C_n}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetConexionEnSerieCapacitor,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetConexionEnSerieCapacitor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
