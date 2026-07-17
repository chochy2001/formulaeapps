import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class SolucionEcuaciones extends StatefulWidget {
  const SolucionEcuaciones({super.key});

  @override
  SolucionEcuacionesState createState() => SolucionEcuacionesState();
}

class SolucionEcuacionesState extends State<SolucionEcuaciones> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  adContainer,
                  const ImagenLogoFormulae(),
                  Text(
                    AppLocalizations.of(context)!.solucionEcuaciones,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionesDePrimerGrado,
                    ruta: kRutaEcuacionesDePrimerGrado,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionesDeSegundoGrado,
                    ruta: kRutaEcuacionesDeSegundoGrado,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
