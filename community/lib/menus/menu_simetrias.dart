import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuSimetrias extends StatefulWidget {
  const MenuSimetrias({super.key});

  @override
  MenuSimetriasState createState() => MenuSimetriasState();
}

class MenuSimetriasState extends State<MenuSimetrias> {
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
                    AppLocalizations.of(context)!.simetrias,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.simetriaDeMediaOnda,
                    ruta: kRutaSimetriaDeMediaOnda,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .simetriaDeUnCuartoDeOndaImpar,
                    ruta: kRutaSimetriaDeUnCuartoDeOndaImpar,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .simetriaDeUnCuartoDeOndaPar,
                    ruta: kRutaSimetriaDeUnCuartoDeOndaPar,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.simetriaImpar,
                    ruta: kRutaSimetriaImpar,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.simetriaPar,
                    ruta: kRutaSimetriaPar,
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
