import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class PresionConversion extends StatefulWidget {
  const PresionConversion({super.key});

  @override
  PresionConversionState createState() => PresionConversionState();
}

class PresionConversionState extends State<PresionConversion> {
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
                    AppLocalizations.of(context)!.presionConversion,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.presionConversion,
                        widgetName: kWidgetPresionConversion,
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
                                )!.presionConversion,
                                widgetName: kWidgetPresionConversion,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(
                                  context,
                                )!.presionConversion,
                                widgetName: kWidgetPresionConversion,
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
                        r"1\ \mathrm{dina/cm^2} = 0.1\ \mathrm{N/m^2} = 9.8692\times10^{-7}\ \mathrm{atm} = 1.0197\times10^{-6}\ \mathrm{kg_f/cm^2} = 7.5006\times10^{-4}\ \mathrm{mm\,Hg} = 2.9530\times10^{-5}\ \mathrm{pulg\,Hg} = 1.4504\times10^{-5}\ \mathrm{lb_f/pulg^2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{N/m^2\ (SI)} = 10\ \mathrm{dina/cm^2} = 9.8692\times10^{-6}\ \mathrm{atm} = 1.0197\times10^{-5}\ \mathrm{kg_f/cm^2} = 7.5006\times10^{-3}\ \mathrm{mm\,Hg} = 2.9530\times10^{-4}\ \mathrm{pulg\,Hg} = 1.4504\times10^{-4}\ \mathrm{lb_f/pulg^2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{atm} = 1.0133\times10^{6}\ \mathrm{dina/cm^2} = 1.0133\times10^{5}\ \mathrm{N/m^2} = 1.0332\ \mathrm{kg_f/cm^2} = 760\ \mathrm{mm\,Hg} = 29.921\ \mathrm{pulg\,Hg} = 14.696\ \mathrm{lb_f/pulg^2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{kg_f/cm^2} = 9.8067\times10^{5}\ \mathrm{dina/cm^2} = 9.8067\times10^{4}\ \mathrm{N/m^2} = 0.96784\ \mathrm{atm} = 735.56\ \mathrm{mm\,Hg} = 28.959\ \mathrm{pulg\,Hg} = 14.223\ \mathrm{lb_f/pulg^2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{mm\,Hg} = 1333.2\ \mathrm{dina/cm^2} = 133.32\ \mathrm{N/m^2} = 1.3158\times10^{-3}\ \mathrm{atm} = 1.3595\times10^{-3}\ \mathrm{kg_f/cm^2} = 3.9370\times10^{-2}\ \mathrm{pulg\,Hg} = 1.9337\times10^{-2}\ \mathrm{lb_f/pulg^2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{pulg\,Hg} = 3.3864\times10^{4}\ \mathrm{dina/cm^2} = 3386.4\ \mathrm{N/m^2} = 3.3421\times10^{-2}\ \mathrm{atm} = 3.4532\times10^{-2}\ \mathrm{kg_f/cm^2} = 25.4\ \mathrm{mm\,Hg} = 0.49115\ \mathrm{lb_f/pulg^2}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                    formulaText:
                        r"1\ \mathrm{lb_f/pulg^2} = 6.8948\times10^{4}\ \mathrm{dina/cm^2} = 6894.8\ \mathrm{N/m^2} = 6.8046\times10^{-2}\ \mathrm{atm} = 7.0307\times10^{-2}\ \mathrm{kg_f/cm^2} = 51.715\ \mathrm{mm\,Hg} = 2.0360\ \mathrm{pulg\,Hg}",
                  ),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetPresionConversion),
            const DescargarPDF(url: kWidgetPresionConversion),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
