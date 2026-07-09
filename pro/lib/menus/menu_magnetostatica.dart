import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuMagnetostatica extends StatelessWidget {
  const MenuMagnetostatica({super.key});

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
