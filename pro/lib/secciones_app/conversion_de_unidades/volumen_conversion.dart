import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class VolumenConversion extends StatefulWidget {
  const VolumenConversion({super.key});

  @override
  VolumenConversionState createState() => VolumenConversionState();
}

class VolumenConversionState extends State<VolumenConversion> {
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
                    AppLocalizations.of(context)!.volumenConversion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.volumenConversion,
                        widgetName: kWidgetVolumenConversion,
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
                                title: AppLocalizations.of(context)!.volumenConversion,
                                widgetName: kWidgetVolumenConversion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.volumenConversion,
                                widgetName: kWidgetVolumenConversion,
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
                  Latex(formulaText: r"1\ \text{cm}^{3} = 1.0\times10^{-3}\ \text{L} = 1.0\times10^{-6}\ \text{m}^{3} = 6.1024\times10^{-2}\ \text{pulg}^{3} = 3.5315\times10^{-5}\ \text{pie}^{3} = 2.6417\times10^{-4}\ \text{gal}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{L} = 1000\ \text{cm}^{3} = 1.0\times10^{-3}\ \text{m}^{3} = 61.024\ \text{pulg}^{3} = 3.5315\times10^{-2}\ \text{pie}^{3} = 0.26417\ \text{gal}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{m}^{3} = 1.0\times10^{6}\ \text{cm}^{3} = 1000\ \text{L} = 6.1024\times10^{4}\ \text{pulg}^{3} = 35.315\ \text{pie}^{3} = 264.17\ \text{gal}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{pulg}^{3} = 16.387\ \text{cm}^{3} = 1.6387\times10^{-2}\ \text{L} = 1.6387\times10^{-5}\ \text{m}^{3} = 5.7870\times10^{-4}\ \text{pie}^{3} = 4.3290\times10^{-3}\ \text{gal}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{pie}^{3} = 28317\ \text{cm}^{3} = 28.317\ \text{L} = 2.8317\times10^{-2}\ \text{m}^{3} = 1728\ \text{pulg}^{3} = 7.4805\ \text{gal}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{gal} = 3785.4\ \text{cm}^{3} = 3.7854\ \text{L} = 3.7854\times10^{-3}\ \text{m}^{3} = 231\ \text{pulg}^{3} = 0.13368\ \text{pie}^{3}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetVolumenConversion),
            const DescargarPDF(url: kWidgetVolumenConversion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
