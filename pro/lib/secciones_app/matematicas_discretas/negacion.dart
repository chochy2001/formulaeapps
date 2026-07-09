import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class Negacion extends StatefulWidget {
  const Negacion({super.key});

  @override
  NegacionState createState() => NegacionState();
}

class NegacionState extends State<Negacion> {
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
                      AppLocalizations.of(context)!.negacion,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.negacion,
                            widgetName: kWidgetNegacion),
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
                                        AppLocalizations.of(context)!.negacion,
                                    widgetName: kWidgetNegacion),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title:
                                        AppLocalizations.of(context)!.negacion,
                                    widgetName: kWidgetNegacion),
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
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conector,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.no,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simbolos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathsf{\neg p}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathsf{!p}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.tablaVerdad,
                  ),

                  ZoomImagePersonalizado(
                      urlImagen: getImageUrlById(context, kImagenNegacion) ??
                          kUrlImagenNegacion),
                  const SizedBox(
                    height: 30.0,
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetNegacion,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetNegacion,
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
