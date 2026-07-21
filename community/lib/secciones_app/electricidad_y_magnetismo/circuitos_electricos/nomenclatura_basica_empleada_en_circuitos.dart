import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class NomenclaturaBasicaEmpleadaEnCircuitos extends StatefulWidget {
  const NomenclaturaBasicaEmpleadaEnCircuitos({super.key});
  @override
  State<NomenclaturaBasicaEmpleadaEnCircuitos> createState() =>
      _NomenclaturaBasicaEmpleadaEnCircuitosState();
}

class _NomenclaturaBasicaEmpleadaEnCircuitosState
    extends State<NomenclaturaBasicaEmpleadaEnCircuitos> {
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
              AppLocalizations.of(context)!.nomenclaturaBasicaCircuitos,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.nomenclaturaBasicaCircuitos,
                    widgetName: kWidgetNomenclaturaBasicaEmpleadaEnCircuitos,
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
                            )!.nomenclaturaBasicaCircuitos,
                            widgetName:
                                kWidgetNomenclaturaBasicaEmpleadaEnCircuitos,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.nomenclaturaBasicaCircuitos,
                            widgetName:
                                kWidgetNomenclaturaBasicaEmpleadaEnCircuitos,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(context, kImagenNomenclaturaBasica1) ??
                      kUrlImagenNomenclaturaBasica1,
                ),
                ZoomImagePersonalizado(
                  urlImagen:
                      getImageUrlById(context, kImagenNomenclaturaBasica2) ??
                      kUrlImagenNomenclaturaBasica2,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetNomenclaturaBasicaEmpleadaEnCircuitos),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetNomenclaturaBasicaEmpleadaEnCircuitos,
            ),
          ],
        ),
      ),
    );
  }
}
