import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class GradienteDePotencialElectrico extends StatefulWidget {
  const GradienteDePotencialElectrico({super.key});
  @override
  State<GradienteDePotencialElectrico> createState() =>
      _GradienteDePotencialElectricoState();
}

class _GradienteDePotencialElectricoState
    extends State<GradienteDePotencialElectrico> {
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
              AppLocalizations.of(context)!.gradientePotencialElectrico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.gradientePotencialElectrico,
                    widgetName: kWidgetGradienteDePotencialElectrico,
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
                            )!.gradientePotencialElectrico,
                            widgetName: kWidgetGradienteDePotencialElectrico,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.gradientePotencialElectrico,
                            widgetName: kWidgetGradienteDePotencialElectrico,
                          ),
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
                    AppLocalizations.of(
                      context,
                    )!.diferenciaPotencialCampoElectricoyCampo,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"V_{AB} = - \int_{B}^{A} \vec{E} \cdot d\vec{l}",
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.terminosDiferenciales,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText: r"V_{AB} = \alpha \Rightarrow d\alpha = dV",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\int_{B}^{A} \vec{E} \cdot d\vec{l} = \beta \Rightarrow d\beta = \vec{E} \cdot d\vec{l}",
                  ),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(
                      context,
                    )!.gradientePotencialCampoElectrico,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"dV = -\vec{E} \cdot d\vec{l}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla}V \cdot d\vec{l} = -\vec{E} \cdot d\vec{l}",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{E} = -\vec{\nabla}V"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetGradienteDePotencialElectrico),
            //Descargar PDF
            const DescargarPDF(url: kWidgetGradienteDePotencialElectrico),
          ],
        ),
      ),
    );
  }
}
