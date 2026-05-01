import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class SolucionEcuaciones extends StatefulWidget {
  const SolucionEcuaciones({Key? key}) : super(key: key);

  @override
  SolucionEcuacionesState createState() => SolucionEcuacionesState();
}

class SolucionEcuacionesState extends State<SolucionEcuaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const ImagenLogoFormulae(),
                  Text(
                    AppLocalizations.of(context)!.solucionEcuaciones,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionesDePrimerGrado,
                    ruta: kRutaEcuacionesDePrimerGrado,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionesDeSegundoGrado,
                    ruta: kRutaEcuacionesDeSegundoGrado,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
