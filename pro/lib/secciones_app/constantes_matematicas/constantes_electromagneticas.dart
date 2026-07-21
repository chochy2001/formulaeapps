import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ConstantesElectromagneticas extends StatefulWidget {
  const ConstantesElectromagneticas({super.key});

  @override
  ConstantesElectromagneticasState createState() =>
      ConstantesElectromagneticasState();
}

class ConstantesElectromagneticasState
    extends State<ConstantesElectromagneticas> {
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
                    AppLocalizations.of(context)!.constantesElectromagneticas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.constantesElectromagneticas,
                        widgetName: kWidgetConstantesElectromagneticas,
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
                                )!.constantesElectromagneticas,
                                widgetName: kWidgetConstantesElectromagneticas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.constantesElectromagneticas,
                                widgetName: kWidgetConstantesElectromagneticas,
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
                  Latex(formulaText: r"e = 1.602 \times 10^{-19}\ \mathrm{C}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\varepsilon_0 = 8.854\,187 \times 10^{-12}\ \mathrm{F/m}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\mu_0 = 1.26 \times 10^{-6}\ \mathrm{H/m}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"F = 96\,485.3\ \mathrm{C/mol}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"\mu_B = 927.400 \times 10^{-26}\ \mathrm{J/T}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText: r"\mu_N = 5.05 \times 10^{-27}\ \mathrm{J/T}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetConstantesElectromagneticas),
            const DescargarPDF(url: kWidgetConstantesElectromagneticas),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
