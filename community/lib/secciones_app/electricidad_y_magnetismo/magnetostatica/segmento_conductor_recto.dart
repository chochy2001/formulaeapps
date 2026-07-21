import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class SegmentoConductorRecto extends StatefulWidget {
  const SegmentoConductorRecto({super.key});
  @override
  State<SegmentoConductorRecto> createState() => _SegmentoConductorRectoState();
}

class _SegmentoConductorRectoState extends State<SegmentoConductorRecto> {
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
              AppLocalizations.of(context)!.segmentoConductorRecto,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(context)!.segmentoConductorRecto,
                    widgetName: kWidgetSegmentoConductoRecto,
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
                            )!.segmentoConductorRecto,
                            widgetName: kWidgetSegmentoConductoRecto,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.segmentoConductorRecto,
                            widgetName: kWidgetSegmentoConductoRecto,
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
                const ZoomImagePersonalizado(
                  urlImagen: kUrlImagenSegmentoDeConductorRecto,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(AppLocalizations.of(context)!.leyDeBiotSavart),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"d\vec{B}= \frac{\mu_0}{4\pi}\frac{id\vec{l}\times \bar{r}}{r^3}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(
                    context,
                  )!.magnitudDelCampoMagneticoMitadConductor,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"B = \frac{\mu_0}{4\pi}i \int_{\frac{-L}{2}}^{\frac{L}{2}} \frac{dl\sin{\alpha}}{r^2}",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"B = \frac{\mu_0}{4\pi}i \int_{\frac{-L}{2}}^{\frac{L}{2}} \frac{y dx}{(x^2+y^2)^{\frac{3}{2}}}",
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText:
                      r"B = \frac{\mu_0 i}{4\pi y} \frac{L}{(\frac{L^2}{4}+y^2)^{\frac{1}{2}}}",
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conductorMuyLargo,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                  formulaText: r"\vec{B} = \frac{\mu_0 i}{2\pi r}\hat{r}",
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetSegmentoConductoRecto),
            //Descargar PDF
            const DescargarPDF(url: kWidgetSegmentoConductoRecto),
          ],
        ),
      ),
    );
  }
}
