import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class PortadoresDeCargaLibre extends StatefulWidget {
  const PortadoresDeCargaLibre({Key? key}) : super(key: key);

  @override
  State<PortadoresDeCargaLibre> createState() => _PortadoresDeCargaLibreState();
}

class _PortadoresDeCargaLibreState extends State<PortadoresDeCargaLibre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.portadoresCargaLibre,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.portadoresCargaLibre,
                      widgetName: kWidgetPortadoresDeCargaLibre),
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
                                  .portadoresCargaLibre,
                              widgetName: kWidgetPortadoresDeCargaLibre),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .portadoresCargaLibre,
                              widgetName: kWidgetPortadoresDeCargaLibre),
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
                  AppLocalizations.of(context)!.portadorDeCargaLibre,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenPortadoresDeCargaLibre) ??
                        kUrlImagenPortadoresDeCargaLibre),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .laPresenciaDeLaDiferenciaDePotencial,
                ),
                const SizedBox(height: 40.0),
                const VerPDF(
                  url: kWidgetPortadoresDeCargaLibre,
                ),
                //Descargar PDF
                const DescargarPDF(
                  url: kWidgetPortadoresDeCargaLibre,
                ),
              ],
            ),

            //Boton para acceder al formulario en PDF
          ],
        ),
      ),
    );
  }
}
