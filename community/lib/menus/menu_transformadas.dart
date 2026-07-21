import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuTransformadas extends StatefulWidget {
  const MenuTransformadas({super.key});

  @override
  MenuTransformadasState createState() => MenuTransformadasState();
}

class MenuTransformadasState extends State<MenuTransformadas> {
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
                    AppLocalizations.of(context)!.transformadas,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  adContainer,
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadaDeFourier,
                    ruta: kRutaTransformadaDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadaDeLaplace,
                    ruta: kRutaTransformadaDeLaplace,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadaSenoYCosenoDeFourier,
                    ruta: kRutaTransformadaSenoYCosenoDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadasBasicasDeFourier,
                    ruta: kRutaTransformadasBasicasDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadasDeFourier,
                    ruta: kRutaTransformadasDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadasDeLaplace,
                    ruta: kRutaTransformadasDeLaplace,
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
