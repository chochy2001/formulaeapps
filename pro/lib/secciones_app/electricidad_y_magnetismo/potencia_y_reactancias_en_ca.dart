import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PotenciaYReactanciasEnCa extends StatefulWidget {
  const PotenciaYReactanciasEnCa({super.key});

  @override
  PotenciaYReactanciasEnCaState createState() => PotenciaYReactanciasEnCaState();
}

class PotenciaYReactanciasEnCaState extends State<PotenciaYReactanciasEnCa> {
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
                    AppLocalizations.of(context)!.potenciaYReactanciasEnCa,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.potenciaYReactanciasEnCa,
                        widgetName: kWidgetPotenciaYReactanciasEnCa,
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
                                title: AppLocalizations.of(context)!.potenciaYReactanciasEnCa,
                                widgetName: kWidgetPotenciaYReactanciasEnCa,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.potenciaYReactanciasEnCa,
                                widgetName: kWidgetPotenciaYReactanciasEnCa,
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
                  Latex(formulaText: r"S = P \pm jQ"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"P = i\,V\cos\phi"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"Q = i\,V\sin\phi"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"X_{L} = 2\pi f L"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"X_{C} = \frac{1}{2\pi f C}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"Z = \sqrt{R^{2} + (X_{L} - X_{C})^{2}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan\phi = \frac{X_{L} - X_{C}}{R}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"V_{T} = \sqrt{V_{R}^{2} + (V_{L} - V_{C})^{2}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tan\phi = \frac{V_{L} - V_{C}}{V_{R}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"f_{r} = \frac{1}{2\pi\sqrt{L C}}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"fp = \cos\phi"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"fp > 0.9"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPotenciaYReactanciasEnCa),
            const DescargarPDF(url: kWidgetPotenciaYReactanciasEnCa),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
