import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class IdentidadesTrigonometricasDeSumaYRestaDeAngulos extends StatefulWidget {
  const IdentidadesTrigonometricasDeSumaYRestaDeAngulos({super.key});
  @override
  State<IdentidadesTrigonometricasDeSumaYRestaDeAngulos> createState() =>
      _IdentidadesTrigonometricasDeSumaYRestaDeAngulosState();
}

class _IdentidadesTrigonometricasDeSumaYRestaDeAngulosState
    extends State<IdentidadesTrigonometricasDeSumaYRestaDeAngulos> {
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
                    AppLocalizations.of(context)!.deSumaYRestaDeAngulos,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .deSumaYRestaDeAngulos,
                            widgetName:
                                kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos),
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
                                        .deSumaYRestaDeAngulos,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .deSumaYRestaDeAngulos,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos),
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
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\sin(\alpha+\beta) = \sin\alpha\cos\beta+\cos\alpha\sin\beta"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\cos(\alpha+\beta) = \cos\alpha\cos\beta-\sin\alpha\sin\beta"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\sin(\alpha-\beta) = \sin\alpha\cos\beta-\cos\alpha\sin\beta"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\cos(\alpha-\beta) = \cos\alpha\cos\beta+\sin\alpha\sin\beta"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\tan(\alpha+\beta) = \frac{\tan\alpha+\tan\beta}{1-\tan\alpha\tan\beta}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\tan(\alpha-\beta) = \frac{\tan\alpha-\tan\beta}{1+\tan\alpha\tan\beta}"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
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
