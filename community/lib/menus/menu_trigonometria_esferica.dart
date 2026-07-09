import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuTrigonometriaEsferica extends StatefulWidget {
  const MenuTrigonometriaEsferica({Key? key}) : super(key: key);

  @override
  MenuTrigonometriaEsfericaState createState() =>
      MenuTrigonometriaEsfericaState();
}

class MenuTrigonometriaEsfericaState extends State<MenuTrigonometriaEsferica> {
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
                    AppLocalizations.of(context)!.trigonometriaEsferica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.analogiasDeGaussDelambre,
                    ruta: kRutaAnalogiasDeGaussDelambre,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.analogiasDeNeper,
                    ruta: kRutaAnalogiasDeNeper,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.funcionesDelAnguloMitad,
                    ruta: kRutaFuncionesDelAnguloMitad,
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
