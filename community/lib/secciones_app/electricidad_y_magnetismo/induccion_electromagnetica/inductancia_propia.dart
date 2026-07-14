import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class InductanciaPropia extends StatefulWidget {
  const InductanciaPropia({super.key});
  @override
  State<InductanciaPropia> createState() => _InductanciaPropiaState();
}

class _InductanciaPropiaState extends State<InductanciaPropia> {
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
              AppLocalizations.of(context)!.inductanciaPropia,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.inductanciaPropia,
                      widgetName: kWidgetInductanciaPropia),
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
                                  .inductanciaPropia,
                              widgetName: kWidgetInductanciaPropia),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .inductanciaPropia,
                              widgetName: kWidgetInductanciaPropia),
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
                    AppLocalizations.of(context)!.laInductanciaEnUnElemento,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.enUnaEspiraElFlujo,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\Phi_B \propto I"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.enElCasoDeUnaSolaEspira,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\Phi_B = LI"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laVariacionDeCorriente,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"\lambda = N\Phi_B"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\lambda = LI"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[\lambda]_u = [Wb]"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.flujoConcatenado,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"L = \frac{\lambda}{I}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[L]_u = [\frac{Wb}{A}] = [H]"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[H] = Henry"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\varepsilon_i = -\frac{d}{dt}\Phi_B"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\varepsilon_i = -\frac{d}{dt}\lambda"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\varepsilon_i = -\frac{d}{dt}\lambda = -\frac{d}{dt}LI"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\varepsilon_i = -L\frac{d}{dt}I"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetInductanciaPropia,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetInductanciaPropia,
            ),
          ],
        ),
      ),
    );
  }
}
