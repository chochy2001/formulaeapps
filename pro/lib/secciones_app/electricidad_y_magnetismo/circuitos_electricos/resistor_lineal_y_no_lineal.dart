import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ResistorLinealYNoLineal extends StatefulWidget {
  const ResistorLinealYNoLineal({super.key});

  @override
  State<ResistorLinealYNoLineal> createState() =>
      _ResistorLinealYNoLinealState();
}

class _ResistorLinealYNoLinealState extends State<ResistorLinealYNoLineal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.resistorLinealNoLineal,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.resistorLinealNoLineal,
                    widgetName: kWidgetResistorLinealYNoLineal,
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
                            )!.resistorLinealNoLineal,
                            widgetName: kWidgetResistorLinealYNoLineal,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.resistorLinealNoLineal,
                            widgetName: kWidgetResistorLinealYNoLineal,
                          ),
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
                  getImageUrlById(context, kImagenResistorLinealYNoLineal) ??
                  kUrlImagenResistorLinealYNoLineal,
            ),
            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetResistorLinealYNoLineal),
                //Descargar PDF
                DescargarPDF(url: kWidgetResistorLinealYNoLineal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
