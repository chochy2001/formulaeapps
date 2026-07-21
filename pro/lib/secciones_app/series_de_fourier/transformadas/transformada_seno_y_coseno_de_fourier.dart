import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class TransformadaSenoYCosenoDeFourier extends StatefulWidget {
  const TransformadaSenoYCosenoDeFourier({super.key});

  @override
  TransformadaSenoYCosenoDeFourierState createState() =>
      TransformadaSenoYCosenoDeFourierState();
}

class TransformadaSenoYCosenoDeFourierState
    extends State<TransformadaSenoYCosenoDeFourier> {
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
                      AppLocalizations.of(
                        context,
                      )!.transformadaSenoYCosenoDeFourier,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.transformadaSenoYCosenoDeFourier,
                          widgetName: kWidgetTransformadaSenoYCosenoDeFourier,
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
                                  )!.transformadaSenoYCosenoDeFourier,
                                  widgetName:
                                      kWidgetTransformadaSenoYCosenoDeFourier,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.transformadaSenoYCosenoDeFourier,
                                  widgetName:
                                      kWidgetTransformadaSenoYCosenoDeFourier,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.transformadaSenoFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                          formulaText:
                              r"Fs(\omega) = \int_{0}^{\infty}f(t)\sin(\omega t)dt",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"f(t) = \frac{2}{\pi}\int_{0}^{\infty}Fs(\omega)\sin(\omega t)d\omega",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.transformadaCosenoFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                          formulaText:
                              r"F_C(\omega) = \int_{0}^{\infty}f(t)\cos(\omega t)dt",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"f(t) = \frac{2}{\pi}\int_{0}^{\infty}F_C(\omega)\cos(\omega t)d\omega",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetTransformadaSenoYCosenoDeFourier),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetTransformadaSenoYCosenoDeFourier,
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
