import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class Polarizacion extends StatefulWidget {
  const Polarizacion({super.key});

  @override
  State<Polarizacion> createState() => _PolarizacionState();
}

class _PolarizacionState extends State<Polarizacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.polarizacion,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.polarizacion,
                      widgetName: kWidgetPolarizacion),
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
                              title: AppLocalizations.of(context)!.polarizacion,
                              widgetName: kWidgetPolarizacion),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.polarizacion,
                              widgetName: kWidgetPolarizacion),
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
                  AppLocalizations.of(context)!.alAplicarUnCampoElectrico,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enUnDielectrico,
                ),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context, kImagenPolarizacion) ??
                        kUrlImagenPolarizacion),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unDipoloElectrico,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenPolarizacionCargas),
                const Latex(formulaText: r"\vec{p} = q\vec{d}"),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context, kImagenNoPolarizado) ??
                        kUrlImagenNoPolarizado),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context, kImagenPolarizado) ??
                        kUrlImagenPolarizado),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.laPolarizacion,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{P} = \frac{\sum_{i = 1}^n\vec{p}i}{V'}"),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetPolarizacion,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetPolarizacion,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
