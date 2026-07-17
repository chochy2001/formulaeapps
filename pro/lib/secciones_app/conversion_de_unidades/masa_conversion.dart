import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MasaConversion extends StatefulWidget {
  const MasaConversion({super.key});

  @override
  MasaConversionState createState() => MasaConversionState();
}

class MasaConversionState extends State<MasaConversion> {
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
                    AppLocalizations.of(context)!.masaConversion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.masaConversion,
                        widgetName: kWidgetMasaConversion,
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
                                title: AppLocalizations.of(context)!.masaConversion,
                                widgetName: kWidgetMasaConversion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.masaConversion,
                                widgetName: kWidgetMasaConversion,
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
                  Latex(formulaText: r"1\ \text{g} = 1.0\times10^{-3}\ \text{kg} = 3.5274\times10^{-2}\ \text{oz} = 2.2046\times10^{-3}\ \text{lb} = 1.0\times10^{-6}\ \text{ton met.} = 1.1023\times10^{-6}\ \text{ton corta}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{kg} = 1000\ \text{g} = 35.274\ \text{oz} = 2.2046\ \text{lb} = 1.0\times10^{-3}\ \text{ton met.} = 1.1023\times10^{-3}\ \text{ton corta}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{oz} = 28.350\ \text{g} = 2.8350\times10^{-2}\ \text{kg} = 0.0625\ \text{lb} = 2.8350\times10^{-5}\ \text{ton met.} = 3.125\times10^{-5}\ \text{ton corta}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{lb} = 453.59\ \text{g} = 0.45359\ \text{kg} = 16\ \text{oz} = 4.5359\times10^{-4}\ \text{ton met.} = 5.0\times10^{-4}\ \text{ton corta}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{ton met.} = 1.0\times10^{6}\ \text{g} = 1000\ \text{kg} = 3.5274\times10^{4}\ \text{oz} = 2204.6\ \text{lb} = 1.1023\ \text{ton corta}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{ton corta} = 9.0718\times10^{5}\ \text{g} = 907.18\ \text{kg} = 3.2\times10^{4}\ \text{oz} = 2000\ \text{lb} = 0.90718\ \text{ton met.}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetMasaConversion),
            const DescargarPDF(url: kWidgetMasaConversion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
