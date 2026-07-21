import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ValoresDeSenoYCoseno extends StatefulWidget {
  const ValoresDeSenoYCoseno({super.key});
  @override
  State<ValoresDeSenoYCoseno> createState() => _ValoresDeSenoYCosenoState();
}

class _ValoresDeSenoYCosenoState extends State<ValoresDeSenoYCoseno> {
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
                    AppLocalizations.of(context)!.valoresDeSenoYCoseno,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.valoresDeSenoYCoseno,
                          widgetName: kWidgetValoresDeSenoYCoseno,
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
                                  )!.valoresDeSenoYCoseno,
                                  widgetName: kWidgetValoresDeSenoYCoseno,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.valoresDeSenoYCoseno,
                                  widgetName: kWidgetValoresDeSenoYCoseno,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin(0) = 0"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\sin \left[(2n\pm 1)\frac{\pi}{2}\right] = -(-1)^n = (-1)^{n+1}",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin(\pi) = 0"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cos\left[(2n\pm 1)\frac{\pi}{2}\right] = 0",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin(2\pi) = 0"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin(-n\pi) = -\sin(n\pi) = 0"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin(n\pi) = 0"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText: r"\cos(-n\pi) = \cos(n\pi) = (-1)^n",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText: r"\sin\left(\frac{\pi}{2}\right) = 1",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\sin\left[(1\pm 4n)\frac{\pi}{2}\right] = 1",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText: r"\sin\left(\frac{3\pi}{2}\right) = -1",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\cos\left[(1\pm 4n)\frac{\pi}{2}\right] = 0",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText: r"\cos\left(\frac{\pi}{2}\right) = 0",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText:
                              r"\sin(t) = \frac{1}{2j}(e^{jt}-e^{-jt})",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r""),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                          formulaText: r"\cos(t) = \frac{1}{2}(e^{jt}+e^{-jt})",
                        ),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos(0) = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"e^{\pm jt} = \cos(t)\pm j\sin(t)"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos(\pi) = -"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos(2n-1)\pi = -1"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos(2\pi) = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin(2n-1)\pi = 0"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos(2n\pi) = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos(1\pm n)\pi = -(-1)^n"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetValoresDeSenoYCoseno),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetValoresDeSenoYCoseno),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
