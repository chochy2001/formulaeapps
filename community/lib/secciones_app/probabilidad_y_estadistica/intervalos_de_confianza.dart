import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class IntervalosDeConfianza extends StatefulWidget {
  const IntervalosDeConfianza({super.key});
  @override
  State<IntervalosDeConfianza> createState() => _IntervalosDeConfianzaState();
}

class _IntervalosDeConfianzaState extends State<IntervalosDeConfianza> {
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
                    AppLocalizations.of(context)!.intervalosDeConfianza,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.intervalosDeConfianza,
                          widgetName: kWidgetIntervalosDeConfianza,
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
                                  )!.intervalosDeConfianza,
                                  widgetName: kWidgetIntervalosDeConfianza,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.intervalosDeConfianza,
                                  widgetName: kWidgetIntervalosDeConfianza,
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
                          AppLocalizations.of(
                            context,
                          )!.intervaloConfianzaMediaPoblacional,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorLimiteInferior,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"\bar{X}-z\sigma_{\bar{X}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorLimiteSuperior,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"\bar{X}+z\sigma_{\bar{X}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.intervaloConfianzaProporcionPoblacional,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorLimiteInferior,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"\bar{P}-z\sigma_{\bar{P}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.valorLimiteSuperior,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"\bar{P}+z\sigma_{\bar{P}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetIntervalosDeConfianza),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetIntervalosDeConfianza),
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
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\bar{X}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.mediaAritmetica,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"z"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.probabilidadOcurrencia,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\sigma_{\bar{X}}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.errorEstandarMedia,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\bar{P}"),
                        TextoEcuaciones(
                          AppLocalizations.of(
                            context,
                          )!.promedioMuestralProporcion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\sigma_{\bar{P}}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.errorEstandarProporcion,
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
