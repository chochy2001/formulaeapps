import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class TangentesYPropiedadesDeLasConicas extends StatefulWidget {
  const TangentesYPropiedadesDeLasConicas({super.key});

  @override
  TangentesYPropiedadesDeLasConicasState createState() => TangentesYPropiedadesDeLasConicasState();
}

class TangentesYPropiedadesDeLasConicasState extends State<TangentesYPropiedadesDeLasConicas> {
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
                    AppLocalizations.of(context)!.tangentesYPropiedadesDeLasConicas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.tangentesYPropiedadesDeLasConicas,
                        widgetName: kWidgetTangentesYPropiedadesDeLasConicas,
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
                                title: AppLocalizations.of(context)!.tangentesYPropiedadesDeLasConicas,
                                widgetName: kWidgetTangentesYPropiedadesDeLasConicas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.tangentesYPropiedadesDeLasConicas,
                                widgetName: kWidgetTangentesYPropiedadesDeLasConicas,
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
                  Latex(formulaText: r"y = \frac{r^2 - (x - x_0)(x_1 - x_0)}{y_1 - y_0} + y_0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\overline{PF} = \overline{PQ}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"r = p"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y = \frac{2(y_1 - y_0)(x - x_1)}{x_1 - x_0} + y_1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\overline{F_2 P} - \overline{F_1 P} = 2a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"p = \frac{b^2}{a}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan\alpha = m = \pm\frac{b}{a}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y = \frac{b^2}{a^2}\cdot\frac{(x_1 - x_0)(x - x_1)}{y_1 - y_0} + y_1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\overline{F_1 P} + \overline{F_2 P} = 2a"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"r_N = \frac{b^2}{a}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"r_H = \frac{a^2}{b}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y = -\frac{b^2}{a^2}\cdot\frac{(x_1 - x_0)(x - x_1)}{y_1 - y_0} + y_1"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetTangentesYPropiedadesDeLasConicas),
            const DescargarPDF(url: kWidgetTangentesYPropiedadesDeLasConicas),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
