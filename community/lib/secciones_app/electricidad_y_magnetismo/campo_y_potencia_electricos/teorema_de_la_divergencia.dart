import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TeoremaDeLaDivergencia extends StatefulWidget {
  @override
  State<TeoremaDeLaDivergencia> createState() => _TeoremaDeLaDivergenciaState();
}

class _TeoremaDeLaDivergenciaState extends State<TeoremaDeLaDivergencia> {
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
              AppLocalizations.of(context)!.teoremaDivergencia,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.teoremaDivergencia,
                      widgetName: kWidgetTeoremaDeLaDivergencia),
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
                                  .teoremaDivergencia,
                              widgetName: kWidgetTeoremaDeLaDivergencia),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .teoremaDivergencia,
                              widgetName: kWidgetTeoremaDeLaDivergencia),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const Column(
              children: <Widget>[
                ZoomImagePersonalizado(
                    urlImagen: kUrlImagenTeoremaDeLaDivergencia),
                Latex(
                    formulaText:
                        r"\iint \vec{F} \cdot \hat{n} dS = \iiint \vec{\nabla} \cdot \vec{F} dV"),
                SizedBox(height: 20.0),
                Latex(
                    formulaText:
                        r"\vec{\nabla} \cdot \vec{F} = \frac{\partial F_x}{\partial x} + \frac{\partial F_y}{\partial y} + \frac{\partial F_z}{\partial z}"),
                SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetTeoremaDeLaDivergencia,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetTeoremaDeLaDivergencia,
            ),
          ],
        ),
      ),
    );
  }
}
