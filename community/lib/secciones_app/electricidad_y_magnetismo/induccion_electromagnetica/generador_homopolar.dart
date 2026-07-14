import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class GeneradorHomopolar extends StatefulWidget {
  const GeneradorHomopolar({super.key});
  @override
  State<GeneradorHomopolar> createState() => _GeneradorHomopolarState();
}

class _GeneradorHomopolarState extends State<GeneradorHomopolar> {
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
              AppLocalizations.of(context)!.generadorHomopolar,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.generadorHomopolar,
                      widgetName:
                          kWidgetPrincipioDeOperacionDelGeneradorElectrico),
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
                                  .generadorHomopolar,
                              widgetName:
                                  kWidgetPrincipioDeOperacionDelGeneradorElectrico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .generadorHomopolar,
                              widgetName:
                                  kWidgetPrincipioDeOperacionDelGeneradorElectrico),
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
                  AppLocalizations.of(context)!.generador,
                ),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenGeneradorHomopolar1),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenGeneradorHomopolar2),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elMovimientoDeRotacionGenera,
                ),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.femInducidaEnElConductor,
                ),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"|\varepsilon _i| = Blv"),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.paraElConductorGirando,
                ),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"d\varepsilon = Bv_Tdr"),
                const SizedBox(height: 30.0),
                const Latex(
                    formulaText:
                        r"\varepsilon = \int Bv_Tdr = \int_0^R B\omega rdr"),
                const SizedBox(height: 30.0),
                const Latex(
                    formulaText: r"\varepsilon = B\omega \frac{R^2}{2}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetPrincipioDeOperacionDelGeneradorElectrico,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetPrincipioDeOperacionDelGeneradorElectrico,
            ),
          ],
        ),
      ),
    );
  }
}
