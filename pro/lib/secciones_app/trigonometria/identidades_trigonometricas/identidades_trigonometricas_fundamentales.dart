import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesTrigonometricasFundamentales extends StatefulWidget {
  const IdentidadesTrigonometricasFundamentales({super.key});

  @override
  IdentidadesTrigonometricasFundamentalesState createState() =>
      IdentidadesTrigonometricasFundamentalesState();
}

class IdentidadesTrigonometricasFundamentalesState
    extends State<IdentidadesTrigonometricasFundamentales> {
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
                      AppLocalizations.of(context)!.identidadesTrigonometricas,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .identidadesTrigonometricas,
                            widgetName:
                                kWidgetIdentidadesTrigonometricasFundamentales),
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
                                        .identidadesTrigonometricas,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasFundamentales),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .identidadesTrigonometricas,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasFundamentales),
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
                        Latex(
                            formulaText: r"\sin\alpha = \frac{1}{\csc \alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText: r"\csc\alpha = \frac{1}{\sin\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText: r"\cos\alpha = \frac{1}{\sec\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText: r"\sec\alpha = \frac{1}{\cos\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\tan\alpha = \frac{\sin\alpha}{\cos\alpha} = \frac{1}{\cot\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\cot \alpha = \frac{\cos\alpha}{\sin\alpha} = \frac{1}{\tan\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin^2\alpha+\cos^2\alpha = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\tan^2\alpha+1 = \sec^2\alpha"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cot^2\alpha+1 = \csc^2\alpha"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin\alpha\cdot \csc\alpha = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos\alpha\cdot\sec\alpha = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\tan\alpha\cdot\cot\alpha = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(
                        url: kWidgetIdentidadesTrigonometricasFundamentales,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url: kWidgetIdentidadesTrigonometricasFundamentales,
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
