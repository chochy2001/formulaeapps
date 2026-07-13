import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class HiperbolaEquilatera extends StatefulWidget {
  const HiperbolaEquilatera({super.key});

  @override
  HiperbolaEquilateraState createState() => HiperbolaEquilateraState();
}

class HiperbolaEquilateraState extends State<HiperbolaEquilatera> {
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
                    AppLocalizations.of(context)!.hiperbolaEquilatera,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.hiperbolaEquilatera,
                        widgetName: kWidgetHiperbolaEquilatera,
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
                                title: AppLocalizations.of(context)!.hiperbolaEquilatera,
                                widgetName: kWidgetHiperbolaEquilatera,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.hiperbolaEquilatera,
                                widgetName: kWidgetHiperbolaEquilatera,
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
                  Latex(formulaText: r"a = b"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan\alpha = m = \pm 1 \quad (\alpha = 45^{\circ})"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x\,y = c^2"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"(x - x_0)(y - y_0) = c^2"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"p = a"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetHiperbolaEquilatera),
            const DescargarPDF(url: kWidgetHiperbolaEquilatera),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
