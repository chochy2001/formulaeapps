import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DesigualdadesTeoremasDeOrden extends StatefulWidget {
  const DesigualdadesTeoremasDeOrden({super.key});

  @override
  DesigualdadesTeoremasDeOrdenState createState() =>
      DesigualdadesTeoremasDeOrdenState();
}

class DesigualdadesTeoremasDeOrdenState
    extends State<DesigualdadesTeoremasDeOrden> {
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
                    AppLocalizations.of(context)!.desigualdadesTeoremasDeOrden,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.desigualdadesTeoremasDeOrden,
                        widgetName: kWidgetDesigualdadesTeoremasDeOrden,
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
                                )!.desigualdadesTeoremasDeOrden,
                                widgetName: kWidgetDesigualdadesTeoremasDeOrden,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.desigualdadesTeoremasDeOrden,
                                widgetName: kWidgetDesigualdadesTeoremasDeOrden,
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
                        r"a < b \ \text{y}\ c < d \implies a + c < b + d",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"0 \le a < b \ \text{y}\ 0 \le c < d \implies a\,c < b\,d",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a\,b > 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a\,b < 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a < b \implies a^{-1} > b^{-1}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a^{2} > b^{2} \iff a > b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"a^{2} > b \iff a > \sqrt{b} \ \text{o}\ a < -\sqrt{b}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"a^{2} < b \iff -\sqrt{b} < a < \sqrt{b}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDesigualdadesTeoremasDeOrden),
            const DescargarPDF(url: kWidgetDesigualdadesTeoremasDeOrden),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
