import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class PortadoresDeCargaLibre extends StatefulWidget {
  const PortadoresDeCargaLibre({super.key});
  @override
  State<PortadoresDeCargaLibre> createState() => _PortadoresDeCargaLibreState();
}

class _PortadoresDeCargaLibreState extends State<PortadoresDeCargaLibre> {
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
              AppLocalizations.of(context)!.portadoresCargaLibre,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.portadoresCargaLibre,
                      widgetName: kWidgetPortadoresDeCargaLibre),
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
                                  .portadoresCargaLibre,
                              widgetName: kWidgetPortadoresDeCargaLibre),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .portadoresCargaLibre,
                              widgetName: kWidgetPortadoresDeCargaLibre),
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
                  AppLocalizations.of(context)!.portadorDeCargaLibre,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenPortadoresDeCargaLibre) ??
                        kUrlImagenPortadoresDeCargaLibre),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .laPresenciaDeLaDiferenciaDePotencial,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetPortadoresDeCargaLibre,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetPortadoresDeCargaLibre,
            ),
          ],
        ),
      ),
    );
  }
}
