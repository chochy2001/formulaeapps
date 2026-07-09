import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class FuncionesTrigonometricasDeAngulosNotables extends StatefulWidget {
  const FuncionesTrigonometricasDeAngulosNotables({super.key});

  @override
  FuncionesTrigonometricasDeAngulosNotablesState createState() =>
      FuncionesTrigonometricasDeAngulosNotablesState();
}

class FuncionesTrigonometricasDeAngulosNotablesState
    extends State<FuncionesTrigonometricasDeAngulosNotables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChatGPTButton(
                    child: TituloPersonalizado(
                      AppLocalizations.of(context)!
                          .funcionesTrigonometricasDeAngulosNotables,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .funcionesTrigonometricasDeAngulosNotables,
                            widgetName:
                                kWidgetFuncionesTrigonometricasDeAngulosNotables),
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
                                        .funcionesTrigonometricasDeAngulosNotables,
                                    widgetName:
                                        kWidgetFuncionesTrigonometricasDeAngulosNotables),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .funcionesTrigonometricasDeAngulosNotables,
                                    widgetName:
                                        kWidgetFuncionesTrigonometricasDeAngulosNotables),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const ZoomImagePersonalizado(
                          urlImagen:
                              kUrlImagenFuncionesTrigonometricasDeAngulosNotables),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  ),

                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(
                        url: kWidgetFuncionesTrigonometricasDeAngulosNotables,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url: kWidgetFuncionesTrigonometricasDeAngulosNotables,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
