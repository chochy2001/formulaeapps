import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ConexionEnParaleloResistor extends StatefulWidget {
  const ConexionEnParaleloResistor({super.key});
  @override
  State<ConexionEnParaleloResistor> createState() =>
      _ConexionEnParaleloResistorState();
}

class _ConexionEnParaleloResistorState
    extends State<ConexionEnParaleloResistor> {
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
              AppLocalizations.of(context)!.conexionParaleloResistor,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .conexionParaleloResistor,
                      widgetName: kWidgetConexionEnParaleloResistor),
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
                                  .conexionParaleloResistor,
                              widgetName: kWidgetConexionEnParaleloResistor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .conexionParaleloResistor,
                              widgetName: kWidgetConexionEnParaleloResistor),
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
                            context, kImagenConexionEnParaleloResistor) ??
                        kUrlImagenConexionEnParaleloResistor),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conexionEnParaleloTexto,
                ),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(
                    urlImagen:
                        kUrlImagenConexionEnParaleloCorrienteDiferrenciaDePotencialResistenciaEquivalente),
                const Latex(formulaText: r"i_T = i_1 + i_2 + i_3"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_T=V_1 = V_2 = V_3"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"R_T=\left( \frac{1}{R_1} +\frac{1}{R_2} +\frac{1}{R_3}\right)^{-1}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetConexionEnParaleloResistor,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetConexionEnParaleloResistor,
            ),
          ],
        ),
      ),
    );
  }
}
