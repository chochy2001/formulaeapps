import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FuncionesTrigonometricasDeAngulosNotables extends StatefulWidget {
  @override
  _FuncionesTrigonometricasDeAngulosNotablesState createState() =>
      _FuncionesTrigonometricasDeAngulosNotablesState();
}

class _FuncionesTrigonometricasDeAngulosNotablesState
    extends State<FuncionesTrigonometricasDeAngulosNotables> {
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
                    AppLocalizations.of(context)!
                        .funcionesTrigonometricasDeAngulosNotables,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .funcionesTrigonometricasDeAngulosNotables,
                            widgetName:
                                kWidgetFuncionesTrigonometricasDeAngulosNotables),
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
                                        .funcionesTrigonometricasDeAngulosNotables,
                                    widgetName:
                                        kWidgetFuncionesTrigonometricasDeAngulosNotables),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .funcionesTrigonometricasDeAngulosNotables,
                                    widgetName:
                                        kWidgetFuncionesTrigonometricasDeAngulosNotables),
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
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const ZoomImagePersonalizado(
                          urlImagen:
                              kUrlImagenFuncionesTrigonometricasDeAngulosNotables),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetFuncionesTrigonometricasDeAngulosNotables,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetFuncionesTrigonometricasDeAngulosNotables,
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
