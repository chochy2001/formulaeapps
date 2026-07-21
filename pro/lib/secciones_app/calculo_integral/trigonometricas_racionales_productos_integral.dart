import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class TrigonometricasRacionalesProductosIntegral extends StatefulWidget {
  const TrigonometricasRacionalesProductosIntegral({super.key});

  @override
  TrigonometricasRacionalesProductosIntegralState createState() =>
      TrigonometricasRacionalesProductosIntegralState();
}

class TrigonometricasRacionalesProductosIntegralState
    extends State<TrigonometricasRacionalesProductosIntegral> {
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
                    AppLocalizations.of(
                      context,
                    )!.trigonometricasRacionalesProductosIntegral,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.trigonometricasRacionalesProductosIntegral,
                        widgetName:
                            kWidgetTrigonometricasRacionalesProductosIntegral,
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
                                )!.trigonometricasRacionalesProductosIntegral,
                                widgetName:
                                    kWidgetTrigonometricasRacionalesProductosIntegral,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.trigonometricasRacionalesProductosIntegral,
                                widgetName:
                                    kWidgetTrigonometricasRacionalesProductosIntegral,
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
                        r"\int \frac{dx}{1+\sin x} = \tan\left(\frac{x}{2} - \frac{\pi}{4}\right) + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{1-\sin x} = -\cot\left(\frac{x}{2} - \frac{\pi}{4}\right) + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{1+\cos x} = \tan\frac{x}{2} + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \frac{dx}{1-\cos x} = -\cot\frac{x}{2} + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \sin ax\,\sin bx\, dx = -\frac{\sin(ax+bx)}{2(a+b)} + \frac{\sin(ax-bx)}{2(a-b)} + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \sin ax\,\cos bx\, dx = -\frac{\cos(ax+bx)}{2(a+b)} - \frac{\cos(ax-bx)}{2(a-b)} + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\int \cos ax\,\cos bx\, dx = \frac{\sin(ax+bx)}{2(a+b)} + \frac{\sin(ax-bx)}{2(a-b)} + C",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(
              url: kWidgetTrigonometricasRacionalesProductosIntegral,
            ),
            const DescargarPDF(
              url: kWidgetTrigonometricasRacionalesProductosIntegral,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
