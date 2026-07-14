import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class SimetriaDeUnCuartoDeOndaPar extends StatefulWidget {
  const SimetriaDeUnCuartoDeOndaPar({super.key});
  @override
  State<SimetriaDeUnCuartoDeOndaPar> createState() =>
      _SimetriaDeUnCuartoDeOndaParState();
}

class _SimetriaDeUnCuartoDeOndaParState
    extends State<SimetriaDeUnCuartoDeOndaPar> {
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
                    AppLocalizations.of(context)!.simetriaDeUnCuartoDeOndaPar,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .simetriaDeUnCuartoDeOndaPar,
                            widgetName: kWidgetSimetriaDeUnCuartoDeOndaPar),
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
                                        .simetriaDeUnCuartoDeOndaPar,
                                    widgetName:
                                        kWidgetSimetriaDeUnCuartoDeOndaPar),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .simetriaDeUnCuartoDeOndaPar,
                                    widgetName:
                                        kWidgetSimetriaDeUnCuartoDeOndaPar),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simetriaCuartoOndaPar,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"f(t) = f(-t)"),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"f(t) = -f\left(t+\frac{T}{2}\right)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"f(t) = \sum_{n=1}^{\infty} a_{2n-1}\cos[(2n-1)\omega_0t]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"a_0 = 0"),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"a_{2n-1} = \frac{8}{T}\int_{0}^{T/4}f(t)\cos[(2n-1)\omega_0t]dt"),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"b_{2n-1} = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSimetriaDeUnCuartoDeOndaPar,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSimetriaDeUnCuartoDeOndaPar,
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
