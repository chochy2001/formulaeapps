import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class InductanciaMutuaEntreDosSolenoidesCoaxiales extends StatefulWidget {
  const InductanciaMutuaEntreDosSolenoidesCoaxiales({super.key});
  @override
  State<InductanciaMutuaEntreDosSolenoidesCoaxiales> createState() =>
      _InductanciaMutuaEntreDosSolenoidesCoaxialesState();
}

class _InductanciaMutuaEntreDosSolenoidesCoaxialesState
    extends State<InductanciaMutuaEntreDosSolenoidesCoaxiales> {
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
              AppLocalizations.of(context)!
                  .inductanciaMutuaEntreDosSolenoidesCoaxiales,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .inductanciaMutuaEntreDosSolenoidesCoaxiales,
                      widgetName:
                          kWidgetInductanciaMutuaEntreDosSolenoidesCoaxiales),
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
                                  .inductanciaMutuaEntreDosSolenoidesCoaxiales,
                              widgetName:
                                  kWidgetInductanciaMutuaEntreDosSolenoidesCoaxiales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .inductanciaMutuaEntreDosSolenoidesCoaxiales,
                              widgetName:
                                  kWidgetInductanciaMutuaEntreDosSolenoidesCoaxiales),
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
                const ZoomImagePersonalizado(
                    urlImagen:
                        kUrlImagenInductanciaMutuaEntreDosSolenoidesCoaxiales),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.laInductanciaMutua,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"M = \frac{\lambda_{21}}{I_{1}} \neq \frac{\lambda_{12}}{I_{2}}"),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.flujoConcatenadoEnElSolenoide2,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\lambda_{21} = N_{2}\Phi_{21}"),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.laInductanciaMutua,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"M = \frac{\lambda_{21}}{I_{1}} = \frac{N_{2}\Phi_{21}}{I_1} = \frac{N_2\frac{\mu_0N_1I_1A}{l_1}}{I_1}"),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"M = \frac{\mu_0N_1N_2A}{l_1}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetInductanciaMutuaEntreDosSolenoidesCoaxiales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetInductanciaMutuaEntreDosSolenoidesCoaxiales,
            ),
          ],
        ),
      ),
    );
  }
}
