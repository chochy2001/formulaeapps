import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class IntegralEnCoordenadasCilindricas extends StatefulWidget {
  const IntegralEnCoordenadasCilindricas({super.key});
  @override
  State<IntegralEnCoordenadasCilindricas> createState() =>
      _IntegralEnCoordenadasCilindricasState();
}

class _IntegralEnCoordenadasCilindricasState
    extends State<IntegralEnCoordenadasCilindricas> {
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
              AppLocalizations.of(context)!.integralCoordenadasCilindricas,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .integralCoordenadasCilindricas,
                      widgetName: kWidgetIntegralEnCoordenasCilindricas),
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
                                  .integralCoordenadasCilindricas,
                              widgetName:
                                  kWidgetIntegralEnCoordenasCilindricas),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .integralCoordenadasCilindricas,
                              widgetName:
                                  kWidgetIntegralEnCoordenasCilindricas),
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
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .coordenadasCartesianaACilindricas,
                  ),
                  const Latex(
                      formulaText:
                          r"\int_{D_{xyz}}\iint F(x,y,z)dx\thinspace dy\thinspace dz=\int_0^r\int_0^{2\pi}\int_0^z G(r,\phi,z)r\thinspace dr\thinspace d\phi\thinspace dz"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .coordenadasCartesianaAEsfericas,
                  ),
                  const Latex(
                      formulaText:
                          r"\int_{D_{xyz}}\iint F(x,y,z)dx\thinspace dy\thinspace dz=\int_0^r\int_{\frac{-\pi}{2}}^{\frac{\pi}{2}}\int_0^{2\pi} G(r,\theta,\phi)r^2\thinspace \sin\theta\space dr d\theta d\phi"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetIntegralEnCoordenasCilindricas,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetIntegralEnCoordenasCilindricas,
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
