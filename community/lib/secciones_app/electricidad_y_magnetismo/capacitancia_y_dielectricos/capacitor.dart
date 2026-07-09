import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class Capacitor extends StatefulWidget {
  @override
  State<Capacitor> createState() => _CapacitorState();
}

class _CapacitorState extends State<Capacitor> {
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
            TituloPersonalizado(
              AppLocalizations.of(context)!.capacitor,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.capacitor,
                      widgetName: kWidgetCapacitor),
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
                              title: AppLocalizations.of(context)!.capacitor,
                              widgetName: kWidgetCapacitor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.capacitor,
                              widgetName: kWidgetCapacitor),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unCapacitorEsUnDispositivo,
                ),
                //ZoomImagePersonalizado(urlImagen: kUrlImagenCapacitor1),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context, kImagenCapacitor1) ??
                        kUrlImagenCapacitor1),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unCapacitorEstaCargado,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context, kImagenCapacitor2) ??
                        kUrlImagenCapacitor2),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetCapacitor,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetCapacitor,
            ),
          ],
        ),
      ),
    );
  }
}
