import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionCubica extends StatefulWidget {
  const EcuacionCubica({super.key});

  @override
  EcuacionCubicaState createState() => EcuacionCubicaState();
}

class EcuacionCubicaState extends State<EcuacionCubica> {
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
                    AppLocalizations.of(context)!.ecuacionCubica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.ecuacionCubica,
                        widgetName: kWidgetEcuacionCubica,
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
                                )!.ecuacionCubica,
                                widgetName: kWidgetEcuacionCubica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.ecuacionCubica,
                                widgetName: kWidgetEcuacionCubica,
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
                  Latex(formulaText: r"x^{3}+a_{1}x^{2}+a_{2}x+a_{3}=0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"Q=\frac{3a_{2}-a_{1}^{2}}{9}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"R=\frac{9a_{1}a_{2}-27a_{3}-2a_{1}^{3}}{54}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"S=\sqrt[3]{R+\sqrt{Q^{3}+R^{2}}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"T=\sqrt[3]{R-\sqrt{Q^{3}+R^{2}}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x_{1}=S+T-\frac{1}{3}a_{1}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"x_{2}=-\frac{1}{2}\left(S+T\right)-\frac{1}{3}a_{1}+\frac{1}{2}i\sqrt{3}\left(S-T\right)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"x_{3}=-\frac{1}{2}\left(S+T\right)-\frac{1}{3}a_{1}-\frac{1}{2}i\sqrt{3}\left(S-T\right)",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"D=Q^{3}+R^{2}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEcuacionCubica),
            const DescargarPDF(url: kWidgetEcuacionCubica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
