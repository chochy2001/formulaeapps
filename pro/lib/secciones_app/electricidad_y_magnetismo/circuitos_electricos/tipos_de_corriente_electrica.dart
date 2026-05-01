import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TiposDeCorrienteElectrica extends StatefulWidget {
  const TiposDeCorrienteElectrica({Key? key}) : super(key: key);

  @override
  State<TiposDeCorrienteElectrica> createState() =>
      _TiposDeCorrienteElectricaState();
}

class _TiposDeCorrienteElectricaState extends State<TiposDeCorrienteElectrica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.tiposCorrienteElectrica,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.tiposCorrienteElectrica,
                      widgetName: kWidgetTiposDeCorrienteElectrica),
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
                                  .tiposCorrienteElectrica,
                              widgetName: kWidgetTiposDeCorrienteElectrica),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .tiposCorrienteElectrica,
                              widgetName: kWidgetTiposDeCorrienteElectrica),
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
                  AppLocalizations.of(context)!.corrienteElectricaContinua,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.corrienteElectricaDirecta,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.corrienteElectricaAlterna,
                ),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenTiposDeCorrienteElectrica) ??
                        kUrlImagenTiposDeCorrienteElectrica),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetTiposDeCorrienteElectrica,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetTiposDeCorrienteElectrica,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
