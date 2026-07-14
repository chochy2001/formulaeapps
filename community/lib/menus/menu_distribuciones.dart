import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuDistribuciones extends StatefulWidget {
  const MenuDistribuciones({super.key});

  @override
  MenuDistribucionesState createState() => MenuDistribucionesState();
}

class MenuDistribucionesState extends State<MenuDistribuciones> {
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
                    AppLocalizations.of(context)!.distribuciones,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.distribucionBinomial,
                    ruta: kRutaDistribucionBinomial,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.distribucionPoisson,
                    ruta: kRutaDistribucionDePoisson,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.distribucionExponencial,
                    ruta: kRutaDistribucionExponencial,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.distribucionGeometrica,
                    ruta: kRutaDistribucionGeometrica,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .distribucionHipergeometrica,
                    ruta: kRutaDistribucionHipergeometrica,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.distribucionNormal,
                    ruta: kRutaDistribucionNormal,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.distribucionTStudent,
                    ruta: kRutaDistribucionTDeStudent,
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
