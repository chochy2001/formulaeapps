import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class AreaDeUnaSuperficieDeRevolucion extends StatefulWidget {
  @override
  _AreaDeUnaSuperficieDeRevolucionState createState() =>
      _AreaDeUnaSuperficieDeRevolucionState();
}

class _AreaDeUnaSuperficieDeRevolucionState
    extends State<AreaDeUnaSuperficieDeRevolucion> {
  bool seleccionadoMostrar = true;

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
              AppLocalizations.of(context)!.areaSuperficieRevolucion,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .areaSuperficieRevolucion,
                      widgetName: kWidgetAreaDeUnaSuperficieDeRevolucion),
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
                                  .areaSuperficieRevolucion,
                              widgetName:
                                  kWidgetAreaDeUnaSuperficieDeRevolucion),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .areaSuperficieRevolucion,
                              widgetName:
                                  kWidgetAreaDeUnaSuperficieDeRevolucion),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 20.0,
            ),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.alrededordelejex,
                  ),
                  const Latex(
                      formulaText:
                          r"A= 2 \pi \int_{a}^b y\sqrt{1+\left( \frac{dy}{dx} \right)^2}dx"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.alrededordelejey,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"A= 2 \pi \int_{a}^b x\sqrt{1+\left( \frac{dx}{dy} \right)^2}dy"),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetAreaDeUnaSuperficieDeRevolucion,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetAreaDeUnaSuperficieDeRevolucion,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
