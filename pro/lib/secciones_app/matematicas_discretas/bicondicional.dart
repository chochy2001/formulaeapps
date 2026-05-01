import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class BicondicionalMatematicasDiscretas extends StatefulWidget {
  const BicondicionalMatematicasDiscretas({Key? key}) : super(key: key);

  @override
  BicondicionalMatematicasDiscretasState createState() =>
      BicondicionalMatematicasDiscretasState();
}

class BicondicionalMatematicasDiscretasState
    extends State<BicondicionalMatematicasDiscretas> {
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
                      AppLocalizations.of(context)!.bicondicional,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.bicondicional,
                            widgetName: kWidgetBicondicional),
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
                                        .bicondicional,
                                    widgetName: kWidgetBicondicional),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .bicondicional,
                                    widgetName: kWidgetBicondicional),
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
                          AppLocalizations.of(context)!.siysolosi,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simbolo,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\mathsf{p \leftrightarrow q}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.tablaVerdad,
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomImagePersonalizado(
                      urlImagen:
                          getImageUrlById(context, kImagenBicondicional) ??
                              kUrlImagenBicondicional),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetBicondicional,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetBicondicional,
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
