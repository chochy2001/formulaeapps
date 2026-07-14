import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class DistanciaDeUnPuntoAUnaRecta extends StatefulWidget {
  const DistanciaDeUnPuntoAUnaRecta({super.key});
  @override
  State<DistanciaDeUnPuntoAUnaRecta> createState() =>
      _DistanciaDeUnPuntoAUnaRectaState();
}

class _DistanciaDeUnPuntoAUnaRectaState
    extends State<DistanciaDeUnPuntoAUnaRecta> {
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
                    AppLocalizations.of(context)!.distanciaDeUnPuntoAUnaRecta,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .distanciaDeUnPuntoAUnaRecta,
                            widgetName: kWidgetDistanciaDeUnPuntoAUnaRecta),
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
                                        .distanciaDeUnPuntoAUnaRecta,
                                    widgetName:
                                        kWidgetDistanciaDeUnPuntoAUnaRecta),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .distanciaDeUnPuntoAUnaRecta,
                                    widgetName:
                                        kWidgetDistanciaDeUnPuntoAUnaRecta),
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
                          AppLocalizations.of(context)!.ecuacionRecta,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"Ax+By = C"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.punto,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"P(x_0,y_0)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.distanciaPuntoPRecta,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"d = \frac{|Ax_0+By_0+C|}{\sqrt{A^2+B^2}}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetDistanciaDeUnPuntoAUnaRecta,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetDistanciaDeUnPuntoAUnaRecta,
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
