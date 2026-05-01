import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class SimbologiaCapacitores extends StatefulWidget {
  const SimbologiaCapacitores({Key? key}) : super(key: key);

  @override
  State<SimbologiaCapacitores> createState() => _SimbologiaCapacitoresState();
}

class _SimbologiaCapacitoresState extends State<SimbologiaCapacitores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.simbologiaCapacitores,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.simbologiaCapacitores,
                      widgetName: kWidgetSimbologiaCapacitores),
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
                                  .simbologiaCapacitores,
                              widgetName: kWidgetSimbologiaCapacitores),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .simbologiaCapacitores,
                              widgetName: kWidgetSimbologiaCapacitores),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            ZoomImagePersonalizado(
                urlImagen:
                    getImageUrlById(context, kImagenSimbologiaCapacitores) ??
                        kUrlImagenSimbologiaCapacitores),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetSimbologiaCapacitores,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetSimbologiaCapacitores,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
