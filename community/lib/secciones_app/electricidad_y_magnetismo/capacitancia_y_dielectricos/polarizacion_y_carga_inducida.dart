import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class PolarizacionYCargaInducida extends StatefulWidget {
  @override
  State<PolarizacionYCargaInducida> createState() =>
      _PolarizacionYCargaInducidaState();
}

class _PolarizacionYCargaInducidaState
    extends State<PolarizacionYCargaInducida> {
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
              AppLocalizations.of(context)!.polarizacionCargaInducida,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .polarizacionCargaInducida,
                      widgetName: kWidgetPolarizacionYCargaInducida),
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
                                  .polarizacionCargaInducida,
                              widgetName: kWidgetPolarizacionYCargaInducida),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .polarizacionCargaInducida,
                              widgetName: kWidgetPolarizacionYCargaInducida),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            const Column(
              children: <Widget>[
                ZoomImagePersonalizado(
                    urlImagen: kUrlImagenPolarizacionDeCargaInucida1),
                SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: kUrlImagenPolarizacionDeCargaInucida2),
                SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: kUrlImagenPolarizacionDeCargaInucida3),
                SizedBox(height: 40.0),
                Latex(
                    formulaText:
                        r"\vec{P} = \frac{\sum_{i = 1}^n\vec{p}i}{V'} = \frac{qd}{V'}\widehat{r} = \frac{\sigma _i Ad}{V'}\widehat{r} = \sigma _i \widehat{r}"),
                SizedBox(height: 40.0),
                Latex(formulaText: r"\left|\vec{P}\right| = \sigma _i"),
                SizedBox(height: 40.0),
                Latex(
                    formulaText:
                        r"\left[\vec{P}\right]_u = \left[ \frac{C}{m^2}\right]"),
                SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetPolarizacionYCargaInducida,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetPolarizacionYCargaInducida,
            ),
          ],
        ),
      ),
    );
  }
}
