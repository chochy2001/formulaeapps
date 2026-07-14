import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class CirculacionDeUnCampoVectorial extends StatefulWidget {
  const CirculacionDeUnCampoVectorial({super.key});
  @override
  State<CirculacionDeUnCampoVectorial> createState() =>
      _CirculacionDeUnCampoVectorialState();
}

class _CirculacionDeUnCampoVectorialState
    extends State<CirculacionDeUnCampoVectorial> {
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
              AppLocalizations.of(context)!.circulacionDeUnCampoVectorial,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .circulacionDeUnCampoVectorial,
                      widgetName: kWidgetCirculacionDeUnCampoVectorial),
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
                                  .circulacionDeUnCampoVectorial,
                              widgetName: kWidgetCirculacionDeUnCampoVectorial),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .circulacionDeUnCampoVectorial,
                              widgetName: kWidgetCirculacionDeUnCampoVectorial),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.circulacionDelCampoElectrico,
                ),
                const Latex(
                    formulaText: r"C_e = \oint \vec{E} \cdot d \vec{l} = 0"),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.circulacionDelCampoMagnetico,
                ),
                const Latex(
                    formulaText: r"C_b = \oint \vec{B} \cdot d \vec{l} \neq 0"),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enElCasoDeUnConductorRecto,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"C_b = \oint \vec{B} \cdot d \vec{l} = B2\pi r"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\oint \vec{B} \cdot d \vec{l} = \frac{\mu _0 i}{2\pi r}2\pi r"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\oint \vec{B} \cdot d \vec{l} = \mu _0 i"),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCirculacionDeUnCampoVectorial),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeAmpere,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetCirculacionDeUnCampoVectorial,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetCirculacionDeUnCampoVectorial,
            ),
          ],
        ),
      ),
    );
  }
}
