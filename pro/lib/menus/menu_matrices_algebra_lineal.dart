import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuMatricesLineal extends StatefulWidget {
  const MenuMatricesLineal({Key? key}) : super(key: key);

  @override
  MenuMatricesLinealState createState() => MenuMatricesLinealState();
}

class MenuMatricesLinealState extends State<MenuMatricesLineal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
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
                  AppLocalizations.of(context)!.matrices,
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
                    //Ecuaciones Lineales
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.matrizAdjunta,
                      ruta: kRutaMatrizAdjunta,
                    ),
                    //Formula General
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.matrizIdentidad,
                      ruta: kRutaMatrizIdentidad,
                    ),
                    //Formulas de Productos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.matrizInversa,
                      ruta: kRutaMatrizInversa,
                    ),
                    //Formulas de Factorizacion
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.matrizOrtogonal,
                      ruta: kRutaMatrizOrtogonal,
                    ),
                    //Numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.matrizSimetrica,
                      ruta: kRutaMatrizSimetrica,
                    ),
                    //Operaciones con Fracciones Algebraicas
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.matrizTranspuesta,
                      ruta: kRutaMatrizTranspuesta,
                    ),
                    //Propiedades de los Exponentes
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.matrizTriangular,
                      ruta: kRutaMatrizTriangular,
                    ),
                    //Propiedades de las Desigualdades
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .multiplicacionDeMatrices,
                      ruta: kRutaMultiplicacionDeMatrices,
                    ),
                    //Propiedades de los radicales
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .propiedadesDeLasMatrices,
                      ruta: kRutaPropiedadesDeLasMatrices,
                    ),
                    //Serie taylor y MaClaurin
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.sumaYRestaDeMatrices,
                      ruta: kRutaSumaRestaDeMatrices,
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
