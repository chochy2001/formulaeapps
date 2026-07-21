import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesFundamentalesFormasDerivadas extends StatefulWidget {
  const IdentidadesFundamentalesFormasDerivadas({super.key});

  @override
  IdentidadesFundamentalesFormasDerivadasState createState() =>
      IdentidadesFundamentalesFormasDerivadasState();
}

class IdentidadesFundamentalesFormasDerivadasState
    extends State<IdentidadesFundamentalesFormasDerivadas> {
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
                    )!.identidadesFundamentalesFormasDerivadas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.identidadesFundamentalesFormasDerivadas,
                        widgetName:
                            kWidgetIdentidadesFundamentalesFormasDerivadas,
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
                                )!.identidadesFundamentalesFormasDerivadas,
                                widgetName:
                                    kWidgetIdentidadesFundamentalesFormasDerivadas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.identidadesFundamentalesFormasDerivadas,
                                widgetName:
                                    kWidgetIdentidadesFundamentalesFormasDerivadas,
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
                  Latex(formulaText: r"\operatorname{sen} A = \tan A \cos A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\cos A = \dfrac{\operatorname{sen} A}{\tan A}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos A = \cot A \,\operatorname{sen} A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\operatorname{sen} A = \dfrac{\cos A}{\cot A}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\operatorname{sen}^{2}A = 1 - \cos^{2}A",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\cos^{2}A = 1 - \operatorname{sen}^{2}A",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan^{2}A = \sec^{2}A - 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1 = \sec^{2}A - \tan^{2}A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cot^{2}A = \csc^{2}A - 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1 = \csc^{2}A - \cot^{2}A"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetIdentidadesFundamentalesFormasDerivadas),
            const DescargarPDF(
              url: kWidgetIdentidadesFundamentalesFormasDerivadas,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
