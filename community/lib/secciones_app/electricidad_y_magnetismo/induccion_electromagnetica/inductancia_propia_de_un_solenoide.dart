import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class InductanciaPropiaDeUnSolenoide extends StatefulWidget {
  @override
  State<InductanciaPropiaDeUnSolenoide> createState() =>
      _InductanciaPropiaDeUnSolenoideState();
}

class _InductanciaPropiaDeUnSolenoideState
    extends State<InductanciaPropiaDeUnSolenoide> {
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
              AppLocalizations.of(context)!.inductanciaPropiaDeUnSolenoide,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .inductanciaPropiaDeUnSolenoide,
                      widgetName: kWidgetInductanciaPropiaDeUnSolenoide),
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
                                  .inductanciaPropiaDeUnSolenoide,
                              widgetName:
                                  kWidgetInductanciaPropiaDeUnSolenoide),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .inductanciaPropiaDeUnSolenoide,
                              widgetName:
                                  kWidgetInductanciaPropiaDeUnSolenoide),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const ZoomImagePersonalizado(
                urlImagen: kUrlImagenInductanciaPropiaDeUnSolenoide),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .flujoMagneticoEnUnSolenoideIdeal,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\Phi_B = \iint \vec{B} \cdot d\vec{A} = \mu_0 nIA"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.flujoTotalConcatenado,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\lambda = N\Phi_B = \frac{\mu_0 N^2IA}{l}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laInductancia,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"L = \frac{\lambda }{I} = \frac{\mu_0 N^2A}{l}"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetInductanciaPropiaDeUnSolenoide,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetInductanciaPropiaDeUnSolenoide,
            ),
          ],
        ),
      ),
    );
  }
}
