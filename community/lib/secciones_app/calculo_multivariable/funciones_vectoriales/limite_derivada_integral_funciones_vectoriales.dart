import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class LimiteDerivadaIntegralFuncionesVectoriales extends StatefulWidget {
  @override
  _LimiteDerivadaIntegralFuncionesVectorialesState createState() =>
      _LimiteDerivadaIntegralFuncionesVectorialesState();
}

class _LimiteDerivadaIntegralFuncionesVectorialesState
    extends State<LimiteDerivadaIntegralFuncionesVectoriales> {
  bool seleccionadoMostrar = true;

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
              AppLocalizations.of(context)!
                  .limitesDerivadasIntegralesFuncionesVectoriales,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .limitesDerivadasIntegralesFuncionesVectoriales,
                      widgetName:
                          kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
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
                                  .limitesDerivadasIntegralesFuncionesVectoriales,
                              widgetName:
                                  kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .limitesDerivadasIntegralesFuncionesVectoriales,
                              widgetName:
                                  kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 40.0,
            ),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.sea,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText: r"\vec{R}(t) = f(t)\hat{i} +g(t) \hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unaFuncionVectorial,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.limite,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\lim_{t \to t_1}\vec{R}(t) = \left[\lim_{t \to t_1} f(t)\right]\hat{i}+\left[\lim_{t \to t_1} g(t)\right]\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.derivada,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\vec{R}'(t) = \lim_{t \to 0}\frac{\vec{R}(t+\Delta t)-\vec{R}(t)}{\Delta t}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText: r"\vec{R}'(t) = f'(t)\hat{i}+g'(t)\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.integral,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\int_a^b \vec{R}(t)dt = \left[\int_a^b f(t)dt\right]\hat{i}+\left[\int_a^b g(t)dt\right]\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLimiteDerivadaIntegralFuncionesVectoriales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLimiteDerivadaIntegralFuncionesVectoriales,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
