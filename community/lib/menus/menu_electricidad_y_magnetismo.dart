import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuElectricidadYMagnetismo extends StatefulWidget {
  const MenuElectricidadYMagnetismo({super.key});

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuElectricidadYMagnetismo> createState() =>
      _MenuElectricidadYMagnetismoState();
}

class _MenuElectricidadYMagnetismoState
    extends State<MenuElectricidadYMagnetismo> {
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
      appBar: const AppBarHome(
        visible: false,
      ),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.electricidadMagnetismo,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaMenuCampoYPotencialElectricos,
                    textoBoton:
                        AppLocalizations.of(context)!.campoYPotencialElectricos,
                  ),
                  BotonesMenu(
                    ruta: kRutaMenuCapacitanciaYDielectricos,
                    textoBoton:
                        AppLocalizations.of(context)!.capacitanciaYDielectricos,
                  ),
                  BotonesMenu(
                    ruta: kRutaMenuCircuitosElectricos,
                    textoBoton:
                        AppLocalizations.of(context)!.circuitosElectricos,
                  ),
                  BotonesMenu(
                    ruta: kRutaMenuMagnetostatica,
                    textoBoton: AppLocalizations.of(context)!.magnetostatica,
                  ),
                  BotonesMenu(
                    ruta: kRutaMenuInduccionElectromagnetica,
                    textoBoton:
                        AppLocalizations.of(context)!.induccionElectromagnetica,
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
