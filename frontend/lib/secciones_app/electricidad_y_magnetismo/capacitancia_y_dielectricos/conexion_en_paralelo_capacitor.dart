import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ConexionEnParaleloCapacitor extends StatefulWidget {
  const ConexionEnParaleloCapacitor({Key? key}) : super(key: key);

  @override
  State<ConexionEnParaleloCapacitor> createState() =>
      _ConexionEnParaleloCapacitorState();
}

class _ConexionEnParaleloCapacitorState
    extends State<ConexionEnParaleloCapacitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.conexionParaleloCapacitor,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .conexionParaleloCapacitor,
                      widgetName: kWidgetConexionEnParaleloCapacitor),
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
                                  .conexionParaleloCapacitor,
                              widgetName: kWidgetConexionEnParaleloCapacitor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .conexionParaleloCapacitor,
                              widgetName: kWidgetConexionEnParaleloCapacitor),
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
                    urlImagen: kUrlImagenConexionEnParaleloFisico),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.simbologia,
                ),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenConexionEnParaleloSimbologia),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conexionEnParalelo,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen:
                        kUrlImagenConexionEnParaleloCargaDiferenciaDePotencialCapacitanciaEquivalente),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"Q_T = Q_1 + Q_2 + Q_3 + ... + Q_n"),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"V_T = V_1 = V_2 = V_3 = ... = V_n"),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"C_T = C_1 + C_2 + C_3 + ... + C_n"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetConexionEnParaleloCapacitor,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetConexionEnParaleloCapacitor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
