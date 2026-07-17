import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DilatacionSuperficialYVolumetrica extends StatefulWidget {
  const DilatacionSuperficialYVolumetrica({super.key});

  @override
  DilatacionSuperficialYVolumetricaState createState() => DilatacionSuperficialYVolumetricaState();
}

class DilatacionSuperficialYVolumetricaState extends State<DilatacionSuperficialYVolumetrica> {
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
                    AppLocalizations.of(context)!.dilatacionSuperficialYVolumetrica,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.dilatacionSuperficialYVolumetrica,
                        widgetName: kWidgetDilatacionSuperficialYVolumetrica,
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
                                title: AppLocalizations.of(context)!.dilatacionSuperficialYVolumetrica,
                                widgetName: kWidgetDilatacionSuperficialYVolumetrica,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.dilatacionSuperficialYVolumetrica,
                                widgetName: kWidgetDilatacionSuperficialYVolumetrica,
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
                  Latex(formulaText: r"\frac{\Delta V}{V} = \beta\,\Delta T"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V = V_0 + \beta V_0\,\Delta t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta V = \beta V_0\,\Delta t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta V = V_f - V_0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\beta = 3\alpha"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\alpha = \frac{1}{V}\left(\frac{\partial V}{\partial T}\right)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\alpha_v \approx \frac{1}{V(T)}\,\frac{\Delta V(T)}{\Delta T} = \frac{d\ln V(T)}{dT}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta V = \frac{(T_2 - T_1)\,nR}{P}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"A = A_0 + \gamma A_0\,\Delta t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta A = \gamma A_0\,\Delta t"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\gamma = 2\alpha"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDilatacionSuperficialYVolumetrica),
            const DescargarPDF(url: kWidgetDilatacionSuperficialYVolumetrica),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
