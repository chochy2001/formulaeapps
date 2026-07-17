import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class SimetriaPar extends StatefulWidget {
  const SimetriaPar({super.key});
  @override
  State<SimetriaPar> createState() => _SimetriaParState();
}

class _SimetriaParState extends State<SimetriaPar> {
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
                    AppLocalizations.of(context)!.simetriaPar,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.simetriaPar,
                            widgetName: kWidgetSimetriaPar),
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
                                        .simetriaPar,
                                    widgetName: kWidgetSimetriaPar),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .simetriaPar,
                                    widgetName: kWidgetSimetriaPar),
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
                          AppLocalizations.of(context)!.simetriaPar,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"f(t) = f(-t)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"f(t) = \frac{1}{2}a_0+\sum_{n=1}^{\infty} a_{n}\cos(n\omega_0t)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"b_n = 0"),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"a_0 = \frac{4}{T}\int_{0}^{T/2} f(t)dt"),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"a_n = \frac{4}{T}\int_{0}^{T/2}f(t)\cos(n\omega_0t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSimetriaPar,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSimetriaPar,
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
