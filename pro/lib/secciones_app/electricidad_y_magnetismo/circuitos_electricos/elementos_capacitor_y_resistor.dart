import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class ElementosCapacitorYResistor extends StatefulWidget {
  const ElementosCapacitorYResistor({super.key});

  @override
  State<ElementosCapacitorYResistor> createState() =>
      _ElementosCapacitorYResistorState();
}

class _ElementosCapacitorYResistorState
    extends State<ElementosCapacitorYResistor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.elementosCapacitorResistor,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.elementosCapacitorResistor,
                    widgetName: kWidgetElementosCapacitorYResistor,
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
                            )!.elementosCapacitorResistor,
                            widgetName: kWidgetElementosCapacitorYResistor,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.elementosCapacitorResistor,
                            widgetName: kWidgetElementosCapacitorYResistor,
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
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(
                        context,
                        kImagenElementosCapacitorYResistor,
                      ) ??
                      kUrlImagenElementosCapacitorYResistor,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetElementosCapacitorYResistor),
                //Descargar PDF
                DescargarPDF(url: kWidgetElementosCapacitorYResistor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
