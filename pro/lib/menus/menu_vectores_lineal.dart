import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuVectoresLineal extends StatefulWidget {
  const MenuVectoresLineal({super.key});

  @override
  MenuVectoresLinealState createState() => MenuVectoresLinealState();
}

class MenuVectoresLinealState extends State<MenuVectoresLineal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              TextButton(onPressed: () {}, child: const ImagenLogoFormulae()),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.vectores,
                  style: kTextoBotones,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: MenuColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Ecuaciones Lineales
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.anguloEntreVectores,
                      ruta: kRutaAnguloEntreVectores,
                    ),
                    //Formulas de Productos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.normalizacion,
                      ruta: kRutaNormalizacion,
                    ),
                    //Formula General
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.operacionesConVectores,
                      ruta: kRutaOperacionesConVectores,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.productoCruz,
                      ruta: kRutaProductoCruz,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.productoPunto,
                      ruta: kRutaProductoPunto,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.propiedadesDeLosVectores,
                      ruta: kRutaPropiedadesDeLosVectores,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.proyeccionesDeVectores,
                      ruta: kRutaProyeccionesDeVectores,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.vectorUnitario,
                      ruta: kRutaVectorUnitario,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.vectoresYSuMagnitud,
                      ruta: kRutaVectoresYSuMagnitud,
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
