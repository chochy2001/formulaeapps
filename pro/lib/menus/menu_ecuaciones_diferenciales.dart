import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuEcuacionesDiferenciales extends StatefulWidget {
  const MenuEcuacionesDiferenciales({super.key});

  @override
  MenuEcuacionesDiferencialesState createState() =>
      MenuEcuacionesDiferencialesState();
}

class MenuEcuacionesDiferencialesState
    extends State<MenuEcuacionesDiferenciales> {
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
                    AppLocalizations.of(context)!.ecuacionesDiferenciales,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.constantesDeIntegracion,
                    ruta: kRutaConstantesDeIntegracion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialCoeficientesConstantes,
                    ruta: kRutaEcuacionDiferencialConCoeficientesConstantes,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialRectasNoParalelas,
                    ruta: kRutaEcuacionDiferencialDeRectasNoParalelas,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialRectasParalelas,
                    ruta: kRutaEcuacionDiferencialDeRectasParalelas,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionDiferencialExacta,
                    ruta: kRutaEcuacionDiferencialExacta,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialHomogenea,
                    ruta: kRutaEcuacionDiferencialHomogenea,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialLinealOrdenSuperior,
                    ruta: kRutaEcuacionDiferencialLinealDeOrdenSuperior,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialLinealPrimerOrden,
                    ruta: kRutaEcuacionDiferencialLinealDePrimerOrden,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialSeparable,
                    ruta: kRutaEcuacionDiferencialSeparable,
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
