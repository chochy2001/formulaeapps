import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class Inductor extends StatefulWidget {
  const Inductor({super.key});
  @override
  State<Inductor> createState() => _InductorState();
}

class _InductorState extends State<Inductor> {
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
            TituloPersonalizado(AppLocalizations.of(context)!.inductor),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.inductor,
                    widgetName: kWidgetInductor,
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
                            title: AppLocalizations.of(context)!.inductor,
                            widgetName: kWidgetInductor,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(context)!.inductor,
                            widgetName: kWidgetInductor,
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
                TextoEcuaciones(AppLocalizations.of(context)!.sentidoFisico),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenInductanciaPropiaDeUnSolenoide,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.simbologia),
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenInductorSimbologiaBasica,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetInductor),
            //Descargar PDF
            const DescargarPDF(url: kWidgetInductor),
          ],
        ),
      ),
    );
  }
}
