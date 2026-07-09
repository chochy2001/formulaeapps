import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesTrigonometricasDeAnguloDobleYMedio extends StatefulWidget {
  const IdentidadesTrigonometricasDeAnguloDobleYMedio({super.key});

  @override
  IdentidadesTrigonometricasDeAnguloDobleYMedioState createState() =>
      IdentidadesTrigonometricasDeAnguloDobleYMedioState();
}

class IdentidadesTrigonometricasDeAnguloDobleYMedioState
    extends State<IdentidadesTrigonometricasDeAnguloDobleYMedio> {
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
                      AppLocalizations.of(context)!.deAnguloDobleYMedio,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .deAnguloDobleYMedio,
                            widgetName:
                                kWidgetIdentidadesTrigonometricasDeAngulosDobleYMedio),
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
                                        .deAnguloDobleYMedio,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasDeAngulosDobleYMedio),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .deAnguloDobleYMedio,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasDeAngulosDobleYMedio),
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
                        Latex(
                            formulaText:
                                r"\sin 2\alpha = 2\sin\alpha\cos\alpha"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\cos 2\alpha = \cos^2\alpha-\sin^2\alpha"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos 2\alpha = 1-2\sin^2\alpha"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos 2\alpha = 2\cos^2\alpha -1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\tan 2\alpha = \frac{2\tan\alpha}{1-\tan^2\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\sin \frac{\alpha}{2} = \pm \sqrt{\frac{1-\cos\alpha}{2}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\cos\frac{\alpha}{2} = \pm \sqrt{\frac{1+\cos\alpha}{2}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\tan\frac{\alpha}{2} = \pm \sqrt{\frac{1-\cos\alpha}{1+\cos\alpha}}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\tan\frac{\alpha}{2} = \frac{1-\cos\alpha}{\sin\alpha} = \frac{\sin\alpha}{1+\cos\alpha}"),
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
                            kWidgetIdentidadesTrigonometricasDeAngulosDobleYMedio,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url:
                            kWidgetIdentidadesTrigonometricasDeAngulosDobleYMedio,
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
