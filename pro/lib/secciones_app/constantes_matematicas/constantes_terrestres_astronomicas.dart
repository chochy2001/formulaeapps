import 'package:flutter/material.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class ConstantesTerrestresAstronomicas extends StatefulWidget {
  const ConstantesTerrestresAstronomicas({super.key});

  @override
  ConstantesTerrestresAstronomicasState createState() => ConstantesTerrestresAstronomicasState();
}

class ConstantesTerrestresAstronomicasState extends State<ConstantesTerrestresAstronomicas> {
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
                    AppLocalizations.of(context)!.constantesTerrestresAstronomicas,
                  ),
                ),
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                        title: AppLocalizations.of(context)!.constantesTerrestresAstronomicas,
                        widgetName: kWidgetConstantesTerrestresAstronomicas,
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
                                title: AppLocalizations.of(context)!.constantesTerrestresAstronomicas,
                                widgetName: kWidgetConstantesTerrestresAstronomicas,
                              ),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                title: AppLocalizations.of(context)!.constantesTerrestresAstronomicas,
                                widgetName: kWidgetConstantesTerrestresAstronomicas,
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
                  Latex(formulaText: r"g = 9.8\ \mathrm{m/s^2} = 32\ \mathrm{ft/s^2}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"R_T = 6.37 \times 10^{6}\ \mathrm{m}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"M_T = 5.976 \times 10^{24}\ \mathrm{kg}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"M_L = 7.36 \times 10^{22}\ \mathrm{kg}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\rho_{\text{agua}} = 1\ \mathrm{g/cm^3} = 62.4\ \mathrm{lb/pie^3}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\rho_{\text{aire}} = 1.293\ \mathrm{g/L}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"v_{\text{sonido}} = 340.292\ \mathrm{m/s}"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(height: kEspacioEntreBotones),
            const VerPDF(url: kWidgetConstantesTerrestresAstronomicas),
            const DescargarPDF(url: kWidgetConstantesTerrestresAstronomicas),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
