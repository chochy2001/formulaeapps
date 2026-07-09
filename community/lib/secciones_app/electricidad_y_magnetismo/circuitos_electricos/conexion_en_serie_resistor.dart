import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

import '../../../constantes/export_constantes.dart';

class ConexionEnSerieResistor extends StatefulWidget {
  @override
  State<ConexionEnSerieResistor> createState() =>
      _ConexionEnSerieResistorState();
}

class _ConexionEnSerieResistorState extends State<ConexionEnSerieResistor> {
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
              AppLocalizations.of(context)!.conexionSerieResistor,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.conexionSerieResistor,
                      widgetName: kWidgetConexionEnSerieResistor),
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
                                  .conexionSerieResistor,
                              widgetName: kWidgetConexionEnSerieResistor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .conexionSerieResistor,
                              widgetName: kWidgetConexionEnSerieResistor),
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
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenConexionEnSerieResistor) ??
                        kUrlImagenConexionEnSerieResistor),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conexionEnSerieTexto,
                ),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(
                    urlImagen:
                        kUrlImagenConexionEnSerieCorrienteDiferenciaDePotencialYResistenciaEquivalente),
                const Latex(formulaText: r"i_T = i_1 = i_2 = i_3"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_T=V_1 + V_2 + V_3"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"R_T=R_1 + R_2 + R_3"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetConexionEnSerieResistor,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetConexionEnSerieResistor,
            ),
          ],
        ),
      ),
    );
  }
}
