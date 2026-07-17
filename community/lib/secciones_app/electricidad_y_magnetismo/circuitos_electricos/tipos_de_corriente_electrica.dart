import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class TiposDeCorrienteElectrica extends StatefulWidget {
  const TiposDeCorrienteElectrica({super.key});
  @override
  State<TiposDeCorrienteElectrica> createState() =>
      _TiposDeCorrienteElectricaState();
}

class _TiposDeCorrienteElectricaState extends State<TiposDeCorrienteElectrica> {
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
              AppLocalizations.of(context)!.tiposCorrienteElectrica,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.tiposCorrienteElectrica,
                      widgetName: kWidgetTiposDeCorrienteElectrica),
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
                                  .tiposCorrienteElectrica,
                              widgetName: kWidgetTiposDeCorrienteElectrica),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .tiposCorrienteElectrica,
                              widgetName: kWidgetTiposDeCorrienteElectrica),
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
                  AppLocalizations.of(context)!.corrienteElectricaContinua,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.corrienteElectricaDirecta,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.corrienteElectricaAlterna,
                ),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenTiposDeCorrienteElectrica) ??
                        kUrlImagenTiposDeCorrienteElectrica),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetTiposDeCorrienteElectrica,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetTiposDeCorrienteElectrica,
            ),
          ],
        ),
      ),
    );
  }
}
