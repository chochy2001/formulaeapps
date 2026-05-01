import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class Convolucion extends StatefulWidget {
  const Convolucion({Key? key}) : super(key: key);

  @override
  ConvolucionState createState() => ConvolucionState();
}

class ConvolucionState extends State<Convolucion> {
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
                      AppLocalizations.of(context)!.convolucion,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.convolucion,
                            widgetName: kWidgetConvolucion),
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
                                        .convolucion,
                                    widgetName: kWidgetConvolucion),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .convolucion,
                                    widgetName: kWidgetConvolucion),
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
                          AppLocalizations.of(context)!.sean,
                        ),
                        const Latex(
                            formulaText:
                                r"f_1(t)\space\mathsf{y\space}f_2(t)\space"),
                        const SizedBox(height: 10),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.dosFuncionesDadas,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.convolucionDe,
                        ),
                        const Latex(
                            formulaText:
                                r"f_1(t)\space\mathsf{y\space}f_2(t)\space"),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"f(t) = \int_{-\infty}^{\infty}f_1(x)f_2(t-x)dx"),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"f(t) = f_1(t)*f_2(t)"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetConvolucion,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetConvolucion,
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
