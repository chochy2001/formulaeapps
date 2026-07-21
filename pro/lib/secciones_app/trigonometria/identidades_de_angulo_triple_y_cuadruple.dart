import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class IdentidadesDeAnguloTripleYCuadruple extends StatefulWidget {
  const IdentidadesDeAnguloTripleYCuadruple({super.key});

  @override
  IdentidadesDeAnguloTripleYCuadrupleState createState() =>
      IdentidadesDeAnguloTripleYCuadrupleState();
}

class IdentidadesDeAnguloTripleYCuadrupleState
    extends State<IdentidadesDeAnguloTripleYCuadruple> {
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
                    )!.identidadesDeAnguloTripleYCuadruple,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.identidadesDeAnguloTripleYCuadruple,
                        widgetName: kWidgetIdentidadesDeAnguloTripleYCuadruple,
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
                                )!.identidadesDeAnguloTripleYCuadruple,
                                widgetName:
                                    kWidgetIdentidadesDeAnguloTripleYCuadruple,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.identidadesDeAnguloTripleYCuadruple,
                                widgetName:
                                    kWidgetIdentidadesDeAnguloTripleYCuadruple,
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
                        r"\operatorname{sen} 3A = 3\,\operatorname{sen} A - 4\,\operatorname{sen}^{3}A",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos 3A = 4\cos^{3}A - 3\cos A"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\tan 3A = \dfrac{3\tan A - \tan^{3}A}{1 - 3\tan^{2}A}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\operatorname{sen} 4A = 4\,\operatorname{sen} A\cos A - 8\,\operatorname{sen}^{3}A\cos A",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\cos 4A = 8\cos^{4}A - 8\cos^{2}A + 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\tan 4A = \dfrac{4\tan A - 4\tan^{3}A}{1 - 6\tan^{2}A + \tan^{4}A}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetIdentidadesDeAnguloTripleYCuadruple),
            const DescargarPDF(url: kWidgetIdentidadesDeAnguloTripleYCuadruple),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
