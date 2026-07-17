import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FuncionUnitariaDeHeaviside extends StatefulWidget {
  const FuncionUnitariaDeHeaviside({super.key});
  @override
  State<FuncionUnitariaDeHeaviside> createState() =>
      _FuncionUnitariaDeHeavisideState();
}

class _FuncionUnitariaDeHeavisideState
    extends State<FuncionUnitariaDeHeaviside> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.funcionUnitariaDeHeaviside,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .funcionUnitariaDeHeaviside,
                            widgetName: kWidgetFuncionUnitariaDeHeaviside),
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
                                        .funcionUnitariaDeHeaviside,
                                    widgetName:
                                        kWidgetFuncionUnitariaDeHeaviside),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .funcionUnitariaDeHeaviside,
                                    widgetName:
                                        kWidgetFuncionUnitariaDeHeaviside),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"u(t) = \left\{\begin{aligned}1 \space\space\space\space & \mathsf{Si\space}a\\0 \space\space\space\space & \mathsf{Si\space}b\end{aligned}\right."),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a\rightarrow t > 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"b\rightarrow t < 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.funcionNoDefinidaEn,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"t = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetFuncionUnitariaDeHeaviside,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetFuncionUnitariaDeHeaviside,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
