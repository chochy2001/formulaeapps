import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeGauss extends StatefulWidget {
  const LeyDeGauss({super.key});

  @override
  State<LeyDeGauss> createState() => _LeyDeGaussState();
}

class _LeyDeGaussState extends State<LeyDeGauss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.leyGauss,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.leyGauss,
                    widgetName: kWidgetLeyDeGauss,
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
                            title: AppLocalizations.of(context)!.leyGauss,
                            widgetName: kWidgetLeyDeGauss,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.leyGauss,
                            widgetName: kWidgetLeyDeGauss,
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
                  AppLocalizations.of(
                    context,
                  )!.flujoCampoElectricoSuperficieGaussiana,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\phi _E = \oiint \vec{E} \cdot d\vec{A}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.superficieGaussiana,
                ),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenSuperficieGaussiana,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.leyGauss),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\epsilon _0 \phi _E = q_{enc}"),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\oiint \vec{E} \cdot d\vec{A} = \frac{q_{enc}}{\epsilon _0}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeGaussProporcional,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.notasImportantes),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.flujoCampoElectricoCero,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.flujoCampoElectricoPositivoNegativo,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.distribucionCargasSuperficieGaussiana,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unidadMedidaFlujoElectricoSI,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"[\phi_E]_u = \left[ \frac{N\cdot m^2}{C}\right]",
                ),
                const SizedBox(height: 50.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.aplicacionesLeyGauss,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.campoElectricoCargaPuntual,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"E = \frac{q}{4 \pi \varepsilon _0 r^2} = k \frac{q}{r^2}",
                ),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenCampoElectricoDeUnaCargaPuntual,
                ),
                const SizedBox(height: 50.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.campoElectricoLineaInfinitaCarga,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"E = \frac{q}{2 \pi \varepsilon _0 h r} = \frac{\lambda}{2 \pi \varepsilon _0 r} = \frac{2k\lambda}{r}",
                ),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenCampoElectricoDeUnaLineaInfinita,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetLeyDeGauss),
                //Descargar PDF
                DescargarPDF(url: kWidgetLeyDeGauss),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
