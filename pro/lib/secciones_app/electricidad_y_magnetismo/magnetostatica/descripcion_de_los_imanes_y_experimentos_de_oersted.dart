import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class OrigenDeCampoMagnetico extends StatefulWidget {
  const OrigenDeCampoMagnetico({super.key});

  @override
  State<OrigenDeCampoMagnetico> createState() => _OrigenDeCampoMagneticoState();
}

class _OrigenDeCampoMagneticoState extends State<OrigenDeCampoMagnetico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(
                  context,
                )!.descripcionDeLosImanesYExperimentosDeOersted,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.descripcionDeLosImanesYExperimentosDeOersted,
                    widgetName: kWidgetOrigenDeCampoMagnetico,
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
                            )!.descripcionDeLosImanesYExperimentosDeOersted,
                            widgetName: kWidgetOrigenDeCampoMagnetico,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.descripcionDeLosImanesYExperimentosDeOersted,
                            widgetName: kWidgetOrigenDeCampoMagnetico,
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
                  AppLocalizations.of(context)!.descripcionDeUnIman,
                ),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenImanRojo),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.unImanEsUnObjeto),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enLaNaturalezaElMineral,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.deFormaSinteticaLosImanes,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.caracteristicasDeUnIman,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.polosIgualesSeRepelen,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenTierraComoIman,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.laTierraSeComportaComo,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.experimentoDeOersted,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenExperimentoOersted,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.hansChristianOersted,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetOrigenDeCampoMagnetico),
                //Descargar PDF
                DescargarPDF(url: kWidgetOrigenDeCampoMagnetico),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
