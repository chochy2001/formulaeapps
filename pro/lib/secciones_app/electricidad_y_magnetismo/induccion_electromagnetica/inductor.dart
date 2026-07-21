import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class Inductor extends StatefulWidget {
  const Inductor({super.key});

  @override
  State<Inductor> createState() => _InductorState();
}

class _InductorState extends State<Inductor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.inductor,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.inductor,
                    widgetName: kWidgetInductor,
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
                            title: AppLocalizations.of(context)!.inductor,
                            widgetName: kWidgetInductor,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.inductor,
                            widgetName: kWidgetInductor,
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
                TextoEcuaciones(AppLocalizations.of(context)!.sentidoFisico),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenInductanciaPropiaDeUnSolenoide,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.simbologia),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenInductorSimbologiaBasica,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetInductor),
                //Descargar PDF
                DescargarPDF(url: kWidgetInductor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
