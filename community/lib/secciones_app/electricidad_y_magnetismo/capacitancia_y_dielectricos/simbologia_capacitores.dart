import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

import '../../../constantes/export_constantes.dart';

class SimbologiaCapacitores extends StatefulWidget {
  const SimbologiaCapacitores({super.key});
  @override
  State<SimbologiaCapacitores> createState() => _SimbologiaCapacitoresState();
}

class _SimbologiaCapacitoresState extends State<SimbologiaCapacitores> {
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
            TituloPersonalizado(
              AppLocalizations.of(context)!.simbologiaCapacitores,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.simbologiaCapacitores,
                    widgetName: kWidgetSimbologiaCapacitores,
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
                            )!.simbologiaCapacitores,
                            widgetName: kWidgetSimbologiaCapacitores,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.simbologiaCapacitores,
                            widgetName: kWidgetSimbologiaCapacitores,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            ZoomImagePersonalizado(
              urlImagen:
                  getImageUrlById(context, kImagenSimbologiaCapacitores) ??
                  kUrlImagenSimbologiaCapacitores,
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetSimbologiaCapacitores),
            //Descargar PDF
            const DescargarPDF(url: kWidgetSimbologiaCapacitores),
          ],
        ),
      ),
    );
  }
}
