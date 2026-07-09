import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class CirculacionDelCampoElectrostatico extends StatefulWidget {
  const CirculacionDelCampoElectrostatico({Key? key}) : super(key: key);

  @override
  State<CirculacionDelCampoElectrostatico> createState() =>
      _CirculacionDelCampoElectrostaticoState();
}

class _CirculacionDelCampoElectrostaticoState
    extends State<CirculacionDelCampoElectrostatico> {
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
              AppLocalizations.of(context)!.circulacionCampoElectrostatico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .circulacionCampoElectrostatico,
                      widgetName: kWidgetCirculacionDelCampoElectrostatico),
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
                                  .circulacionCampoElectrostatico,
                              widgetName:
                                  kWidgetCirculacionDelCampoElectrostatico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .circulacionCampoElectrostatico,
                              widgetName:
                                  kWidgetCirculacionDelCampoElectrostatico),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCirculacionParaUnaCargaPuntual),
                const Latex(
                    formulaText:
                        r"c_e = \oint \vec{E} \cdot d\vec{l} = \oint k \frac{q}{r^2}\hat{r}\cdot d\vec{l}= kq \oint \frac{dr}{r^2}"),
                const SizedBox(height: 40.0),
                const Latex(
                    formulaText:
                        r"c_e = \lim_{r\rightarrow r'}kq \int_{r}^{r'} \frac{dr}{r^2}=0"),
                const SizedBox(height: 60.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .circulacionCampoElectrostaticoCero,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"c_e = \oint \vec{E}\cdot d\vec{l}=0"),
                const SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetCirculacionDelCampoElectrostatico,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetCirculacionDelCampoElectrostatico,
            ),
          ],
        ),
      ),
    );
  }
}
