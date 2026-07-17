import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PotenciaConversion extends StatefulWidget {
  const PotenciaConversion({super.key});

  @override
  PotenciaConversionState createState() => PotenciaConversionState();
}

class PotenciaConversionState extends State<PotenciaConversion> {
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
                    AppLocalizations.of(context)!.potenciaConversion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.potenciaConversion,
                        widgetName: kWidgetPotenciaConversion,
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
                                title: AppLocalizations.of(context)!.potenciaConversion,
                                widgetName: kWidgetPotenciaConversion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.potenciaConversion,
                                widgetName: kWidgetPotenciaConversion,
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
                  Latex(formulaText: r"1\ \mathrm{cal/s} = 3.6\ \mathrm{kcal/hr} = 4.184\ \mathrm{W} = 4.184\times10^{-3}\ \mathrm{kW} = 14.276\ \mathrm{Btu/hr} = 5.6108\times10^{-3}\ \mathrm{hp} = 1.1109\times10^{4}\ \mathrm{pie\text{-}lb_f/hr}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{kcal/hr} = 0.27778\ \mathrm{cal/s} = 1.1622\ \mathrm{W} = 1.1622\times10^{-3}\ \mathrm{kW} = 3.9657\ \mathrm{Btu/hr} = 1.5586\times10^{-3}\ \mathrm{hp} = 3086.0\ \mathrm{pie\text{-}lb_f/hr}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{W\ (SI)} = 0.23901\ \mathrm{cal/s} = 0.86042\ \mathrm{kcal/hr} = 1.0\times10^{-3}\ \mathrm{kW} = 3.4121\ \mathrm{Btu/hr} = 1.3410\times10^{-3}\ \mathrm{hp} = 2655.2\ \mathrm{pie\text{-}lb_f/hr}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{kW} = 239.01\ \mathrm{cal/s} = 860.42\ \mathrm{kcal/hr} = 1000\ \mathrm{W} = 3412.1\ \mathrm{Btu/hr} = 1.3410\ \mathrm{hp} = 2.6552\times10^{6}\ \mathrm{pie\text{-}lb_f/hr}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{Btu/hr} = 7.0046\times10^{-2}\ \mathrm{cal/s} = 0.25216\ \mathrm{kcal/hr} = 0.29307\ \mathrm{W} = 2.9307\times10^{-4}\ \mathrm{kW} = 3.9301\times10^{-4}\ \mathrm{hp} = 778.17\ \mathrm{pie\text{-}lb_f/hr}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{hp} = 178.23\ \mathrm{cal/s} = 641.62\ \mathrm{kcal/hr} = 745.70\ \mathrm{W} = 0.74570\ \mathrm{kW} = 2544.4\ \mathrm{Btu/hr} = 1.98\times10^{6}\ \mathrm{pie\text{-}lb_f/hr}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{pie\text{-}lb_f/hr} = 9.0013\times10^{-5}\ \mathrm{cal/s} = 3.2405\times10^{-4}\ \mathrm{kcal/hr} = 3.7662\times10^{-4}\ \mathrm{W} = 3.7662\times10^{-7}\ \mathrm{kW} = 1.2851\times10^{-3}\ \mathrm{Btu/hr} = 5.0505\times10^{-7}\ \mathrm{hp}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPotenciaConversion),
            const DescargarPDF(url: kWidgetPotenciaConversion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
