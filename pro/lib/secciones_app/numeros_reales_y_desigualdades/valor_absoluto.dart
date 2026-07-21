import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ValorAbsoluto extends StatefulWidget {
  const ValorAbsoluto({super.key});

  @override
  ValorAbsolutoState createState() => ValorAbsolutoState();
}

class ValorAbsolutoState extends State<ValorAbsoluto> {
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
                    AppLocalizations.of(context)!.valorAbsoluto,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.valorAbsoluto,
                        widgetName: kWidgetValorAbsoluto,
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
                                )!.valorAbsoluto,
                                widgetName: kWidgetValorAbsoluto,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.valorAbsoluto,
                                widgetName: kWidgetValorAbsoluto,
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
                        r"|a| = \begin{cases} a & \text{si } a \ge 0 \\ -a & \text{si } a < 0 \end{cases}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"|a| = |-a|"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"a \le |a| \quad \text{y} \quad -a \le |-a|",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"|a| \ge 0, \quad |a| = 0 \implies a = 0",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"|a|\,|b| = |ab|"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetValorAbsoluto),
            const DescargarPDF(url: kWidgetValorAbsoluto),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
