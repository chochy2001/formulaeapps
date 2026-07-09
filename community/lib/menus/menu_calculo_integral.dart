import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class CalculoIntegral extends StatefulWidget {
  const CalculoIntegral({Key? key}) : super(key: key);

  @override
  CalculoIntegralState createState() => CalculoIntegralState();
}

class CalculoIntegralState extends State<CalculoIntegral> {
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
                    AppLocalizations.of(context)!.calculoIntegral,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  //Integracion Básica
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.integracionBasica,
                    ruta: kRutaIntegracionBasica,
                  ),
                  //Funciones Trigonometricas Integral
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.funcionesTrigonometricas,
                    ruta: kRutaFuncionesTrigonometricasIntegral,
                  ),
                  //trigonometricas inversas Integral
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.trigonometricasInversas,
                    ruta: kRutaFuncionesTrigonometricasInversasIntegral,
                  ),
                  //Funciones Hiperbolicas Integral
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .trigonometricasHiperbolicas,
                    ruta: kRutaFuncionesHiperbolicasIntegral,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.exponencialLogaritmos,
                    ruta: kRutaFuncionesExponencialyLogaritmosIntegral,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.integralesExtras,
                    ruta: kRutaIntegralesExtras,
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
