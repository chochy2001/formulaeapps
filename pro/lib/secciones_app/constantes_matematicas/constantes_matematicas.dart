import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ConstantesMatematicas extends StatefulWidget {
  const ConstantesMatematicas({super.key});

  @override
  ConstantesMatematicasState createState() => ConstantesMatematicasState();
}

class ConstantesMatematicasState extends State<ConstantesMatematicas> {
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
                    AppLocalizations.of(context)!.constantesMatematicas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.constantesMatematicas,
                        widgetName: kWidgetConstantesMatematicas,
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
                                title: AppLocalizations.of(context)!.constantesMatematicas,
                                widgetName: kWidgetConstantesMatematicas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.constantesMatematicas,
                                widgetName: kWidgetConstantesMatematicas,
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
                  Latex(formulaText: r"\pi = 3.1415927"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e = 2.7182818"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\ln 2 = 0.6931472"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\ln 10 = 2.3025851"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sqrt{2} = 1.4142136"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sqrt{3} = 1.7320508"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{rad} = 57.2957795^{\circ}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log_{10} e = 0.4342945"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log_{10} 3 = 0.4771212"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log_{e} 2 = 0.6931471"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log_{e} 3 = 1.0986122"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log_{e} \pi = 1.1447298"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e^{\pi/2} = 4.8104773"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{1}{e} = 0.3678794"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\log_{10} M = -0.36221"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\frac{1}{\pi} = 0.3183098"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e^{2} = 7.3890560"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\pi^{e} = 22.459157"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\pi^{2} = 9.8696044"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e^{\pi} = 23.140692"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"e^{-\pi} = 0.0432139"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetConstantesMatematicas),
            const DescargarPDF(url: kWidgetConstantesMatematicas),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
