import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FlujoMagnetico extends StatefulWidget {
  @override
  State<FlujoMagnetico> createState() => _FlujoMagneticoState();
}

class _FlujoMagneticoState extends State<FlujoMagnetico> {
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
              AppLocalizations.of(context)!.flujoMagnetico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.flujoMagnetico,
                      widgetName: kWidgetFlujoMagnetico),
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
                              title:
                                  AppLocalizations.of(context)!.flujoMagnetico,
                              widgetName: kWidgetFlujoMagnetico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.flujoMagnetico,
                              widgetName: kWidgetFlujoMagnetico),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.elFlujoDeCampoMagnetico,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\Phi = \iint \vec{B} \cdot d\vec{A}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[\Phi_B]_u = [Wb]"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[Wb] = Weber"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .elFlujoDeCampoMagneticoEsUnaMedida,
                  ),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laIntegralDeSuperficieIndica,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetFlujoMagnetico,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetFlujoMagnetico,
            ),
          ],
        ),
      ),
    );
  }
}
