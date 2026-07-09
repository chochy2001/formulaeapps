import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';
import '../constantes/contantes_rutas.dart';

class PrincipalMenu extends StatefulWidget {
  const PrincipalMenu({
    super.key,
  });

  @override
  State<PrincipalMenu> createState() => _PrincipalMenuState();
}

class _PrincipalMenuState extends State<PrincipalMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          //Imagen Formulae (Boton Capdesis)

          GestureDetector(
            onTap: () {
              openURLNuevo('https://capdesis.com/');
            },
            child: const Center(
              child: CapdesisLogo(height: 100.0, width: 100.0),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Boton de Generales*/
                  BotonesMenu(
                    ruta: kRutaGenerales,
                    textoBoton: AppLocalizations.of(context)!.generales,
                  ),
                  /*Boton de Algebra*/
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.algebra,
                    ruta: kRutaMenuAlgebra,
                  ),
                  /*Boton de Algebra Lineal*/
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.algebraLineal,
                    ruta: kRutaAlgebraLinealMenu,
                  ),
                  /*Boton de Calculo Diferencial*/
                  BotonesMenu(
                    ruta: kRutaCalculoDiferencial,
                    textoBoton:
                        AppLocalizations.of(context)!.calculoDiferencial,
                  ),
                  /*Boton de Calculo Integral*/
                  BotonesMenu(
                    ruta: kRutaCalculoIntegral,
                    textoBoton: AppLocalizations.of(context)!.calculoIntegral,
                  ),
                  /*Boton de Calculo Multivariable*/
                  BotonesMenu(
                    ruta: kRutaMenuCalculoMultivariable,
                    textoBoton:
                        AppLocalizations.of(context)!.calculoMultivariable,
                  ),
                  /*Boton de Ecuaciones Diferenciales*/
                  BotonesMenu(
                    ruta: kRutaMenuEcuacionesDiferenciales,
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionesDiferenciales,
                  ),
                  //Boton de Electricidad y Magnetismo
                  BotonesMenu(
                    ruta: kRutaMenuElectricidadYMagnetismo,
                    textoBoton:
                        AppLocalizations.of(context)!.electricidadMagnetismo,
                  ),
                  //Boton de Geometria
                  BotonesMenu(
                    ruta: kRutaMenuGeometria,
                    textoBoton: AppLocalizations.of(context)!.geometria,
                  ),
                  //Boton Matematicas Discretas
                  BotonesMenu(
                    ruta: kRutaMenuMatematicasDiscretas,
                    textoBoton:
                        AppLocalizations.of(context)!.matematicasDiscretas,
                  ),
                  //Boton Matematicas Financieras
                  BotonesMenu(
                    ruta: kRutaMenuMatematicasFinancieras,
                    textoBoton:
                        AppLocalizations.of(context)!.matematicasFinancieras,
                  ),
                  /*Boton de Probabilidad y Estadistica*/
                  BotonesMenu(
                    ruta: kRutaMenuProbabilidadYEstadistica,
                    textoBoton:
                        AppLocalizations.of(context)!.probabilidadEstadistica,
                  ),
                  /*Boton de Series de Fourier*/
                  BotonesMenu(
                    ruta: kRutaMenuSeriesDeFourier,
                    textoBoton: AppLocalizations.of(context)!.seriesFourier,
                  ),
                  /*Boton de Trigonometria*/
                  BotonesMenu(
                    ruta: kRutaMenuTrigonometria,
                    textoBoton: AppLocalizations.of(context)!.trigonometria,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
