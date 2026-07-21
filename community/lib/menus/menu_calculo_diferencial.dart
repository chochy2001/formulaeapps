import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class CalculoDiferencial extends StatefulWidget {
  const CalculoDiferencial({super.key});

  @override
  CalculoDiferencialState createState() => CalculoDiferencialState();
}

class CalculoDiferencialState extends State<CalculoDiferencial> {
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
      appBar: const AppBarHome(visible: false),
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
                    AppLocalizations.of(context)!.calculoDiferencial,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  adContainer,
                  //Limites
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.limites,
                    ruta: kRutaLimites,
                  ),
                  //Derivacion Basica
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.derivacionBasica,
                    ruta: kRutaDerivacionBasica,
                  ),
                  //Funciones Trigonometricas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.funcionesTrigonometricas,
                    ruta: kRutaFuncionesTrigonometricasDiferencial,
                  ),
                  //Trigonometricas Inversas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.trigonometricasInversas,
                    ruta: kRutaFuncionesTrigonometricasInversasDiferencial,
                  ),
                  //Trigonometricas Hiperbólicas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.trigonometricasHiperbolicas,
                    ruta: kRutaFuncionesTrigonometricasHiperbolicasDiferencial,
                  ),
                  //Exponencial y Logaritmos
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.exponencialLogaritmos,
                    ruta: kRutaExponencialyLogaritmosDiferencial,
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
