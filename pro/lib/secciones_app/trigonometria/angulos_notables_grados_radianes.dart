import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class AngulosNotablesGradosRadianes extends StatefulWidget {
  const AngulosNotablesGradosRadianes({super.key});

  @override
  AngulosNotablesGradosRadianesState createState() => AngulosNotablesGradosRadianesState();
}

class AngulosNotablesGradosRadianesState extends State<AngulosNotablesGradosRadianes> {
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
                    AppLocalizations.of(context)!.angulosNotablesGradosRadianes,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.angulosNotablesGradosRadianes,
                        widgetName: kWidgetAngulosNotablesGradosRadianes,
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
                                title: AppLocalizations.of(context)!.angulosNotablesGradosRadianes,
                                widgetName: kWidgetAngulosNotablesGradosRadianes,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.angulosNotablesGradosRadianes,
                                widgetName: kWidgetAngulosNotablesGradosRadianes,
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
                  Latex(formulaText: r"0^{\circ} = 0 \ \text{rad} = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"15^{\circ} = \dfrac{\pi}{12} \approx 0.26"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"30^{\circ} = \dfrac{\pi}{6} \approx 0.52"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"45^{\circ} = \dfrac{\pi}{4} \approx 0.78"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"60^{\circ} = \dfrac{\pi}{3} \approx 1.05"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"90^{\circ} = \dfrac{\pi}{2} \approx 1.57"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"120^{\circ} = \dfrac{2\pi}{3}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"135^{\circ} = \dfrac{3\pi}{4}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"150^{\circ} = \dfrac{5\pi}{6}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"180^{\circ} = \pi \approx 3.14"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"210^{\circ} = \dfrac{7\pi}{6}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"225^{\circ} = \dfrac{5\pi}{4}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"240^{\circ} = \dfrac{4\pi}{3}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"270^{\circ} = \dfrac{3\pi}{2} \approx 4.71"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"300^{\circ} = \dfrac{5\pi}{3}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"315^{\circ} = \dfrac{7\pi}{4}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"330^{\circ} = \dfrac{11\pi}{6}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"360^{\circ} = 2\pi \approx 6.28"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetAngulosNotablesGradosRadianes),
            const DescargarPDF(url: kWidgetAngulosNotablesGradosRadianes),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
