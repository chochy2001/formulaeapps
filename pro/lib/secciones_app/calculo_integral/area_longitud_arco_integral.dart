import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AreaLongitudArcoIntegral extends StatefulWidget {
  const AreaLongitudArcoIntegral({super.key});

  @override
  AreaLongitudArcoIntegralState createState() => AreaLongitudArcoIntegralState();
}

class AreaLongitudArcoIntegralState extends State<AreaLongitudArcoIntegral> {
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
                    AppLocalizations.of(context)!.areaLongitudArcoIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.areaLongitudArcoIntegral,
                        widgetName: kWidgetAreaLongitudArcoIntegral,
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
                                title: AppLocalizations.of(context)!.areaLongitudArcoIntegral,
                                widgetName: kWidgetAreaLongitudArcoIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.areaLongitudArcoIntegral,
                                widgetName: kWidgetAreaLongitudArcoIntegral,
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
                  Latex(formulaText: r"A = \int_{a}^{b} \left[\,f(x) - g(x)\,\right] dx"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"L = \int_{a}^{b} \sqrt{\,1 + \left[\,f'(x)\,\right]^{2}\,}\;dx"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAreaLongitudArcoIntegral),
            const DescargarPDF(url: kWidgetAreaLongitudArcoIntegral),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
