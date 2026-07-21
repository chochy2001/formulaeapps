import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CirculacionDeUnCampoVectorial extends StatefulWidget {
  const CirculacionDeUnCampoVectorial({super.key});

  @override
  State<CirculacionDeUnCampoVectorial> createState() =>
      _CirculacionDeUnCampoVectorialState();
}

class _CirculacionDeUnCampoVectorialState
    extends State<CirculacionDeUnCampoVectorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.circulacionDeUnCampoVectorial,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.circulacionDeUnCampoVectorial,
                    widgetName: kWidgetCirculacionDeUnCampoVectorial,
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
                            )!.circulacionDeUnCampoVectorial,
                            widgetName: kWidgetCirculacionDeUnCampoVectorial,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.circulacionDeUnCampoVectorial,
                            widgetName: kWidgetCirculacionDeUnCampoVectorial,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.circulacionDelCampoElectrico,
                ),
                const Latex(
                  formulaText: r"C_e = \oint \vec{E} \cdot d \vec{l} = 0",
                ),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.circulacionDelCampoMagnetico,
                ),
                const Latex(
                  formulaText: r"C_b = \oint \vec{B} \cdot d \vec{l} \neq 0",
                ),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enElCasoDeUnConductorRecto,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"C_b = \oint \vec{B} \cdot d \vec{l} = B2\pi r",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"\oint \vec{B} \cdot d \vec{l} = \frac{\mu _0 i}{2\pi r}2\pi r",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\oint \vec{B} \cdot d \vec{l} = \mu _0 i",
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenCirculacionDeUnCampoVectorial,
                ),
                const SizedBox(height: 30.0),
                TextoEcuaciones(AppLocalizations.of(context)!.leyDeAmpere),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetCirculacionDeUnCampoVectorial),
                //Descargar PDF
                DescargarPDF(url: kWidgetCirculacionDeUnCampoVectorial),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
