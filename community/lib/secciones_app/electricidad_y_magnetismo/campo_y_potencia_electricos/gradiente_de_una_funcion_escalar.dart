import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class GradienteDeUnaFuncionEscalar extends StatefulWidget {
  const GradienteDeUnaFuncionEscalar({super.key});
  @override
  State<GradienteDeUnaFuncionEscalar> createState() =>
      _GradienteDeUnaFuncionEscalarState();
}

class _GradienteDeUnaFuncionEscalarState
    extends State<GradienteDeUnaFuncionEscalar> {
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
              AppLocalizations.of(context)!.gradienteFuncionEscalar,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.gradienteFuncionEscalar,
                    widgetName: kWidgetGradienteDeUnaFuncionEscalar,
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
                            )!.gradienteFuncionEscalar,
                            widgetName: kWidgetGradienteDeUnaFuncionEscalar,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.gradienteFuncionEscalar,
                            widgetName: kWidgetGradienteDeUnaFuncionEscalar,
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
                    )!.campoElectrostaticoConservativo,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{\nabla} \times \vec{E} = 0"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.rotacionalGradiente,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"\vec{\nabla} \times \vec{\nabla}\varphi = \left(-\vec{\nabla}\varphi\right) = 0",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.campoElectricoGradiente,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{E} = -\vec{\nabla}\varphi"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetGradienteDeUnaFuncionEscalar),
            //Descargar PDF
            const DescargarPDF(url: kWidgetGradienteDeUnaFuncionEscalar),
          ],
        ),
      ),
    );
  }
}
