import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class NumerosComplejos extends StatefulWidget {
  const NumerosComplejos({super.key});

  @override
  NumerosComplejosState createState() => NumerosComplejosState();
}

class NumerosComplejosState extends State<NumerosComplejos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const ImagenLogoFormulae(),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.numerosComplejos,
                        style: kTextoBotones,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //Conjugados de numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .conjugadoDeUnNumeroComplejo,
                      ruta: kRutaConjugadoNumerosComplejos,
                    ),
                    //Modulo y Argumento numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .moduloYArgumentoDeUnNumeroComplejo,
                      ruta: kRutaModuloyArgumentoNumerosComplejos,
                    ),
                    //Operaciones de Numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .operacionesDeNumerosComplejos,
                      ruta: kRutaOperacionesNumerosComplejos,
                    ),
                    //Propiedades Números Complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .propiedadesDeLosNumerosComplejos,
                      ruta: kRutaPropiedadesNumerosComplejos,
                    ),
                    //Representaciones de Numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .representacionesDeUnNumeroComplejo,
                      ruta: kRutaRepresentacionesDeNumerosComplejos,
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
