import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuMagnetostatica extends StatefulWidget {
  const MenuMagnetostatica({super.key});

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuMagnetostatica> createState() => _MenuMagnetostaticaState();
}

class _MenuMagnetostaticaState extends State<MenuMagnetostatica> {
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
                    AppLocalizations.of(context)!.magnetostatica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaOrigenDeCampoMagnetico,
                    textoBoton: AppLocalizations.of(context)!
                        .descripcionDeLosImanesYExperimentosDeOersted,
                  ),
                  BotonesMenu(
                    ruta: kRutaFuerzaMagneticaComoVectorSobreCargasEnMovimiento,
                    textoBoton: AppLocalizations.of(context)!
                        .fuerzaMagneticaComoVectorSobreCargasEnMovimiento,
                  ),
                  BotonesMenu(
                    ruta: kRutaDefinicionDeCampoMagnetico,
                    textoBoton: AppLocalizations.of(context)!
                        .definicionDeCampoMagnetico,
                  ),
                  BotonesMenu(
                    ruta: kRutaFuerzaDeLorentz,
                    textoBoton: AppLocalizations.of(context)!.fuerzaDeLorentz,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeBiotSavart,
                    textoBoton: AppLocalizations.of(context)!.leyDeBiotSavart,
                  ),
                  BotonesMenu(
                    ruta: kRutaSegmentoConductorRecto,
                    textoBoton:
                        AppLocalizations.of(context)!.segmentoConductorRecto,
                  ),
                  BotonesMenu(
                    ruta: kRutaEspiraEnFormaDeCircunferencia,
                    textoBoton: AppLocalizations.of(context)!
                        .espiraEnFormaDeCircunferencia,
                  ),
                  BotonesMenu(
                    ruta: kRutaEspiraCuadrada,
                    textoBoton: AppLocalizations.of(context)!.espiraCuadrada,
                  ),
                  BotonesMenu(
                    ruta: kRutaBobina,
                    textoBoton: AppLocalizations.of(context)!.bobina,
                  ),
                  BotonesMenu(
                    ruta: kRutaSolenoide,
                    textoBoton: AppLocalizations.of(context)!.solenoide,
                  ),
                  BotonesMenu(
                    ruta: kRutaCirculacionDeUnCampoVectorial,
                    textoBoton: AppLocalizations.of(context)!
                        .circulacionDeUnCampoVectorial,
                  ),
                  BotonesMenu(
                    ruta: kRutaCampoMagneticoAPartirDeLeyDeAmpere,
                    textoBoton: AppLocalizations.of(context)!
                        .campoMagneticoAPartirDeLeyDeAmpere,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeAmpereEnFormaDiferencial,
                    textoBoton: AppLocalizations.of(context)!
                        .leyDeAmpereEnFormaDiferencial,
                  ),
                  BotonesMenu(
                    ruta: kRutaFlujoMagnetico,
                    textoBoton: AppLocalizations.of(context)!.flujoMagnetico,
                  ),
                  BotonesMenu(
                    ruta: kRutaMotorDeCorrienteDirecta,
                    textoBoton:
                        AppLocalizations.of(context)!.motorDeCorrienteDirecta,
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
