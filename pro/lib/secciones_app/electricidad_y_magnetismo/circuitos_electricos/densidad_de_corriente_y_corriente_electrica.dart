import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class DensidadDeCorrienteYCorrienteElectrica extends StatefulWidget {
  const DensidadDeCorrienteYCorrienteElectrica({Key? key}) : super(key: key);

  @override
  State<DensidadDeCorrienteYCorrienteElectrica> createState() =>
      _DensidadDeCorrienteYCorrienteElectricaState();
}

class _DensidadDeCorrienteYCorrienteElectricaState
    extends State<DensidadDeCorrienteYCorrienteElectrica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!
                    .densidadCorrienteCorrienteElectrica,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .densidadCorrienteCorrienteElectrica,
                      widgetName:
                          kWidgetDensidadDeCorrienteYCorrienteElectrica),
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
                                  .densidadCorrienteCorrienteElectrica,
                              widgetName:
                                  kWidgetDensidadDeCorrienteYCorrienteElectrica),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .densidadCorrienteCorrienteElectrica,
                              widgetName:
                                  kWidgetDensidadDeCorrienteYCorrienteElectrica),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.densidadDeCorrienteDetalle,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\Phi_j = \iint \vec{J} \cdot d\vec{A}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cargaInstantanea,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\Phi_j = \frac{dq}{dt}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"i= \frac{dq}{dt}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"[i]_u = \left[\frac{C}{s}\right] = [A]"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.corrienteElectrica,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetDensidadDeCorrienteYCorrienteElectrica,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetDensidadDeCorrienteYCorrienteElectrica,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
