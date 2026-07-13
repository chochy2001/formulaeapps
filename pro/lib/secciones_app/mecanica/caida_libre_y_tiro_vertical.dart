import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class CaidaLibreYTiroVertical extends StatefulWidget {
  const CaidaLibreYTiroVertical({super.key});

  @override
  CaidaLibreYTiroVerticalState createState() => CaidaLibreYTiroVerticalState();
}

class CaidaLibreYTiroVerticalState extends State<CaidaLibreYTiroVertical> {
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
                    AppLocalizations.of(context)!.caidaLibreYTiroVertical,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.caidaLibreYTiroVertical,
                        widgetName: kWidgetCaidaLibreYTiroVertical,
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
                                title: AppLocalizations.of(context)!.caidaLibreYTiroVertical,
                                widgetName: kWidgetCaidaLibreYTiroVertical,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.caidaLibreYTiroVertical,
                                widgetName: kWidgetCaidaLibreYTiroVertical,
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
                  Latex(formulaText: r"V_f = V_0 + g t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"h = V_0 t + \frac{g t^{2}}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V_f^{2} = V_0^{2} + 2 g h"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"h = \left(\frac{V_f + V_0}{2}\right) t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V_f = g t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"h = \frac{g t^{2}}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V_f^{2} = 2 g h"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"h = \left(\frac{V_f}{2}\right) t"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetCaidaLibreYTiroVertical),
            const DescargarPDF(url: kWidgetCaidaLibreYTiroVertical),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
