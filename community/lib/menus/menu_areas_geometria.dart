import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuAreasGeometria extends StatefulWidget {
  const MenuAreasGeometria({super.key});

  @override
  MenuAreasGeometriaState createState() => MenuAreasGeometriaState();
}

class MenuAreasGeometriaState extends State<MenuAreasGeometria> {
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
                    AppLocalizations.of(context)!.areasGeometria,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .areaPerimetroCuadrilateros,
                    ruta: kRutaAreaYPerimetroDeCuadrilateros,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.areaPerimetroTriangulos,
                    ruta: kRutaAreaYPerimetroDeTriangulos,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.areaPerimetroCirculo,
                    ruta: kRutaAreaYPerimetroDelCirculo,
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
