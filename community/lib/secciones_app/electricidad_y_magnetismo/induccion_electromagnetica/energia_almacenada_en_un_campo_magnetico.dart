import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class EnergiaAlmacenadaEnUnCampoMagnetico extends StatefulWidget {
  const EnergiaAlmacenadaEnUnCampoMagnetico({super.key});
  @override
  State<EnergiaAlmacenadaEnUnCampoMagnetico> createState() =>
      _EnergiaAlmacenadaEnUnCampoMagneticoState();
}

class _EnergiaAlmacenadaEnUnCampoMagneticoState
    extends State<EnergiaAlmacenadaEnUnCampoMagnetico> {
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
              AppLocalizations.of(context)!.energiaAlmacenadaEnUnCampoMagnetico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.energiaAlmacenadaEnUnCampoMagnetico,
                    widgetName: kWidgetEnergiaAlmacenadaEnUnCampoMagnetico,
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
                            )!.energiaAlmacenadaEnUnCampoMagnetico,
                            widgetName:
                                kWidgetEnergiaAlmacenadaEnUnCampoMagnetico,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.energiaAlmacenadaEnUnCampoMagnetico,
                            widgetName:
                                kWidgetEnergiaAlmacenadaEnUnCampoMagnetico,
                          ),
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
                    AppLocalizations.of(context)!.enElCasoDeUnSolenoideLargo,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"L = \frac{\mu_0N^2A}{l}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText:
                        r"U = \frac{1}{2}LI^2 = \frac{1}{2}\frac{\mu_0N^2A}{l}I^2",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.enFuncionDelCampoMagnetico,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"B= \frac{\mu_0NI}{I}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText: r"U = \frac{1}{2}B^2 \frac{Al}{\mu_0}",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"U = \frac{1}{2\mu_0}B^2V'"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.energiaPorUnidadDeVolumen,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText: r"u = \frac{U}{V'} = \frac{B^2}{2\mu_0}",
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText: r"[u]_u = \left[\frac{J}{m^3}\right]",
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(
                      context,
                    )!.energiaDeUnCampoMagneticoNoHomogeneo,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                    formulaText: r"U = \frac{1}{2\mu_0}\iiint B^2 dV'",
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetEnergiaAlmacenadaEnUnCampoMagnetico),
            //Descargar PDF
            const DescargarPDF(url: kWidgetEnergiaAlmacenadaEnUnCampoMagnetico),
          ],
        ),
      ),
    );
  }
}
