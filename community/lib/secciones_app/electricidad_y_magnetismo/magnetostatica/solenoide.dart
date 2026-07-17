import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class Solenoide extends StatefulWidget {
  const Solenoide({super.key});
  @override
  State<Solenoide> createState() => _SolenoideState();
}

class _SolenoideState extends State<Solenoide> {
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
              AppLocalizations.of(context)!.solenoide,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.solenoide,
                      widgetName: kWidgetSolenoide),
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
                              title: AppLocalizations.of(context)!.solenoide,
                              widgetName: kWidgetSolenoide),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.solenoide,
                              widgetName: kWidgetSolenoide),
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
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solenoideBobina,
                ),
                const SizedBox(height: 30.0),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenSolenoide),
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
                  AppLocalizations.of(context)!
                      .magnitudDelCampoMagneticoParaUnaEspira,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = \frac{\mu_0 i R^2}{2(R^2 + x^2)^{\frac{3}{2}}}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.paraUnaPosicionD,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = \int_{\frac{-h}{2}}^{\frac{h}{2}}\frac{\mu_0(ndz)R^2}{2(R^2+(z-d)^2)^{\frac{3}{2}}}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = \frac{\mu _0 ni}{2}\left(\frac{\frac{h}{2}+d}{\sqrt{R^2 +(\frac{h}{2}+d)^2}}+\frac{\frac{h}{2}-d}{\sqrt{R^2 + (\frac{h}{2}-d)^2}}\right)"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solenoideIdeal,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"B = \mu_0 ni"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetSolenoide,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetSolenoide,
            ),
          ],
        ),
      ),
    );
  }
}
