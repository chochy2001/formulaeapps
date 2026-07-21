import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DerivacionLogaritmica extends StatefulWidget {
  const DerivacionLogaritmica({super.key});

  @override
  DerivacionLogaritmicaState createState() => DerivacionLogaritmicaState();
}

class DerivacionLogaritmicaState extends State<DerivacionLogaritmica> {
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
                    AppLocalizations.of(context)!.derivacionLogaritmica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.derivacionLogaritmica,
                        widgetName: kWidgetDerivacionLogaritmica,
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
                                )!.derivacionLogaritmica,
                                widgetName: kWidgetDerivacionLogaritmica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.derivacionLogaritmica,
                                widgetName: kWidgetDerivacionLogaritmica,
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
                        r"\frac{d}{dx}\,x^{x} = x^{x}\left(1+\ln x\right)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\frac{d}{dx}\,x^{\operatorname{sen} x} = x^{\operatorname{sen} x}\left(\cos x\cdot\ln x+\frac{\operatorname{sen} x}{x}\right)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDerivacionLogaritmica),
            const DescargarPDF(url: kWidgetDerivacionLogaritmica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
