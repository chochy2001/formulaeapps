import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FormulaGeneral extends StatefulWidget {
  const FormulaGeneral({super.key});
  @override
  State<FormulaGeneral> createState() => _FormulaGeneralState();
}

class _FormulaGeneralState extends State<FormulaGeneral> {
  bool seleccionadoMostrar = false;
  double catetoOpuesto = 0.0, catetoAdyacente = 0.0, hipotenusa = 0.0;

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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.formulaGeneral,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!.formulaGeneral,
                          widgetName: kWidgetFormulaGeneral,
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
                                  )!.formulaGeneral,
                                  widgetName: kWidgetFormulaGeneral,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.formulaGeneral,
                                  widgetName: kWidgetFormulaGeneral,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width),
                        const Latex(
                          formulaText:
                              r"x = \frac {-b \pm \sqrt {b^2 - 4ac}}{2a}",
                        ),
                        const SizedBox(height: 30),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.caracteristicas,
                        ),
                        const SizedBox(height: 30),
                        TextoEcuaciones(AppLocalizations.of(context)!.si),
                        const Latex(formulaText: r"b^2-4ac=0"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.lasRaicesSonRealesEIguales,
                        ),
                        const SizedBox(height: 30),
                        TextoEcuaciones(AppLocalizations.of(context)!.si),
                        const Latex(formulaText: r"b^2-4ac<0"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.lasRaicesNoSonReales,
                        ),
                        const SizedBox(height: 40),
                        TextoEcuaciones(AppLocalizations.of(context)!.si),
                        const Latex(formulaText: r"b^2-4ac>0"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.lasRaicesSonRealesYDeDiferenteValor,
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetFormulaGeneral),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetFormulaGeneral),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
