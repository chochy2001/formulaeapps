import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class SerieYCoeficientesDeFourier extends StatefulWidget {
  const SerieYCoeficientesDeFourier({super.key});
  @override
  State<SerieYCoeficientesDeFourier> createState() =>
      _SerieYCoeficientesDeFourierState();
}

class _SerieYCoeficientesDeFourierState
    extends State<SerieYCoeficientesDeFourier> {
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
                    AppLocalizations.of(context)!.serieYCoeficientesDeFourier,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .serieYCoeficientesDeFourier,
                            widgetName: kWidgetSerieYCoeficientesDeFourier),
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
                                        .serieYCoeficientesDeFourier,
                                    widgetName:
                                        kWidgetSerieYCoeficientesDeFourier),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .serieYCoeficientesDeFourier,
                                    widgetName:
                                        kWidgetSerieYCoeficientesDeFourier),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieFourier,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"f(t) = \frac{1}{2}a_0+\sum_{n=1}^{\infty}[a_n\cos(n\omega_0t)+b_n\sin(n\omega_0t)]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.donde,
                        ),
                        const Latex(formulaText: r"\omega_0 = \frac{2\pi}{T}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieFourier,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a_0 = \frac{2}{T}\int_{-T/2}^{T/2}f(t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a_n = \frac{2}{T}\int_{-T/2}^{T/2}f(t)\cos(n\omega_0t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.para,
                        ),
                        const Latex(formulaText: r"n = 0,1,2\cdots"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"b_n = \frac{2}{T}\int_{-T/2}^{T/2}f(t)\sin(n\omega_0t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.para,
                        ),
                        const Latex(formulaText: r"n = 1,2,3\cdots"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSerieYCoeficientesDeFourier,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSerieYCoeficientesDeFourier,
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
