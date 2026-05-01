import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class AlgebraLinealMenu extends StatefulWidget {
  const AlgebraLinealMenu({Key? key}) : super(key: key);

  @override
  AlgebraLinealMenuState createState() => AlgebraLinealMenuState();
}

class AlgebraLinealMenuState extends State<AlgebraLinealMenu> {
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
                  AppLocalizations.of(context)!.algebraLineal,
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
                      textoBoton: AppLocalizations.of(context)!.determinantes,
                      ruta: kRutaDeterminantesAlgebraLineal,
                    ),
                    //Formulas de Productos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.matrices,
                      ruta: kRutaMenuMatricesAlgebraLineal,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.reglaCramer,
                      ruta: kRutaReglaDeCramer,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.reglaSarrus,
                      ruta: kRutaReglaDeSarrus,
                    ),
                    //Teorema de la Sumatoria
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.vectores,
                      ruta: kRutaMenuVectores,
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
