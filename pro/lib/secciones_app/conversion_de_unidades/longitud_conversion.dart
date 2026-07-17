import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class LongitudConversion extends StatefulWidget {
  const LongitudConversion({super.key});

  @override
  LongitudConversionState createState() => LongitudConversionState();
}

class LongitudConversionState extends State<LongitudConversion> {
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
                    AppLocalizations.of(context)!.longitudConversion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.longitudConversion,
                        widgetName: kWidgetLongitudConversion,
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
                                title: AppLocalizations.of(context)!.longitudConversion,
                                widgetName: kWidgetLongitudConversion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.longitudConversion,
                                widgetName: kWidgetLongitudConversion,
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
                  Latex(formulaText: r"1\ \text{cm} = 0.01\ \text{m} = 0.39370\ \text{pulg} = 0.032808\ \text{pie} = 0.010936\ \text{yd} = 6.2137\times10^{-6}\ \text{milla}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{m} = 100\ \text{cm} = 39.370\ \text{pulg} = 3.2808\ \text{pie} = 1.0936\ \text{yd} = 6.2137\times10^{-4}\ \text{milla}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{pulg} = 2.54\ \text{cm} = 0.0254\ \text{m} = 0.083333\ \text{pie} = 0.027778\ \text{yd} = 1.5783\times10^{-5}\ \text{milla}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{pie} = 30.48\ \text{cm} = 0.3048\ \text{m} = 12\ \text{pulg} = 0.33333\ \text{yd} = 1.8939\times10^{-4}\ \text{milla}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{yd} = 91.44\ \text{cm} = 0.9144\ \text{m} = 36\ \text{pulg} = 3\ \text{pie} = 5.6818\times10^{-4}\ \text{milla}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \text{milla} = 1.6093\times10^{5}\ \text{cm} = 1.6093\times10^{3}\ \text{m} = 6.336\times10^{4}\ \text{pulg} = 5280\ \text{pie} = 1760\ \text{yd}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetLongitudConversion),
            const DescargarPDF(url: kWidgetLongitudConversion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
