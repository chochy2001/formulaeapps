import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuMatematicasFinancieras extends StatefulWidget {
  const MenuMatematicasFinancieras({super.key});

  @override
  MenuMatematicasFinancierasState createState() =>
      MenuMatematicasFinancierasState();
}

class MenuMatematicasFinancierasState
    extends State<MenuMatematicasFinancieras> {
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
                  AppLocalizations.of(context)!.matematicasFinancieras,
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
                    //Bicondicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.amortizacion,
                      ruta: kRutaAmortizacion,
                    ),
                    //Condicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .anualidadAnticipadaSimpleYCierta,
                      ruta: kRutaAnualidadAnticipadaSimpleYCierta,
                    ),
                    //Conectores Logicos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .anualidadVencidaSimpleYCierta,
                      ruta: kRutaAnualidadAnticipadaSimpleYCierta,
                    ),
                    //Conjuncion
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.descuentoCompuesto,
                      ruta: kRutaDescuentoCompuesto,
                    ),
                    //Disyuncion
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.descuentoSimple,
                      ruta: kRutaDescuentoSimple,
                    ),
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.interesCompuesto,
                      ruta: kRutaInteresCompuesto,
                    ),
                    //Leyes de la logica proposicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.interesSimple,
                      ruta: kRutaInteresSimple,
                    ),
                    //Leyes de la Teoria de Conjuntos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.saldoInsoluto,
                      ruta: kRutaSaldoInsoluto,
                    ),
                    //Leyes del Algebra de Boole
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.tasaDeInteresGlobal,
                      ruta: kRutaTasaDeInteresGlobal,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.tasaEfectiva,
                      ruta: kRutaTasaEfectiva,
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
