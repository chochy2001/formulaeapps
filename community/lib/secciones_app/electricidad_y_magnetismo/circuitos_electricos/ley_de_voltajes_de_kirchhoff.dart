import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class LeyDeVoltajesDeKirchhoff extends StatefulWidget {
  @override
  State<LeyDeVoltajesDeKirchhoff> createState() =>
      _LeyDeVoltajesDeKirchhoffState();
}

class _LeyDeVoltajesDeKirchhoffState extends State<LeyDeVoltajesDeKirchhoff> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
  }


  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            TituloPersonalizado(
              AppLocalizations.of(context)!.leyVoltajesKirchhoff,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.leyVoltajesKirchhoff,
                      widgetName: kWidgetLeyDeVoltajesDeKirchhoff),
                );
                return IconButton(
                  icon: isFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  color: isFavorite ? Colors.white : Colors.white,
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        favoritesNotifier.removeFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyVoltajesKirchhoff,
                              widgetName: kWidgetLeyDeVoltajesDeKirchhoff),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyVoltajesKirchhoff,
                              widgetName: kWidgetLeyDeVoltajesDeKirchhoff),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.sumaAlgebraicaPotencial,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenLeyDeVoltajesDeKirchhoff),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\sum_{k=1}^n V_k = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\epsilon = \sum_{i=1}^n V_i"),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conservacionDeEnergia,
                ),
                const Latex(formulaText: r"V_{AB} = \frac{U_A- U_B}{q}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.energiaTotalCircuito,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\Delta U = 0"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\Delta U_T = \Delta U_1 + \Delta U_2 + \cdots"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyDeVoltajesDeKirchhoff,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyDeVoltajesDeKirchhoff,
            ),
          ],
        ),
      ),
    );
  }
}
