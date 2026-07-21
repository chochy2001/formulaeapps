import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class EntalpiaYEnergiaInterna extends StatefulWidget {
  const EntalpiaYEnergiaInterna({super.key});

  @override
  EntalpiaYEnergiaInternaState createState() => EntalpiaYEnergiaInternaState();
}

class EntalpiaYEnergiaInternaState extends State<EntalpiaYEnergiaInterna> {
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
                    AppLocalizations.of(context)!.entalpiaYEnergiaInterna,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.entalpiaYEnergiaInterna,
                        widgetName: kWidgetEntalpiaYEnergiaInterna,
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
                                )!.entalpiaYEnergiaInterna,
                                widgetName: kWidgetEntalpiaYEnergiaInterna,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.entalpiaYEnergiaInterna,
                                widgetName: kWidgetEntalpiaYEnergiaInterna,
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
                  Latex(formulaText: r"H = E + PV"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta H = \Delta E + P\,\Delta V"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta H = Q"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta E = C_V\,\Delta T"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta H = C_P\,\Delta T"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\Delta H = \int C_{P}\, dT"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEntalpiaYEnergiaInterna),
            const DescargarPDF(url: kWidgetEntalpiaYEnergiaInterna),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
