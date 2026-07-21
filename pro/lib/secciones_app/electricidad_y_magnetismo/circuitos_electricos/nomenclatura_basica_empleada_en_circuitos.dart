import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class NomenclaturaBasicaEmpleadaEnCircuitos extends StatefulWidget {
  const NomenclaturaBasicaEmpleadaEnCircuitos({super.key});

  @override
  State<NomenclaturaBasicaEmpleadaEnCircuitos> createState() =>
      _NomenclaturaBasicaEmpleadaEnCircuitosState();
}

class _NomenclaturaBasicaEmpleadaEnCircuitosState
    extends State<NomenclaturaBasicaEmpleadaEnCircuitos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            ChatGPTButton(
              child: TituloPersonalizado(
                AppLocalizations.of(context)!.nomenclaturaBasicaCircuitos,
              ),
            ),
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.nomenclaturaBasicaCircuitos,
                    widgetName: kWidgetNomenclaturaBasicaEmpleadaEnCircuitos,
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
                            )!.nomenclaturaBasicaCircuitos,
                            widgetName:
                                kWidgetNomenclaturaBasicaEmpleadaEnCircuitos,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.nomenclaturaBasicaCircuitos,
                            widgetName:
                                kWidgetNomenclaturaBasicaEmpleadaEnCircuitos,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(context, kImagenNomenclaturaBasica1) ??
                      kUrlImagenNomenclaturaBasica1,
                ),
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(context, kImagenNomenclaturaBasica2) ??
                      kUrlImagenNomenclaturaBasica2,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const Column(
              children: [
                VerPDF(url: kWidgetNomenclaturaBasicaEmpleadaEnCircuitos),
                //Descargar PDF
                DescargarPDF(url: kWidgetNomenclaturaBasicaEmpleadaEnCircuitos),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
