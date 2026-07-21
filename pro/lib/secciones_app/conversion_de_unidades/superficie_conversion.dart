import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class SuperficieConversion extends StatefulWidget {
  const SuperficieConversion({super.key});

  @override
  SuperficieConversionState createState() => SuperficieConversionState();
}

class SuperficieConversionState extends State<SuperficieConversion> {
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
                    AppLocalizations.of(context)!.superficieConversion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(
                          context,
                        )!.superficieConversion,
                        widgetName: kWidgetSuperficieConversion,
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
                                )!.superficieConversion,
                                widgetName: kWidgetSuperficieConversion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.superficieConversion,
                                widgetName: kWidgetSuperficieConversion,
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
                        r"1\ \text{cm}^{2} = 1.0\times10^{-4}\ \text{m}^{2} = 0.15500\ \text{pulg}^{2} = 1.0764\times10^{-3}\ \text{pie}^{2} = 1.1960\times10^{-4}\ \text{yd}^{2} = 3.8610\times10^{-11}\ \text{milla}^{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \text{m}^{2} = 1.0\times10^{4}\ \text{cm}^{2} = 1550.0\ \text{pulg}^{2} = 10.764\ \text{pie}^{2} = 1.1960\ \text{yd}^{2} = 3.8610\times10^{-7}\ \text{milla}^{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \text{pulg}^{2} = 6.4516\ \text{cm}^{2} = 6.4516\times10^{-4}\ \text{m}^{2} = 6.9444\times10^{-3}\ \text{pie}^{2} = 7.7160\times10^{-4}\ \text{yd}^{2} = 2.4910\times10^{-10}\ \text{milla}^{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \text{pie}^{2} = 929.03\ \text{cm}^{2} = 0.092903\ \text{m}^{2} = 144\ \text{pulg}^{2} = 0.11111\ \text{yd}^{2} = 3.5870\times10^{-8}\ \text{milla}^{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \text{yd}^{2} = 8361.3\ \text{cm}^{2} = 0.83613\ \text{m}^{2} = 1296\ \text{pulg}^{2} = 9\ \text{pie}^{2} = 3.2283\times10^{-7}\ \text{milla}^{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \text{milla}^{2} = 2.5900\times10^{10}\ \text{cm}^{2} = 2.5900\times10^{6}\ \text{m}^{2} = 4.0145\times10^{9}\ \text{pulg}^{2} = 2.7878\times10^{7}\ \text{pie}^{2} = 3.0976\times10^{6}\ \text{yd}^{2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetSuperficieConversion),
            const DescargarPDF(url: kWidgetSuperficieConversion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
