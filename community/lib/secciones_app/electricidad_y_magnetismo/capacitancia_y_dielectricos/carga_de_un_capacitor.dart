import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class CargaDeUnCapacitor extends StatefulWidget {
  const CargaDeUnCapacitor({super.key});
  @override
  State<CargaDeUnCapacitor> createState() => _CargaDeUnCapacitorState();
}

class _CargaDeUnCapacitorState extends State<CargaDeUnCapacitor> {
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
            TituloPersonalizado(AppLocalizations.of(context)!.cargaCapacitor),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.cargaCapacitor,
                    widgetName: kWidgetCargaDeUnCapacitor,
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
                            title: AppLocalizations.of(context)!.cargaCapacitor,
                            widgetName: kWidgetCargaDeUnCapacitor,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.cargaCapacitor,
                            widgetName: kWidgetCargaDeUnCapacitor,
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
                TextoEcuaciones(
                  AppLocalizations.of(context)!.paraCargarUnCapacitor,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenCargaDeUnCapacitor,
                ),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetCargaDeUnCapacitor),
            //Descargar PDF
            const DescargarPDF(url: kWidgetCargaDeUnCapacitor),
          ],
        ),
      ),
    );
  }
}
