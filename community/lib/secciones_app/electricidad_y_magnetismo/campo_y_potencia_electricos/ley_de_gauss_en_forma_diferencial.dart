import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class LeyDeGaussEnFormaDiferencial extends StatefulWidget {
  const LeyDeGaussEnFormaDiferencial({super.key});
  @override
  State<LeyDeGaussEnFormaDiferencial> createState() =>
      _LeyDeGaussEnFormaDiferencialState();
}

class _LeyDeGaussEnFormaDiferencialState
    extends State<LeyDeGaussEnFormaDiferencial> {
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
              AppLocalizations.of(context)!.leyGaussFormaDiferencial,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .leyGaussFormaDiferencial,
                      widgetName: kWidgetLeyDeGaussEnFormaDiferencial),
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
                                  .leyGaussFormaDiferencial,
                              widgetName: kWidgetLeyDeGaussEnFormaDiferencial),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyGaussFormaDiferencial,
                              widgetName: kWidgetLeyDeGaussEnFormaDiferencial),
                        );
                      }
                    });
                  },
                );
              },
            ),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyGaussFormaIntegral,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\oiint \vec{E} \cdot d\vec{A} = \frac{q_{enc}}{\epsilon _0}"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .teoremaDivergenciaDensidadVolumetricaCarga,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\iint \vec{F} \cdot \widehat{n}dS = \iiint \vec{\nabla} \cdot \vec{F} dV'"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\rho = \frac{dq}{dV'} \Rightarrow q = \iiint \rho dV'"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\oiint \vec{E} \cdot d \vec{A} = \iiint \vec{\nabla} \cdot \vec{E} dV'"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\frac{q}{\varepsilon _0} = \frac{1}{\varepsilon _0}\iiint \rho dV'"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyGaussFormaDiferencial,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\iiint \vec{\nabla} \cdot \vec{E} dV' =\iiint \frac{1}{\varepsilon _0} \rho dV'"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\vec{\nabla} \cdot \vec{E} = \frac{\rho}{\varepsilon _0}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyGaussPrimeraLeyMaxwell,
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyDeGaussEnFormaDiferencial,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyDeGaussEnFormaDiferencial,
            ),
          ],
        ),
      ),
    );
  }
}
