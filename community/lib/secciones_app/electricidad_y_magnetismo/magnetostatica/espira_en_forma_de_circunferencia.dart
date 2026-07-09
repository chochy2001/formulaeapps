import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class EspiraEnFormaDeCircunferencia extends StatefulWidget {
  @override
  State<EspiraEnFormaDeCircunferencia> createState() =>
      _EspiraEnFormaDeCircunferenciaState();
}

class _EspiraEnFormaDeCircunferenciaState
    extends State<EspiraEnFormaDeCircunferencia> {
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
              AppLocalizations.of(context)!.espiraEnFormaDeCircunferencia,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .espiraEnFormaDeCircunferencia,
                      widgetName: kWidgetEspiraEnFormaDeCircunferencia),
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
                                  .espiraEnFormaDeCircunferencia,
                              widgetName: kWidgetEspiraEnFormaDeCircunferencia),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .espiraEnFormaDeCircunferencia,
                              widgetName: kWidgetEspiraEnFormaDeCircunferencia),
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
                    urlImagen: kUrlImagenEspiraEnFormaDeCircunferencia),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeBiotSavart,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"d\vec{B}= \frac{\mu_0}{4\pi}\frac{id\vec{l}\times \bar{r}}{r^3}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.magnitudDelCampoMagnetico,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = B_x = \frac{\mu _0}{4\pi}\int{\frac{cos{\theta} dl \sin{\alpha}}{r^2}}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = \frac{\mu _0}{4\pi} i \int{\frac{Rdl}{(R^2+x^2)^\frac{3}{2}}}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = \frac{\mu _0 i R^2}{(R^2+x^2)^\frac{3}{2}}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enElCentroDeLaEspira,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\vec{B} = \frac{\mu _0 i}{2R}\hat{r}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetEspiraEnFormaDeCircunferencia,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetEspiraEnFormaDeCircunferencia,
            ),
          ],
        ),
      ),
    );
  }
}
