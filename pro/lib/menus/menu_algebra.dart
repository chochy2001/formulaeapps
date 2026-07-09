import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuAlgebra extends StatefulWidget {
  const MenuAlgebra({super.key});

  @override
  MenuAlgebraState createState() => MenuAlgebraState();
}

class MenuAlgebraState extends State<MenuAlgebra> {
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
              TextButton(
                onPressed: () {},
                child: const ImagenLogoFormulae(),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.algebra,
                  style: kTextoBotones,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SolucionEcuaciones
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.solucionEcuaciones,
                      ruta: kRutaSolucionEcuaciones,
                    ),
                    //Ecuaciones Lineales
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.ecuacionesLineales,
                      ruta: kRutaEcuacionesLineales,
                    ),
                    //Formula General
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.formulaGeneral,
                      ruta: kRutaFormulaGeneral,
                    ),
                    //Formulas de Productos
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.formulaProductos,
                      ruta: kRutaFormulasDeProductos,
                    ),
                    //Formulas de Factorizacion
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.formulasFactorizacion,
                      ruta: kRutaFormulasDeFactorizacion,
                    ),
                    //Numeros complejos
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.numerosComplejos,
                      ruta: kRutaNumerosComplejos,
                    ),
                    //Operaciones con Fracciones Algebraicas
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .operacionesFraccionesAlgebraicas,
                      ruta: kRutaOperacionesFraccionesAlgebraicas,
                    ),
                    //Propiedades de los Exponentes
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.operacionesPolinomios,
                      ruta: kRutaOperacionesConPolinomios,
                    ),
                    //Propiedades de las Desigualdades
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.propiedadesExponentes,
                      ruta: kRutaPropiedadesDeLosExponentes,
                    ),
                    //Propiedades de los radicales
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .propiedadesDesigualdades,
                      ruta: kRutaPropiedadesDesigualdad,
                    ),
                    //Serie taylor y MaClaurin
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.propiedadesRadicales,
                      ruta: kRutaPropiedadesRadicales,
                    ),
                    //Serie de Taylor y MaClaurin
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.serieTaylorMaclaurin,
                      ruta: kRutaSerieTaylorMaClaurin,
                    ),
                    //Teorema de la Sumatoria
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.teoremaSumatoria,
                      ruta: kRutaTeoremaSumatorias,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
