import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ElementosCapacitorYResistor extends StatefulWidget {
  @override
  State<ElementosCapacitorYResistor> createState() =>
      _ElementosCapacitorYResistorState();
}

class _ElementosCapacitorYResistorState
    extends State<ElementosCapacitorYResistor> {
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
              AppLocalizations.of(context)!.elementosCapacitorResistor,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .elementosCapacitorResistor,
                      widgetName: kWidgetElementosCapacitorYResistor),
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
                                  .elementosCapacitorResistor,
                              widgetName: kWidgetElementosCapacitorYResistor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .elementosCapacitorResistor,
                              widgetName: kWidgetElementosCapacitorYResistor),
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
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenElementosCapacitorYResistor) ??
                        kUrlImagenElementosCapacitorYResistor),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetElementosCapacitorYResistor,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetElementosCapacitorYResistor,
            ),
          ],
        ),
      ),
    );
  }
}
