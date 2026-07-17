import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuTrigonometria extends StatefulWidget {
  const MenuTrigonometria({super.key});

  @override
  MenuTrigonometriaState createState() => MenuTrigonometriaState();
}

class MenuTrigonometriaState extends State<MenuTrigonometria> {
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
                    AppLocalizations.of(context)!.trigonometria,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.formulasDeBessel,
                    ruta: kRutaMenuFormulasBessel,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.funcionesTrigonometricas,
                    ruta: kRutaFuncionesTrigonometricas,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .funcionesTrigonometricasDeAngulosNotables,
                    ruta: kRutaFuncionesTrigonometricasDeAngulosNotables,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .identidadesTrigonometricas,
                    ruta: kRutaMenuIdentidadesTrigonometricas,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.leyDeProyecciones,
                    ruta: kRutaLeyDeProyecciones,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .leyDeSenosCosenosYTangente,
                    ruta: kRutaLeyesDeSenosCosenosTangentes,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .medicionYClasificacionDeAngulos,
                    ruta: kRutaMedicionYClasificacionDeAngulos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .superficieDeUnTrianguloYUnPoligonoEsferico,
                    ruta: kRutaSuperficieDeUnTrianguloYUnPoligonoEsferico,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.teoremaDePitagoras,
                    ruta: kRutaTeoremaDePitagoras,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.trigonometriaEsferica,
                    ruta: kRutaMenuTrigonometriaEsferica,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.valoresDeSenoYCoseno,
                    ruta: kRutaValoresDeSenoYCoseno,
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
