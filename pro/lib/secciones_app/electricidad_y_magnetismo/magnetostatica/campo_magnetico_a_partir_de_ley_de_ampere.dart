import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CampoMagneticoAPartirDeLeyDeAmpere extends StatefulWidget {
  const CampoMagneticoAPartirDeLeyDeAmpere({super.key});

  @override
  State<CampoMagneticoAPartirDeLeyDeAmpere> createState() =>
      _CampoMagneticoAPartirDeLeyDeAmpereState();
}

class _CampoMagneticoAPartirDeLeyDeAmpereState
    extends State<CampoMagneticoAPartirDeLeyDeAmpere> {
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
                    .campoMagneticoAPartirDeLeyDeAmpere,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .campoMagneticoAPartirDeLeyDeAmpere,
                      widgetName: kWidgetCampoMagneticoAPartirDeLeyDeAmpere),
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
                                  .campoMagneticoAPartirDeLeyDeAmpere,
                              widgetName:
                                  kWidgetCampoMagneticoAPartirDeLeyDeAmpere),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .campoMagneticoAPartirDeLeyDeAmpere,
                              widgetName:
                                  kWidgetCampoMagneticoAPartirDeLeyDeAmpere),
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
                  AppLocalizations.of(context)!.enElCasoDeUnConductorRectoLargo,
                ),
                const SizedBox(height: 30.0),
                const Latex(
                    formulaText: r"\oint \vec{B} \cdot d \vec{l} = \mu_0 i"),
                const SizedBox(height: 30.0),
                const Latex(
                    formulaText:
                        r"\oint \vec{B} \cdot d \vec{l} = B\oint dl = B2\pi r = \mu _0 i"),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"B= \frac{\mu _0 i}{2\pi r}"),
                const SizedBox(height: 30.0),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .enElCasoDeUnSolenoideLargoInterior,
                ),
                const SizedBox(height: 30.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenSolenoideLargo),
                const SizedBox(height: 30.0),
                const Latex(
                    formulaText: r"\oint \vec{B} \cdot d \vec{l} = \mu _0 i"),
                const SizedBox(height: 30.0),
                const Latex(
                    formulaText:
                        r"\oint \vec{B} \cdot d \vec{l} = \int_1 B dl = BL = \mu _0 i N"),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"B= \frac{\mu _0 i N}{L}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetCampoMagneticoAPartirDeLeyDeAmpere,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetCampoMagneticoAPartirDeLeyDeAmpere,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
