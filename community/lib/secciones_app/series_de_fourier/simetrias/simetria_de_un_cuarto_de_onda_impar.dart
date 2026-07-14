import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class SimetriaDeUnCuartoDeOndaImpar extends StatefulWidget {
  const SimetriaDeUnCuartoDeOndaImpar({super.key});
  @override
  State<SimetriaDeUnCuartoDeOndaImpar> createState() =>
      _SimetriaDeUnCuartoDeOndaImparState();
}

class _SimetriaDeUnCuartoDeOndaImparState
    extends State<SimetriaDeUnCuartoDeOndaImpar> {
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
                    AppLocalizations.of(context)!.simetriaDeUnCuartoDeOndaImpar,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .simetriaDeUnCuartoDeOndaImpar,
                            widgetName: kWidgetSimetriaDeUnCuartoDeOndaImpar),
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
                                        .simetriaDeUnCuartoDeOndaImpar,
                                    widgetName:
                                        kWidgetSimetriaDeUnCuartoDeOndaImpar),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .simetriaDeUnCuartoDeOndaImpar,
                                    widgetName:
                                        kWidgetSimetriaDeUnCuartoDeOndaImpar),
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
                          AppLocalizations.of(context)!.simetriaCuartoOndaImpar,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"f(t) = -f(-t)"),
                        const SizedBox(height: kEspacioEntreBotones),
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
                                r"f(t) = \sum_{n=1}^{\infty} b_{2n-1}\sin[(2n-1)\omega_0t]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"a_0 = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a_{2n-1} = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"b_{2n-1} = \frac{8}{T}\int_{0}^{T/4}f(t)\sin[(2n-1)\omega_0t]dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSimetriaDeUnCuartoDeOndaImpar,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSimetriaDeUnCuartoDeOndaImpar,
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
