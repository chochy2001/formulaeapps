import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class Generales extends StatefulWidget {
  const Generales({Key? key}) : super(key: key);

  @override
  GeneralesState createState() => GeneralesState();
}

class GeneralesState extends State<Generales> {
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
                    AppLocalizations.of(context)!.generales,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  //Propiedades Logaritmos
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.propiedadesLogaritmos,
                    ruta: kRutaPropiedadesLogaritmos,
                  ),
                  //Funciones Trigonometricas
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.funcionesTrigonometricas,
                    ruta: kRutaFuncionesTrigonometricasGenerales,
                  ),
                  //Identidades Trigonometricas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .identidadesTrigonometricas,
                    ruta: kRutaIdentidadesTrigonometricas,
                  ),
                  //Trigonometricas Hiperbolicas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .trigonometricasHiperbolicas,
                    ruta: kRutaTrigonometricasHiperbolicas,
                  ),
                  //Identidades Hiperbolicas
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.identidadesHiperbolicas,
                    ruta: kRutaIdentidadesHiperbolicas,
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
