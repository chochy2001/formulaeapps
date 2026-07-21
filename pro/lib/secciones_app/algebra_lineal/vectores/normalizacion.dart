import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class Normalizacion extends StatefulWidget {
  const Normalizacion({super.key});

  @override
  NormalizacionState createState() => NormalizacionState();
}

class NormalizacionState extends State<Normalizacion> {
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
                      AppLocalizations.of(context)!.normalizacion,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.normalizacion,
                          widgetName: kWidgetNormalizacion,
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
                                  )!.normalizacion,
                                  widgetName: kWidgetNormalizacion,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.normalizacion,
                                  widgetName: kWidgetNormalizacion,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextoEcuaciones(AppLocalizations.of(context)!.norma),
                        const Latex(formulaText: r"p"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText:
                              r"||\mathrm{v}||_p = (|v_1|^p+|v_2|^p+\cdots + |v_n|^p)^{\frac{1}{p}}",
                        ),
                        const SizedBox(height: 80),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.vectorNormalizado,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"\frac{\mathrm{v}}{||\mathrm{v}||_p}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetNormalizacion),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetNormalizacion),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
