import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TransformadaDeLaplace extends StatefulWidget {
  const TransformadaDeLaplace({super.key});
  @override
  State<TransformadaDeLaplace> createState() => _TransformadaDeLaplaceState();
}

class _TransformadaDeLaplaceState extends State<TransformadaDeLaplace> {
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
                    AppLocalizations.of(context)!.transformadaDeLaplace,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(
                            context,
                          )!.transformadaDeLaplace,
                          widgetName: kWidgetTransformadasDeLaplace,
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
                                  )!.transformadaDeLaplace,
                                  widgetName: kWidgetTransformadasDeLaplace,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(
                                    context,
                                  )!.transformadaDeLaplace,
                                  widgetName: kWidgetTransformadasDeLaplace,
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
                          AppLocalizations.of(context)!.transformadaDeLaplace,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                          formulaText:
                              r"\mathcal{L}[f(t)] = F(s) = \int_{0}^{\infty}f(t)e^{-st}dt",
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(url: kWidgetTransformadaDeLaplace),
                  //Descargar PDF
                  const DescargarPDF(url: kWidgetTransformadaDeLaplace),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
