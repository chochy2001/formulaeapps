import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuCalculoMultivariable extends StatefulWidget {
  const MenuCalculoMultivariable({Key? key}) : super(key: key);

  @override
  MenuCalculoMultivariableState createState() =>
      MenuCalculoMultivariableState();
}

class MenuCalculoMultivariableState extends State<MenuCalculoMultivariable> {
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
                    AppLocalizations.of(context)!.calculoMultivariable,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.areaBajoCurva,
                    ruta: kRutaAreaBajoLaCurva,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.areaSuperficieRevolucion,
                    ruta: kRutaAreaDeUnaSuperficieDeRevolucion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.cambioVariable,
                    ruta: kRutaCambioDeVariables,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.derivadasDireccionales,
                    ruta: kRutaDerivadasDireccionales,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.derivadasParciales,
                    ruta: kRutaDerivadasParciales,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.diferencialTotal,
                    ruta: kRutaDiferencialTotal,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.funcionesVectoriales,
                    ruta: kRutaMenuFuncionesVectoriales,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.gradienteFuncion,
                    ruta: kRutaGradienteDeUnaFuncion,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.identidadesVectoriales,
                    ruta: kRutaIdentidadesVectoriales,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .integralCoordenadasCilindricas,
                    ruta: kRutaIntegralEnCoordenadasCilindricas,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.integralesLinea,
                    ruta: kRutaIntegralesDeLinea,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.longitudArco,
                    ruta: kRutaLongitudDeArco,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.operadoresDiferenciales,
                    ruta: kRutaOperadoresDiferenciales,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.teoremaFubini,
                    ruta: kRutaTeoremaDeFubini,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.teoremaIntegrales,
                    ruta: kRutaTeoremaIntegrales,
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
