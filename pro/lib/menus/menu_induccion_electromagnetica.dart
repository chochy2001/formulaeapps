import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuInduccionElectromagnetica extends StatelessWidget {
  const MenuInduccionElectromagnetica({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              MenuColumn(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.induccionElectromagnetica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    ruta: kRutaGeneradorHomopolar,
                    textoBoton:
                        AppLocalizations.of(context)!.generadorHomopolar,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaPropia,
                    textoBoton: AppLocalizations.of(context)!.inductanciaPropia,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaMutua,
                    textoBoton: AppLocalizations.of(context)!.inductanciaMutua,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaPropiaDeUnSolenoide,
                    textoBoton: AppLocalizations.of(context)!
                        .inductanciaPropiaDeUnSolenoide,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaParaUnToroide,
                    textoBoton:
                        AppLocalizations.of(context)!.inductanciaParaUnToroide,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaMutuaEntreDosSolenoidesCoaxiales,
                    textoBoton: AppLocalizations.of(context)!
                        .inductanciaMutuaEntreDosSolenoidesCoaxiales,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeInduccionDeFaraday,
                    textoBoton: AppLocalizations.of(context)!
                        .leyDeInduccionDeFaradayYEnergisEnUnInductor,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaAlmacenadaEnUnCampoMagnetico,
                    textoBoton: AppLocalizations.of(context)!
                        .energiaAlmacenadaEnUnCampoMagnetico,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductor,
                    textoBoton: AppLocalizations.of(context)!.inductor,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductorEnSerie,
                    textoBoton: AppLocalizations.of(context)!.inductoresEnSerie,
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
