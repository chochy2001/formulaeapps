import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class VectorDeDesplazamientoElectrico extends StatefulWidget {
  const VectorDeDesplazamientoElectrico({super.key});
  @override
  State<VectorDeDesplazamientoElectrico> createState() =>
      _VectorDeDesplazamientoElectricoState();
}

class _VectorDeDesplazamientoElectricoState
    extends State<VectorDeDesplazamientoElectrico> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
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
              AppLocalizations.of(context)!.vectorDesplazamientoElectrico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.vectorDesplazamientoElectrico,
                    widgetName: kWidgetVectorDeDesplazamientoElectrico,
                  ),
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
                            title: AppLocalizations.of(
                              context,
                            )!.vectorDesplazamientoElectrico,
                            widgetName: kWidgetVectorDeDesplazamientoElectrico,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.vectorDesplazamientoElectrico,
                            widgetName: kWidgetVectorDeDesplazamientoElectrico,
                          ),
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
                    AppLocalizations.of(context)!.paraMaterialesLineales,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{D} = \varepsilon \vec{E}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\vec{D} = \varepsilon \vec{E} = k_e \varepsilon_0 \vec{E}= (1+ \chi_e) \varepsilon_0 \vec{E} + \varepsilon_0 \chi_e \vec{E}",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText: r"\vec{D} = \varepsilon_0 \vec{E} +\vec{P}",
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeGaussGeneralizada,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                    formulaText:
                        r"\oiint \vec{E}\cdot d\vec{A} = \frac{q_{enc}}{\varepsilon_0}",
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                    formulaText:
                        r"\left| \vec{E} \right|= \frac{q_l}{\varepsilon A}",
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                    formulaText:
                        r"\left| \vec{E} \right|= \frac{\sigma_l}{\varepsilon}",
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                    formulaText: r"\oiint \vec{D}\cdot d\vec{A} = q_l",
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                    formulaText:
                        r"\oiint \vec{D}\cdot d\vec{A} = DA = \varepsilon EA",
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"\left| \vec{D} \right|= \sigma_l"),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetVectorDeDesplazamientoElectrico),
            //Descargar PDF
            const DescargarPDF(url: kWidgetVectorDeDesplazamientoElectrico),
          ],
        ),
      ),
    );
  }
}
