import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class GraficaDeCapacitancia extends StatefulWidget {
  const GraficaDeCapacitancia({Key? key}) : super(key: key);

  @override
  State<GraficaDeCapacitancia> createState() => _GraficaDeCapacitanciaState();
}

class _GraficaDeCapacitanciaState extends State<GraficaDeCapacitancia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.graficaCapacitancia,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.graficaCapacitancia,
                      widgetName: kWidgetGraficaDeCapacitancia),
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
                                  .graficaCapacitancia,
                              widgetName: kWidgetGraficaDeCapacitancia),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .graficaCapacitancia,
                              widgetName: kWidgetGraficaDeCapacitancia),
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
                    getImageUrlById(context, kImagenGraficaCapacitancia) ??
                        kUrlImagenGraficaCapacitancia),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(
                  url: kWidgetGraficaDeCapacitancia,
                ),
                //Descargar PDF
                DescargarPDF(
                  url: kWidgetGraficaDeCapacitancia,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
