import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesTrigonometricasDeSumaYRestaDeAngulos extends StatefulWidget {
  const IdentidadesTrigonometricasDeSumaYRestaDeAngulos({super.key});

  @override
  IdentidadesTrigonometricasDeSumaYRestaDeAngulosState createState() =>
      IdentidadesTrigonometricasDeSumaYRestaDeAngulosState();
}

class IdentidadesTrigonometricasDeSumaYRestaDeAngulosState
    extends State<IdentidadesTrigonometricasDeSumaYRestaDeAngulos> {
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
                      AppLocalizations.of(context)!.deSumaYRestaDeAngulos,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.deSumaYRestaDeAngulos,
                          widgetName:
                              kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
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
                                  )!.deSumaYRestaDeAngulos,
                                  widgetName:
                                      kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.deSumaYRestaDeAngulos,
                                  widgetName:
                                      kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\sin(\alpha+\beta) = \sin\alpha\cos\beta+\cos\alpha\sin\beta",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cos(\alpha+\beta) = \cos\alpha\cos\beta-\sin\alpha\sin\beta",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\sin(\alpha-\beta) = \sin\alpha\cos\beta-\cos\alpha\sin\beta",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cos(\alpha-\beta) = \cos\alpha\cos\beta+\sin\alpha\sin\beta",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\tan(\alpha+\beta) = \frac{\tan\alpha+\tan\beta}{1-\tan\alpha\tan\beta}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\tan(\alpha-\beta) = \frac{\tan\alpha-\tan\beta}{1+\tan\alpha\tan\beta}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(
                        url:
                            kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url:
                            kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
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
