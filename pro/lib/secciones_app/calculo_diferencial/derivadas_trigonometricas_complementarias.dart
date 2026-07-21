import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DerivadasTrigonometricasComplementarias extends StatefulWidget {
  const DerivadasTrigonometricasComplementarias({super.key});

  @override
  DerivadasTrigonometricasComplementariasState createState() =>
      DerivadasTrigonometricasComplementariasState();
}

class DerivadasTrigonometricasComplementariasState
    extends State<DerivadasTrigonometricasComplementarias> {
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
                    )!.derivadasTrigonometricasComplementarias,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.derivadasTrigonometricasComplementarias,
                        widgetName:
                            kWidgetDerivadasTrigonometricasComplementarias,
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
                                )!.derivadasTrigonometricasComplementarias,
                                widgetName:
                                    kWidgetDerivadasTrigonometricasComplementarias,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.derivadasTrigonometricasComplementarias,
                                widgetName:
                                    kWidgetDerivadasTrigonometricasComplementarias,
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
                        r"\frac{d}{dx}\operatorname{vers} u=\operatorname{sen} u\,\frac{du}{dx}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\,\operatorname{arc\,vers} u = \frac{1}{\sqrt{2u-u^{2}}}\cdot\frac{du}{dx}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\,\operatorname{arc\,sen} x = \frac{1}{\sqrt{1-x^{2}}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\,\operatorname{arc\,cos} x = -\frac{1}{\sqrt{1-x^{2}}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\,\operatorname{arc\,tan} x = \frac{1}{1+x^{2}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDerivadasTrigonometricasComplementarias),
            const DescargarPDF(
              url: kWidgetDerivadasTrigonometricasComplementarias,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
