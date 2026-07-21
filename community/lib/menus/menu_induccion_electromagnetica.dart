import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuInduccionElectromagnetica extends StatefulWidget {
  const MenuInduccionElectromagnetica({super.key});

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuInduccionElectromagnetica> createState() =>
      _MenuInduccionElectromagneticaState();
}

class _MenuInduccionElectromagneticaState
    extends State<MenuInduccionElectromagnetica> {
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
        child: FondoDegradado(
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.induccionElectromagnetica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaGeneradorHomopolar,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.generadorHomopolar,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaPropia,
                    textoBoton: AppLocalizations.of(context)!.inductanciaPropia,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaMutua,
                    textoBoton: AppLocalizations.of(context)!.inductanciaMutua,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaPropiaDeUnSolenoide,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.inductanciaPropiaDeUnSolenoide,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaParaUnToroide,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.inductanciaParaUnToroide,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaMutuaEntreDosSolenoidesCoaxiales,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.inductanciaMutuaEntreDosSolenoidesCoaxiales,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeInduccionDeFaraday,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.leyDeInduccionDeFaradayYEnergisEnUnInductor,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaAlmacenadaEnUnCampoMagnetico,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.energiaAlmacenadaEnUnCampoMagnetico,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductor,
                    textoBoton: AppLocalizations.of(context)!.inductor,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductorEnSerie,
                    textoBoton: AppLocalizations.of(context)!.inductoresEnSerie,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
