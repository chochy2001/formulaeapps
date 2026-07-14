import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../secciones_app/ejercicios/alert_ejercicios.dart';

void mostrarEjemplos(BuildContext context) {
  showDialog(
      //Sirve para que no se cierre la alerta al momento de darle clic afuera
      barrierDismissible: false,
      context: context,
      builder: (context) {
        //Nos construye la alerta
        return const AlertEjercicios(
          ruta: '/propiedadesDeLosExponentesEjercicios',
          ejercicioEjemplo: Column(children: <Widget>[
            Latex(formulaText: r"\mathsf{Pregunta}"),
            SizedBox(height: kEspacioEntreBotones),
            Latex(formulaText: r"(10\cdot 3)^2=\space ?"),
            SizedBox(height: kEspacioEntreBotones),
            SizedBox(height: kEspacioEntreBotones),
            Latex(formulaText: r"\mathsf{Respuesta}"),
            SizedBox(height: kEspacioEntreBotones),
            Latex(formulaText: r"10^2\cdot3^2 = 900"),
          ]),
          textoEjercicio: 'Propiedades de los Exponentes',
        );
      });
}

void mostrarInfo(BuildContext context, String texto) {
  showDialog(
      //Sirve para que no se cierre la alerta al momento de darle clic afuera
      //barrierDismissible: false,
      context: context,
      builder: (context) {
        //Nos construye la alerta
        //center the widgets
        return ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AlertDialog(
                  backgroundColor: kColorFondo,
                  //Hace que los Bortdes sean redondeados
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  title: Center(
                    child: Text(
                      texto,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ImagenRemotaRobusta(
                        height: 100.0,
                        width: 100.0,
                        urlImagen: kUrlImagenFormulae,
                      ),
                    ],
                  ),
                  //Son los botones que aparecen en la seccion inferior (Cerrar y Ver los Ejercicios).
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cerrar',
                        style: kTextoCerrar,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      });
}
