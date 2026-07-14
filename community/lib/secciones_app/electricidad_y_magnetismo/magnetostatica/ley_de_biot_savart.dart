import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class LeyDeBiotSavart extends StatefulWidget {
  const LeyDeBiotSavart({super.key});
  @override
  State<LeyDeBiotSavart> createState() => _LeyDeBiotSavartState();
}

class _LeyDeBiotSavartState extends State<LeyDeBiotSavart> {
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
              AppLocalizations.of(context)!.leyDeBiotSavart,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.leyDeBiotSavart,
                      widgetName: kWidgetLeyDeBiotSavart),
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
                              title:
                                  AppLocalizations.of(context)!.leyDeBiotSavart,
                              widgetName: kWidgetLeyDeBiotSavart),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.leyDeBiotSavart,
                              widgetName: kWidgetLeyDeBiotSavart),
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
                        getImageUrlById(context, kImagenLeyDeBiotSavart1) ??
                            kUrlImagenLeyDeBiotSavart1),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{B}= \frac{\mu_0}{4\pi}\frac{q\vec{v}\times \bar{r}}{r^3}"),
                const SizedBox(height: 50.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenLeyDeBiotSavart2),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeBiotSavart,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{B}= \frac{\mu_0}{4\pi}\frac{i\vec{L}\times \bar{r}}{r^3}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"d\vec{B}= \frac{\mu_0}{4\pi}\frac{id\vec{l}\times \bar{r}}{r^3}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyDeBiotSavart,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyDeBiotSavart,
            ),
          ],
        ),
      ),
    );
  }
}
