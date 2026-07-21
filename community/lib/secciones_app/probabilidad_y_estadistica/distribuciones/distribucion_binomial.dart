import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class DistribucionBinomial extends StatefulWidget {
  const DistribucionBinomial({super.key});
  @override
  State<DistribucionBinomial> createState() => _DistribucionBinomialState();
}

class _DistribucionBinomialState extends State<DistribucionBinomial> {
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
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.distribucionBinomial,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.distribucionBinomial,
                          widgetName: kWidgetDistribucionBinomial,
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
                                  )!.distribucionBinomial,
                                  widgetName: kWidgetDistribucionBinomial,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.distribucionBinomial,
                                  widgetName: kWidgetDistribucionBinomial,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.distribucionBinomial,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                          formulaText: r"P(x)= \frac{n!}{x!(n-x)!}p^xq^{n-x}",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"q=1-p"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorEsperado,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"np"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(AppLocalizations.of(context)!.varianza),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"npq"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetDistribucionBinomial),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetDistribucionBinomial),
                  //Notas
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(color: kColorFondo, width: 8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        ZoomPersonalizado(
                          child: Column(
                            children: [
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"n"),
                              TextoEcuaciones(
                                AppLocalizations.of(
                                  context,
                                )!.numeroExperimentos,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"x"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.numeroExitos,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"p"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.probabilidadExito,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"q"),
                              TextoEcuaciones(
                                AppLocalizations.of(
                                  context,
                                )!.probabilidadFracaso,
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
          ],
        ),
      ),
    );
  }
}
