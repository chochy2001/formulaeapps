import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class ResistorSimbologiaBasica extends StatefulWidget {
  const ResistorSimbologiaBasica({super.key});
  @override
  State<ResistorSimbologiaBasica> createState() =>
      _ResistorSimbologiaBasicaState();
}

class _ResistorSimbologiaBasicaState extends State<ResistorSimbologiaBasica> {
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
              AppLocalizations.of(context)!.resistorSimbologiaBasica,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .resistorSimbologiaBasica,
                      widgetName: kWidgetResistorSimbologiaBasica),
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
                                  .resistorSimbologiaBasica,
                              widgetName: kWidgetResistorSimbologiaBasica),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .resistorSimbologiaBasica,
                              widgetName: kWidgetResistorSimbologiaBasica),
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
                    getImageUrlById(context, kImagenResistorSimbologiaBasica) ??
                        kUrlImagenResistorSimbologiaBasica),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetResistorSimbologiaBasica,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetResistorSimbologiaBasica,
            ),
          ],
        ),
      ),
    );
  }
}
