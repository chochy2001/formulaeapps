import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class CircuitoRCyVoltajeContinuo extends StatefulWidget {
  const CircuitoRCyVoltajeContinuo({super.key});
  @override
  State<CircuitoRCyVoltajeContinuo> createState() =>
      _CircuitoRCyVoltajeContinuoState();
}

class _CircuitoRCyVoltajeContinuoState
    extends State<CircuitoRCyVoltajeContinuo> {
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
              AppLocalizations.of(context)!.circuitoRCVoltajeContinuo,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.circuitoRCVoltajeContinuo,
                    widgetName: kWidgetCircuitoRCyVoltajeContinuo,
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
                            )!.circuitoRCVoltajeContinuo,
                            widgetName: kWidgetCircuitoRCyVoltajeContinuo,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.circuitoRCVoltajeContinuo,
                            widgetName: kWidgetCircuitoRCyVoltajeContinuo,
                          ),
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
                  urlImagen:
                      getImageUrlById(
                        context,
                        kImagenCircuitoRCYVoltajeContinuo,
                      ) ??
                      kUrlImagenCircuitoRCYVoltajeContinuo,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.alTiempoT0),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.procesoDeCargaEnUnCapacitor,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetCircuitoRCyVoltajeContinuo),
            //Descargar PDF
            const DescargarPDF(url: kWidgetCircuitoRCyVoltajeContinuo),
          ],
        ),
      ),
    );
  }
}
