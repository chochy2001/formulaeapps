import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DeterminantesCramerSarrus extends StatefulWidget {
  const DeterminantesCramerSarrus({super.key});

  @override
  DeterminantesCramerSarrusState createState() => DeterminantesCramerSarrusState();
}

class DeterminantesCramerSarrusState extends State<DeterminantesCramerSarrus> {
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
                    AppLocalizations.of(context)!.determinantesCramerSarrus,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.determinantesCramerSarrus,
                        widgetName: kWidgetDeterminantesCramerSarrus,
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
                                title: AppLocalizations.of(context)!.determinantesCramerSarrus,
                                widgetName: kWidgetDeterminantesCramerSarrus,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.determinantesCramerSarrus,
                                widgetName: kWidgetDeterminantesCramerSarrus,
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
                  Latex(formulaText: r"\begin{cases} a_{11}\,x + a_{12}\,y = r_{1} \\ a_{21}\,x + a_{22}\,y = r_{2} \end{cases}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"D = \begin{vmatrix} a_{11} & a_{12} \\ a_{21} & a_{22} \end{vmatrix} = a_{11}a_{22} - a_{21}a_{12}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"D_{1} = \begin{vmatrix} r_{1} & a_{12} \\ r_{2} & a_{22} \end{vmatrix} = r_{1}a_{22} - r_{2}a_{12}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x = \frac{D_{1}}{D}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"D_{2} = \begin{vmatrix} a_{11} & r_{1} \\ a_{21} & r_{2} \end{vmatrix} = r_{2}a_{11} - r_{1}a_{21}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"y = \frac{D_{2}}{D}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\begin{cases} a_{11}\,x + a_{12}\,y + a_{13}\,z = r_{1} \\ a_{21}\,x + a_{22}\,y + a_{23}\,z = r_{2} \\ a_{31}\,x + a_{32}\,y + a_{33}\,z = r_{3} \end{cases}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"D = \begin{vmatrix} a_{11} & a_{12} & a_{13} \\ a_{21} & a_{22} & a_{23} \\ a_{31} & a_{32} & a_{33} \end{vmatrix} = a_{11}a_{22}a_{33} + a_{12}a_{23}a_{31} + a_{13}a_{21}a_{32} - a_{13}a_{22}a_{31} - a_{11}a_{23}a_{32} - a_{12}a_{21}a_{33}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"D_{1} = \begin{vmatrix} r_{1} & a_{12} & a_{13} \\ r_{2} & a_{22} & a_{23} \\ r_{3} & a_{32} & a_{33} \end{vmatrix} = r_{1}a_{22}a_{33} + a_{12}a_{23}r_{3} + a_{13}r_{2}a_{32} - a_{13}a_{22}r_{3} - r_{1}a_{23}a_{32} - a_{12}r_{2}a_{33}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"x = \frac{D_{1}}{D} \qquad y = \frac{D_{2}}{D} \qquad z = \frac{D_{3}}{D}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDeterminantesCramerSarrus),
            const DescargarPDF(url: kWidgetDeterminantesCramerSarrus),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
