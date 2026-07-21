import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class DensidadConversion extends StatefulWidget {
  const DensidadConversion({super.key});

  @override
  DensidadConversionState createState() => DensidadConversionState();
}

class DensidadConversionState extends State<DensidadConversion> {
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
                    AppLocalizations.of(context)!.densidadConversion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.densidadConversion,
                        widgetName: kWidgetDensidadConversion,
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
                                )!.densidadConversion,
                                widgetName: kWidgetDensidadConversion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.densidadConversion,
                                widgetName: kWidgetDensidadConversion,
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
                        r"1\ \mathrm{g/cm^3} = 1000\ \mathrm{kg/m^3} = 62.428\ \mathrm{lb/pie^3} = 8.3454\ \mathrm{lb/gal\acute{o}n}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{kg/m^3} = 1.0\times10^{-3}\ \mathrm{g/cm^3} = 6.2428\times10^{-2}\ \mathrm{lb/pie^3} = 8.3454\times10^{-3}\ \mathrm{lb/gal\acute{o}n}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{lb/pie^3} = 1.6018\times10^{-2}\ \mathrm{g/cm^3} = 16.018\ \mathrm{kg/m^3} = 0.13368\ \mathrm{lb/gal\acute{o}n}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{lb/gal\acute{o}n} = 0.11983\ \mathrm{g/cm^3} = 119.83\ \mathrm{kg/m^3} = 7.4805\ \mathrm{lb/pie^3}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetDensidadConversion),
            const DescargarPDF(url: kWidgetDensidadConversion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
