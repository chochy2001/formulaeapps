import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ProductoDeCosenoPorSeno extends StatefulWidget {
  const ProductoDeCosenoPorSeno({super.key});

  @override
  ProductoDeCosenoPorSenoState createState() => ProductoDeCosenoPorSenoState();
}

class ProductoDeCosenoPorSenoState extends State<ProductoDeCosenoPorSeno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChatGPTButton(
                  child: TituloPersonalizado(
                    AppLocalizations.of(context)!.productoDeCosenoPorSeno,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.productoDeCosenoPorSeno,
                        widgetName: kWidgetProductoDeCosenoPorSeno,
                      ),
                    );
                    return IconButton(
                      icon: isFavorite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoritesNotifier.removeFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.productoDeCosenoPorSeno,
                                widgetName: kWidgetProductoDeCosenoPorSeno,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.productoDeCosenoPorSeno,
                                widgetName: kWidgetProductoDeCosenoPorSeno,
                              ),
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  Latex(
                    formulaText:
                        r"\cos a\,\operatorname{sen} b = \dfrac{1}{2}\left[\operatorname{sen}(a+b) - \operatorname{sen}(a-b)\right]",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetProductoDeCosenoPorSeno),
            const DescargarPDF(url: kWidgetProductoDeCosenoPorSeno),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
