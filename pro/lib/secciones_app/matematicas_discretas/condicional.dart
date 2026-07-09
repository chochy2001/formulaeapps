import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class CondicionalMatematicasDiscretas extends StatefulWidget {
  const CondicionalMatematicasDiscretas({super.key});

  @override
  CondicionalMatematicasDiscretasState createState() =>
      CondicionalMatematicasDiscretasState();
}

class CondicionalMatematicasDiscretasState
    extends State<CondicionalMatematicasDiscretas> {
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
                      AppLocalizations.of(context)!.condicional,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.condicional,
                            widgetName: kWidgetCondicional),
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
                                        .condicional,
                                    widgetName: kWidgetCondicional),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .condicional,
                                    widgetName: kWidgetCondicional),
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
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conector,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.implica,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simbolo,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathsf{p \rightarrow q}"),
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
                      urlImagen: getImageUrlById(context, kImagenCondicional) ??
                          kUrlImagenCondicional),
                  const SizedBox(
                    height: 30.0,
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetCondicional,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetCondicional,
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
