import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ResistorSimbologiaBasica extends StatefulWidget {
  const ResistorSimbologiaBasica({Key? key}) : super(key: key);

  @override
  State<ResistorSimbologiaBasica> createState() =>
      _ResistorSimbologiaBasicaState();
}

class _ResistorSimbologiaBasicaState extends State<ResistorSimbologiaBasica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.resistorSimbologiaBasica,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .resistorSimbologiaBasica,
                      widgetName: kWidgetResistorSimbologiaBasica),
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
                                  .resistorSimbologiaBasica,
                              widgetName: kWidgetResistorSimbologiaBasica),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .resistorSimbologiaBasica,
                              widgetName: kWidgetResistorSimbologiaBasica),
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
                    getImageUrlById(context, kImagenResistorSimbologiaBasica) ??
                        kUrlImagenResistorSimbologiaBasica),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetResistorSimbologiaBasica,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetResistorSimbologiaBasica,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
