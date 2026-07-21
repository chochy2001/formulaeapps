import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DerivadasAlgebraicasRadicales extends StatefulWidget {
  const DerivadasAlgebraicasRadicales({super.key});

  @override
  DerivadasAlgebraicasRadicalesState createState() =>
      DerivadasAlgebraicasRadicalesState();
}

class DerivadasAlgebraicasRadicalesState
    extends State<DerivadasAlgebraicasRadicales> {
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
                    AppLocalizations.of(context)!.derivadasAlgebraicasRadicales,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.derivadasAlgebraicasRadicales,
                        widgetName: kWidgetDerivadasAlgebraicasRadicales,
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
                                )!.derivadasAlgebraicasRadicales,
                                widgetName:
                                    kWidgetDerivadasAlgebraicasRadicales,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.derivadasAlgebraicasRadicales,
                                widgetName:
                                    kWidgetDerivadasAlgebraicasRadicales,
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
                        r"\frac{d}{dx}\!\left(\frac{u}{c}\right) = \frac{1}{c}\cdot\frac{du}{dx}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\!\left(\frac{c}{u}\right) = -\frac{c}{u^{2}}\cdot\frac{du}{dx}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}(u)^{-n} = -n\,u^{\,-n-1}\,\frac{du}{dx}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\,c\,u^{n} = c\cdot n\cdot u^{\,n-1}\,\frac{du}{dx}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\sqrt{u}=\frac{\dfrac{du}{dx}}{2\sqrt{u}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\frac{d}{dx}\sqrt{x}=\frac{1}{2\sqrt{x}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\sqrt[n]{x}=\frac{1}{n\sqrt[n]{x^{\,n-1}}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{\text{exp.}}{\text{ind.}\;\sqrt[\text{ind.}]{\text{fun.}^{\,\text{exp.}-1}}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDerivadasAlgebraicasRadicales),
            const DescargarPDF(url: kWidgetDerivadasAlgebraicasRadicales),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
