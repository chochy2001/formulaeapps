import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuMatematicasDiscretas extends StatefulWidget {
  const MenuMatematicasDiscretas({super.key});

  @override
  MenuMatematicasDiscretasState createState() =>
      MenuMatematicasDiscretasState();
}

class MenuMatematicasDiscretasState extends State<MenuMatematicasDiscretas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(visible: false),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              TextButton(onPressed: () {}, child: const ImagenLogoFormulae()),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.matematicasDiscretas,
                  style: kTextoBotones,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: MenuColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Bicondicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.bicondicional,
                      ruta: kRutaBicondicional,
                    ),
                    //Condicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.condicional,
                      ruta: kRutaCondicional,
                    ),
                    //Conectores Logicos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.conectoresLogicos,
                      ruta: kRutaConectoresLogicos,
                    ),
                    //Conjuncion
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.conjuncion,
                      ruta: kRutaConjuncion,
                    ),
                    //Disyuncion
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.disyuncion,
                      ruta: kRutaDisyuncion,
                    ),
                    //Leyes de la logica proposicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.leyesDeLaLogicaProposicional,
                      ruta: kRutaLeyesDeLaLogicaProposicional,
                    ),
                    //Leyes de la Teoria de Conjuntos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.leyesDeLaTeoriaDeConjuntos,
                      ruta: kRutaLeyesDeLaTeoriaDeConjuntos,
                    ),
                    //Leyes del Algebra de Boole
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(
                        context,
                      )!.leyesDelAlgebraDeBoole,
                      ruta: kRutaLeyesDelAlgebraDeBoole,
                    ),
                    //Negacion
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.negacion,
                      ruta: kRutaNegacion,
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
