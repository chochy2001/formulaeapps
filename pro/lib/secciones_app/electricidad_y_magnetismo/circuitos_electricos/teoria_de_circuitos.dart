import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TeoriaDeCircuitos extends StatefulWidget {
  const TeoriaDeCircuitos({Key? key}) : super(key: key);

  @override
  State<TeoriaDeCircuitos> createState() => _TeoriaDeCircuitosState();
}

class _TeoriaDeCircuitosState extends State<TeoriaDeCircuitos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.teoriaCircuitos,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.teoriaCircuitos,
                      widgetName: kWidgetTeoriaDeCircuitos),
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
                              title:
                                  AppLocalizations.of(context)!.teoriaCircuitos,
                              widgetName: kWidgetTeoriaDeCircuitos),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.teoriaCircuitos,
                              widgetName: kWidgetTeoriaDeCircuitos),
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
                  AppLocalizations.of(context)!.circuitoElectrico,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.rama,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.nodo,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.malla,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenTeoriaDeCircuitos),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.nodoPrincipal,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ramaPrincipal,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenTerminosAdicionales),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetTeoriaDeCircuitos,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetTeoriaDeCircuitos,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
