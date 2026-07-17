import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LaRectaYElTriangulo extends StatefulWidget {
  const LaRectaYElTriangulo({super.key});

  @override
  LaRectaYElTrianguloState createState() => LaRectaYElTrianguloState();
}

class LaRectaYElTrianguloState extends State<LaRectaYElTriangulo> {
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
                    AppLocalizations.of(context)!.laRectaYElTriangulo,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.laRectaYElTriangulo,
                        widgetName: kWidgetLaRectaYElTriangulo,
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
                                title: AppLocalizations.of(context)!.laRectaYElTriangulo,
                                widgetName: kWidgetLaRectaYElTriangulo,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.laRectaYElTriangulo,
                                widgetName: kWidgetLaRectaYElTriangulo,
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
                  Latex(formulaText: r"\frac{y - y_1}{x - x_1} = \frac{y_2 - y_1}{x_2 - x_1}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x_3 = \frac{b_2 - b_1}{m_1 - m_2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y_3 = m_1 x_3 + b_1 = m_2 x_3 + b_2"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan\phi = \frac{m_2 - m_1}{1 + m_2 m_1}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x_G = \frac{x_1 + x_2 + x_3}{3}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y_G = \frac{y_1 + y_2 + y_3}{3}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"A = \frac{(x_1 y_2 - x_2 y_1) + (x_2 y_3 - x_3 y_2) + (x_3 y_1 - x_1 y_3)}{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLaRectaYElTriangulo),
            const DescargarPDF(url: kWidgetLaRectaYElTriangulo),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
