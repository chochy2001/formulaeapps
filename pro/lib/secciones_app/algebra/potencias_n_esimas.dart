import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PotenciasNEsimas extends StatefulWidget {
  const PotenciasNEsimas({super.key});

  @override
  PotenciasNEsimasState createState() => PotenciasNEsimasState();
}

class PotenciasNEsimasState extends State<PotenciasNEsimas> {
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
                    AppLocalizations.of(context)!.potenciasNEsimas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.potenciasNEsimas,
                        widgetName: kWidgetPotenciasNEsimas,
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
                                title: AppLocalizations.of(context)!.potenciasNEsimas,
                                widgetName: kWidgetPotenciasNEsimas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.potenciasNEsimas,
                                widgetName: kWidgetPotenciasNEsimas,
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
                  Latex(formulaText: r"a^{4} - b^{4} = (a-b)(a^{3} + a^{2}b + ab^{2} + b^{3})"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a^{5} + b^{5} = (a+b)(a^{4} - a^{3}b + a^{2}b^{2} - ab^{3} + b^{4})"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a^{n} - b^{n} = (a-b)\left(a^{n-1} + a^{n-2}b + a^{n-3}b^{2} + \dots + ab^{n-2} + b^{n-1}\right)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"a^{n} + b^{n} = (a+b)\left(a^{n-1} - a^{n-2}b + a^{n-3}b^{2} - \dots - ab^{n-2} + b^{n-1}\right)"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPotenciasNEsimas),
            const DescargarPDF(url: kWidgetPotenciasNEsimas),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
