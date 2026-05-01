import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesTrigonometricasDeSumaAProductoYViceversa
    extends StatefulWidget {
  const IdentidadesTrigonometricasDeSumaAProductoYViceversa({Key? key})
      : super(key: key);

  @override
  IdentidadesTrigonometricasDeSumaAProductoYViceversaState createState() =>
      IdentidadesTrigonometricasDeSumaAProductoYViceversaState();
}

class IdentidadesTrigonometricasDeSumaAProductoYViceversaState
    extends State<IdentidadesTrigonometricasDeSumaAProductoYViceversa> {
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
                      AppLocalizations.of(context)!.deSumaAProductoYViceversa,
                    ),
                  ),
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .deSumaAProductoYViceversa,
                            widgetName:
                                kWidgetIdentidadesTrigonometricasDeSumaAProductoYViceversa),
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
                                        .deSumaAProductoYViceversa,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasDeSumaAProductoYViceversa),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .deSumaAProductoYViceversa,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasDeSumaAProductoYViceversa),
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
                          AppLocalizations.of(context)!
                              .identidadesTrigonometricasSumaProducto,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\sin\alpha+\sin\beta = 2\sin\left(\frac{\alpha + \beta}{2}\right)\cos\left(\frac{\alpha - \beta}{2}\right)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\sin\alpha-\sin\beta = 2\sin\left(\frac{\alpha - \beta}{2}\right)\cos\left(\frac{\alpha + \beta}{2}\right)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\cos\alpha+\sin\beta = 2\cos\left(\frac{\alpha + \beta}{2}\right)\cos\left(\frac{\alpha - \beta}{2}\right)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\cos\alpha-\sin\beta = -2\sin\left(\frac{\alpha + \beta}{2}\right)\sin\left(\frac{\alpha - \beta}{2}\right)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .identidadesTrigonometricasProductoSuma,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\sin\alpha\sin\beta = \frac{1}{2}[\cos(\alpha-\beta)-\cos(\alpha+\beta)]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\cos\alpha\cos\beta = \frac{1}{2}[\cos(\alpha-\beta)+\cos(\alpha+\beta)]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\sin\alpha\cos\beta = \frac{1}{2}[\sin(\alpha+\beta)+\sin(\alpha-\beta)]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const Column(
                    children: [
                      VerPDF(
                        url:
                            kWidgetIdentidadesTrigonometricasDeSumaAProductoYViceversa,
                      ),
                      //Descargar PDF
                      DescargarPDF(
                        url:
                            kWidgetIdentidadesTrigonometricasDeSumaAProductoYViceversa,
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
