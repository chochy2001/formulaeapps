import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FuenteDeFuerzaElectromotrizFem extends StatefulWidget {
  @override
  State<FuenteDeFuerzaElectromotrizFem> createState() =>
      _FuenteDeFuerzaElectromotrizFemState();
}

class _FuenteDeFuerzaElectromotrizFemState
    extends State<FuenteDeFuerzaElectromotrizFem> {
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
              AppLocalizations.of(context)!.fuenteFuerzaElectromotriz,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .fuenteFuerzaElectromotriz,
                      widgetName: kWidgetFuenteDeFuerzaElectromotriz),
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
                                  .fuenteFuerzaElectromotriz,
                              widgetName: kWidgetFuenteDeFuerzaElectromotriz),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .fuenteFuerzaElectromotriz,
                              widgetName: kWidgetFuenteDeFuerzaElectromotriz),
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
                  AppLocalizations.of(context)!.dispositivoTransformador,
                ),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .dispositivosDiferenciaDePotencial,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenFuenteDeFuerzaElectromotriz) ??
                        kUrlImagenFuenteDeFuerzaElectromotriz),
                const Latex(formulaText: r"\varepsilon \equiv V"),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.fuentesFEM,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context, kImagenFemIdealYReal) ??
                        kUrlImagenFemIdealYReal),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.femAspectosRelevantes,
                ),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.teoriaDeCircuitos,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenFemAspectosRelevantes) ??
                        kUrlImagenFemAspectosRelevantes),
                const Latex(formulaText: r"P = R_{T}i^2 = V _Ti"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"P = (r+R)i^2 = \epsilon i"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i = \frac{\epsilon}{r+R}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.femIdeal,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"i = \frac{\epsilon}{R} = \frac{V}{R}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetFuenteDeFuerzaElectromotriz,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetFuenteDeFuerzaElectromotriz,
            ),
          ],
        ),
      ),
    );
  }
}
