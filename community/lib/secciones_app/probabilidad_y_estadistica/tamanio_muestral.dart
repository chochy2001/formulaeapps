import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TamanioMuestral extends StatefulWidget {
  const TamanioMuestral({super.key});
  @override
  State<TamanioMuestral> createState() => _TamanioMuestralState();
}

class _TamanioMuestralState extends State<TamanioMuestral> {
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
                    AppLocalizations.of(context)!.tamanioMuestral,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title:
                                AppLocalizations.of(context)!.tamanioMuestral,
                            widgetName: kWidgetTamanioMuestral),
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
                                        .tamanioMuestral,
                                    widgetName: kWidgetTamanioMuestral),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .tamanioMuestral,
                                    widgetName: kWidgetTamanioMuestral),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.estimarMediaPoblacional,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"n = \left(\frac{z\cdot \sigma}{E}\right)^2"),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText: r"E=\bar{X}-\mu = z\sigma _{\bar{X}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .estimarProporcionPoblacional,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"n = \left(\frac{z^2 \cdot P\cdot Q}{E^2}\right)"),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"E=p-P=z\sigma_{\bar{P}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetTamanioMuestral,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetTamanioMuestral,
                  ),
                  //Notas
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(
                        color: kColorFondo,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.tamanioMuestral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"z"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.probabilidadOcurrencia,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\sigma"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.desviacionEstandar,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"E"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.errorMuestral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\bar{X}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.mediaMuestral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mu"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.mediaPoblacional,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\sigma_{\bar{X}}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.errorEstandarMedia,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"Q = 1-P"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"p"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.proporcion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\sigma_{\bar{P}}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.errorEstandarProporcion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"P"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .valorProporcionPoblacion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
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
