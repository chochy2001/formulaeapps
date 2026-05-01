import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TransformadaDeLaplace extends StatefulWidget {
  const TransformadaDeLaplace({Key? key}) : super(key: key);

  @override
  TransformadaDeLaplaceState createState() => TransformadaDeLaplaceState();
}

class TransformadaDeLaplaceState extends State<TransformadaDeLaplace> {
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
                      AppLocalizations.of(context)!.transformadaDeLaplace,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .transformadaDeLaplace,
                            widgetName: kWidgetTransformadasDeLaplace),
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
                                        .transformadaDeLaplace,
                                    widgetName: kWidgetTransformadasDeLaplace),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .transformadaDeLaplace,
                                    widgetName: kWidgetTransformadasDeLaplace),
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
                          AppLocalizations.of(context)!.transformadaDeLaplace,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"\mathcal{L}[f(t)] = F(s) = \int_{0}^{\infty}f(t)e^{-st}dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetTransformadaDeLaplace,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetTransformadaDeLaplace,
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
