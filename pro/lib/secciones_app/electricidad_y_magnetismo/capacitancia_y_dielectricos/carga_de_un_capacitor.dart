import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CargaDeUnCapacitor extends StatefulWidget {
  const CargaDeUnCapacitor({super.key});

  @override
  State<CargaDeUnCapacitor> createState() => _CargaDeUnCapacitorState();
}

class _CargaDeUnCapacitorState extends State<CargaDeUnCapacitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.cargaCapacitor,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.cargaCapacitor,
                      widgetName: kWidgetCargaDeUnCapacitor),
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
                                  AppLocalizations.of(context)!.cargaCapacitor,
                              widgetName: kWidgetCargaDeUnCapacitor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.cargaCapacitor,
                              widgetName: kWidgetCargaDeUnCapacitor),
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
                  AppLocalizations.of(context)!.paraCargarUnCapacitor,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCargaDeUnCapacitor),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetCargaDeUnCapacitor,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetCargaDeUnCapacitor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
