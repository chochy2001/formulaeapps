import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesTrigonometricasExtras extends StatefulWidget {
  const IdentidadesTrigonometricasExtras({Key? key}) : super(key: key);

  @override
  IdentidadesTrigonometricasExtrasState createState() =>
      IdentidadesTrigonometricasExtrasState();
}

class IdentidadesTrigonometricasExtrasState
    extends State<IdentidadesTrigonometricasExtras> {
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
                      AppLocalizations.of(context)!
                          .identidadesTrigonometricasExtras,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .identidadesTrigonometricasExtras,
                            widgetName:
                                kWidgetIdentidadesTrigonometricasExtras),
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
                                        .identidadesTrigonometricasExtras,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasExtras),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .identidadesTrigonometricasExtras,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasExtras),
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
                          AppLocalizations.of(context)!
                              .identidadesTrigonometricasParImpar,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\sin(-\theta) = -\sin\theta"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\cos(-\theta) = \cos\theta"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .identidadesTrigonometricasSuplementoComplemento,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\sin(\pi\pm\theta) = \mp \sin\theta"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\cos(\pi\pm\theta) = -\cos\theta"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\sin(\pi/2-\theta) = \cos\theta"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\cos(\pi/2-\theta) = \sin\theta"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(
                        url: kWidgetIdentidadesTrigonometricasExtras,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url: kWidgetIdentidadesTrigonometricasExtras,
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
