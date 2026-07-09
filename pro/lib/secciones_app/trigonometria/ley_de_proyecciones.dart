import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class LeyDeProyecciones extends StatefulWidget {
  const LeyDeProyecciones({super.key});

  @override
  LeyDeProyeccionesState createState() => LeyDeProyeccionesState();
}

class LeyDeProyeccionesState extends State<LeyDeProyecciones> {
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
                      AppLocalizations.of(context)!.leyDeProyecciones,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title:
                                AppLocalizations.of(context)!.leyDeProyecciones,
                            widgetName: kWidgetLeyDeProyecciones),
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
                                        .leyDeProyecciones,
                                    widgetName: kWidgetLeyDeProyecciones),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .leyDeProyecciones,
                                    widgetName: kWidgetLeyDeProyecciones),
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
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a \cos B + b\cos A = c"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a \cos C + c\cos A = b"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"b \cos C + c\cos B = a"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(
                        url: kWidgetLeyDeProyecciones,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url: kWidgetLeyDeProyecciones,
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
