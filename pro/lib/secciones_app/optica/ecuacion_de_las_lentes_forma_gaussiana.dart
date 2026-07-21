import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class EcuacionDeLasLentesFormaGaussiana extends StatefulWidget {
  const EcuacionDeLasLentesFormaGaussiana({super.key});

  @override
  EcuacionDeLasLentesFormaGaussianaState createState() =>
      EcuacionDeLasLentesFormaGaussianaState();
}

class EcuacionDeLasLentesFormaGaussianaState
    extends State<EcuacionDeLasLentesFormaGaussiana> {
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
                    )!.ecuacionDeLasLentesFormaGaussiana,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.ecuacionDeLasLentesFormaGaussiana,
                        widgetName: kWidgetEcuacionDeLasLentesFormaGaussiana,
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
                                )!.ecuacionDeLasLentesFormaGaussiana,
                                widgetName:
                                    kWidgetEcuacionDeLasLentesFormaGaussiana,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.ecuacionDeLasLentesFormaGaussiana,
                                widgetName:
                                    kWidgetEcuacionDeLasLentesFormaGaussiana,
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
                    formulaText: r"\frac{1}{p} + \frac{1}{q} = \frac{1}{f}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\frac{1}{p} - \frac{1}{q} = \frac{1}{f}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\frac{1}{p} - \frac{1}{q} = -\frac{1}{f}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEcuacionDeLasLentesFormaGaussiana),
            const DescargarPDF(url: kWidgetEcuacionDeLasLentesFormaGaussiana),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
