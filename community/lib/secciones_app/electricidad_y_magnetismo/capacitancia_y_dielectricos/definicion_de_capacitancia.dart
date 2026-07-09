import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class DefinicionDeCapacitancia extends StatefulWidget {
  @override
  State<DefinicionDeCapacitancia> createState() =>
      _DefinicionDeCapacitanciaState();
}

class _DefinicionDeCapacitanciaState extends State<DefinicionDeCapacitancia> {
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
              AppLocalizations.of(context)!.definicionCapacitancia,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.definicionCapacitancia,
                      widgetName: kWidgetDefinicionDeCapacitancia),
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
                                  .definicionCapacitancia,
                              widgetName: kWidgetDefinicionDeCapacitancia),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .definicionCapacitancia,
                              widgetName: kWidgetDefinicionDeCapacitancia),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cuandoUnCapacitorSeCarga,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"Q \propto V"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"Q = CV"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"C = \frac{Q}{V}"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"[C]_u = \left [ \frac{\text{C}}{\text{V}} \right ] = [F]: Farad"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetDefinicionDeCapacitancia,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetDefinicionDeCapacitancia,
            ),
          ],
        ),
      ),
    );
  }
}
