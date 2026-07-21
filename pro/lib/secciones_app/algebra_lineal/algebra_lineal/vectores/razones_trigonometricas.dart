import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AlgebraLinealVectoresRazonesTrigonometricas extends StatefulWidget {
  const AlgebraLinealVectoresRazonesTrigonometricas({super.key});

  @override
  AlgebraLinealVectoresRazonesTrigonometricasState createState() =>
      AlgebraLinealVectoresRazonesTrigonometricasState();
}

class AlgebraLinealVectoresRazonesTrigonometricasState
    extends State<AlgebraLinealVectoresRazonesTrigonometricas> {
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
                    )!.algebraLinealVectoresRazonesTrigonometricas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.algebraLinealVectoresRazonesTrigonometricas,
                        widgetName:
                            kWidgetAlgebraLinealVectoresRazonesTrigonometricas,
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
                                )!.algebraLinealVectoresRazonesTrigonometricas,
                                widgetName:
                                    kWidgetAlgebraLinealVectoresRazonesTrigonometricas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.algebraLinealVectoresRazonesTrigonometricas,
                                widgetName:
                                    kWidgetAlgebraLinealVectoresRazonesTrigonometricas,
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
                        r"\operatorname{sen}\theta = \frac{\text{Cateto opuesto}}{\text{Hipotenusa}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\cos\theta = \frac{\text{Cateto adyacente}}{\text{Hipotenusa}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\tan\theta = \frac{\text{Cateto opuesto}}{\text{Cateto adyacente}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\cot\theta = \frac{\text{Cateto adyacente}}{\text{Cateto opuesto}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\sec\theta = \frac{\text{Hipotenusa}}{\text{Cateto adyacente}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\csc\theta = \frac{\text{Hipotenusa}}{\text{Cateto opuesto}}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(
              url: kWidgetAlgebraLinealVectoresRazonesTrigonometricas,
            ),
            const DescargarPDF(
              url: kWidgetAlgebraLinealVectoresRazonesTrigonometricas,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
