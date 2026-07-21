import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionCuadraticaFormaMonicaVieta extends StatefulWidget {
  const EcuacionCuadraticaFormaMonicaVieta({super.key});

  @override
  EcuacionCuadraticaFormaMonicaVietaState createState() =>
      EcuacionCuadraticaFormaMonicaVietaState();
}

class EcuacionCuadraticaFormaMonicaVietaState
    extends State<EcuacionCuadraticaFormaMonicaVieta> {
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
                    )!.ecuacionCuadraticaFormaMonicaVieta,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.ecuacionCuadraticaFormaMonicaVieta,
                        widgetName: kWidgetEcuacionCuadraticaFormaMonicaVieta,
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
                                )!.ecuacionCuadraticaFormaMonicaVieta,
                                widgetName:
                                    kWidgetEcuacionCuadraticaFormaMonicaVieta,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.ecuacionCuadraticaFormaMonicaVieta,
                                widgetName:
                                    kWidgetEcuacionCuadraticaFormaMonicaVieta,
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
                  Latex(formulaText: r"x^{2} + px + q = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"x_{1},\, x_{2} = -\frac{p}{2} \pm \sqrt{\frac{p^{2}}{4} - q}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"p = -(x_{1} + x_{2}); \quad q = x_{1}\cdot x_{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"x_{1}+x_{2}=-\frac{b}{a}\qquad x_{1}x_{2}=\frac{c}{a}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEcuacionCuadraticaFormaMonicaVieta),
            const DescargarPDF(url: kWidgetEcuacionCuadraticaFormaMonicaVieta),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
