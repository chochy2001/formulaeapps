import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuElectricidadYMagnetismo extends StatelessWidget {
  const MenuElectricidadYMagnetismo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(visible: false),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              MenuColumn(
                children: [
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.electricidadMagnetismo,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    ruta: kRutaMenuCampoYPotencialElectricos,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.campoYPotencialElectricos,
                  ),
                  BotonesMenu(
                    ruta: kRutaMenuCapacitanciaYDielectricos,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.capacitanciaYDielectricos,
                  ),
                  BotonesMenu(
                    ruta: kRutaMenuCircuitosElectricos,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.circuitosElectricos,
                  ),
                  BotonesMenu(
                    ruta: kRutaMenuMagnetostatica,
                    textoBoton: AppLocalizations.of(context)!.magnetostatica,
                  ),
                  BotonesMenu(
                    ruta: kRutaMenuInduccionElectromagnetica,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.induccionElectromagnetica,
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
