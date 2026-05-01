import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class DistribucionesDeCargaElectrica extends StatefulWidget {
  const DistribucionesDeCargaElectrica({Key? key}) : super(key: key);

  @override
  State<DistribucionesDeCargaElectrica> createState() =>
      _DistribucionesDeCargaElectricaState();
}

class _DistribucionesDeCargaElectricaState
    extends State<DistribucionesDeCargaElectrica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.distribucionesCargaElectrica,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .distribucionesCargaElectrica,
                      widgetName: kWidgetDistribucionesDeCargaElectrica),
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
                                  .distribucionesCargaElectrica,
                              widgetName:
                                  kWidgetDistribucionesDeCargaElectrica),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .distribucionesCargaElectrica,
                              widgetName:
                                  kWidgetDistribucionesDeCargaElectrica),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            TextoEcuaciones(
              AppLocalizations.of(context)!.naturalezaCarga,
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.distribucionCarga,
            ),

            const SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.densidadLineal,
                ),
                const Latex(formulaText: r"\lambda = \frac{dq}{dl}"),
                const Latex(formulaText: r"[\lambda]_u  = \space \frac{C}{m}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.densidadSuperficial,
                ),
                const Latex(formulaText: r"\sigma= \frac{dq}{dA}"),
                const Latex(formulaText: r"[\sigma]_u  = \space \frac{C}{m^2}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.densidadVolumetrica,
                ),
                const Latex(formulaText: r"\varrho= \frac{dq}{dV}"),
                const Latex(
                    formulaText: r"[\varrho]_u  = \space \frac{C}{m^3}"),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetDistribucionesDeCargaElectrica,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetDistribucionesDeCargaElectrica,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
