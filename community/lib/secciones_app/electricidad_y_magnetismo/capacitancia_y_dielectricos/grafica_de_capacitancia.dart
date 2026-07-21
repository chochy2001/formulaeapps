import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

import '../../../constantes/export_constantes.dart';

class GraficaDeCapacitancia extends StatefulWidget {
  const GraficaDeCapacitancia({super.key});
  @override
  State<GraficaDeCapacitancia> createState() => _GraficaDeCapacitanciaState();
}

class _GraficaDeCapacitanciaState extends State<GraficaDeCapacitancia> {
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
              AppLocalizations.of(context)!.graficaCapacitancia,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.graficaCapacitancia,
                    widgetName: kWidgetGraficaDeCapacitancia,
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
                            )!.graficaCapacitancia,
                            widgetName: kWidgetGraficaDeCapacitancia,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.graficaCapacitancia,
                            widgetName: kWidgetGraficaDeCapacitancia,
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
                  getImageUrlById(context, kImagenGraficaCapacitancia) ??
                  kUrlImagenGraficaCapacitancia,
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetGraficaDeCapacitancia),
            //Descargar PDF
            const DescargarPDF(url: kWidgetGraficaDeCapacitancia),
          ],
        ),
      ),
    );
  }
}
