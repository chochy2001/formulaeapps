import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class EnergiaConversion extends StatefulWidget {
  const EnergiaConversion({super.key});

  @override
  EnergiaConversionState createState() => EnergiaConversionState();
}

class EnergiaConversionState extends State<EnergiaConversion> {
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
                    AppLocalizations.of(context)!.energiaConversion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.energiaConversion,
                        widgetName: kWidgetEnergiaConversion,
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
                                title: AppLocalizations.of(context)!.energiaConversion,
                                widgetName: kWidgetEnergiaConversion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.energiaConversion,
                                widgetName: kWidgetEnergiaConversion,
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
                  Latex(formulaText: r"1\ \mathrm{J\ (SI)} = 0.23901\ \mathrm{cal} = 2.3901\times10^{-4}\ \mathrm{kcal} = 9.4782\times10^{-4}\ \mathrm{Btu} = 2.7778\times10^{-7}\ \mathrm{kW\text{-}hr} = 3.7251\times10^{-7}\ \mathrm{hp\text{-}hr} = 0.73756\ \mathrm{pie\text{-}lb_f} = 9.8692\times10^{-3}\ \mathrm{litro\text{-}atm}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{cal} = 4.184\ \mathrm{J} = 1.0\times10^{-3}\ \mathrm{kcal} = 3.9657\times10^{-3}\ \mathrm{Btu} = 1.1622\times10^{-6}\ \mathrm{kW\text{-}hr} = 1.5586\times10^{-6}\ \mathrm{hp\text{-}hr} = 3.0860\ \mathrm{pie\text{-}lb_f} = 4.1293\times10^{-2}\ \mathrm{litro\text{-}atm}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{kcal} = 4.184\times10^{3}\ \mathrm{J} = 1000\ \mathrm{cal} = 3.9657\ \mathrm{Btu} = 1.1622\times10^{-3}\ \mathrm{kW\text{-}hr} = 1.5586\times10^{-3}\ \mathrm{hp\text{-}hr} = 3086.0\ \mathrm{pie\text{-}lb_f} = 41.293\ \mathrm{litro\text{-}atm}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{Btu} = 1055.1\ \mathrm{J} = 252.16\ \mathrm{cal} = 0.25216\ \mathrm{kcal} = 2.9307\times10^{-4}\ \mathrm{kW\text{-}hr} = 3.9301\times10^{-4}\ \mathrm{hp\text{-}hr} = 778.17\ \mathrm{pie\text{-}lb_f} = 10.413\ \mathrm{litro\text{-}atm}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{kW\text{-}hr} = 3.6\times10^{6}\ \mathrm{J} = 8.6042\times10^{5}\ \mathrm{cal} = 860.42\ \mathrm{kcal} = 3412.1\ \mathrm{Btu} = 1.3410\ \mathrm{hp\text{-}hr} = 2.6552\times10^{6}\ \mathrm{pie\text{-}lb_f} = 3.5529\times10^{4}\ \mathrm{litro\text{-}atm}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{hp\text{-}hr} = 2.6845\times10^{6}\ \mathrm{J} = 6.4162\times10^{5}\ \mathrm{cal} = 641.62\ \mathrm{kcal} = 2544.3\ \mathrm{Btu} = 0.74570\ \mathrm{kW\text{-}hr} = 1.98\times10^{6}\ \mathrm{pie\text{-}lb_f} = 2.6494\times10^{4}\ \mathrm{litro\text{-}atm}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{pie\text{-}lb_f} = 1.3558\ \mathrm{J} = 0.32405\ \mathrm{cal} = 3.2405\times10^{-4}\ \mathrm{kcal} = 1.2851\times10^{-3}\ \mathrm{Btu} = 3.7662\times10^{-7}\ \mathrm{kW\text{-}hr} = 5.0505\times10^{-7}\ \mathrm{hp\text{-}hr} = 1.3381\times10^{-2}\ \mathrm{litro\text{-}atm}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"1\ \mathrm{litro\text{-}atm} = 101.33\ \mathrm{J} = 24.217\ \mathrm{cal} = 2.4217\times10^{-2}\ \mathrm{kcal} = 9.6038\times10^{-2}\ \mathrm{Btu} = 2.8146\times10^{-5}\ \mathrm{kW\text{-}hr} = 3.7744\times10^{-5}\ \mathrm{hp\text{-}hr} = 74.733\ \mathrm{pie\text{-}lb_f}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetEnergiaConversion),
            const DescargarPDF(url: kWidgetEnergiaConversion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
