import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../secciones_app/ejercicios/alert_ejercicios.dart';
import '../widgets_personalizados/textos_personalizados.dart';
import '../widgets_personalizados/zoom_image_personalizado.dart';

void mostrarEjemplos(BuildContext context) {
  showDialog(
    //Sirve para que no se cierre la alerta al momento de darle clic afuera
    barrierDismissible: false,
    context: context,
    builder: (context) {
      //Nos construye la alerta
      return AlertEjercicios(
        ruta: '/propiedadesDeLosExponentesEjercicios',
        ejercicioEjemplo: Column(
          children: <Widget>[
            TextoEcuaciones(AppLocalizations.of(context)!.pregunta),
            const SizedBox(height: kEspacioEntreBotones - 10),
            const Latex(formulaText: r"(10\cdot 3)^2=\space ?"),
            const SizedBox(height: kEspacioEntreBotones),
            const SizedBox(height: kEspacioEntreBotones),
            TextoEcuaciones(AppLocalizations.of(context)!.respuesta),
            const SizedBox(height: kEspacioEntreBotones - 10),
            const Latex(formulaText: r"10^2\cdot3^2 = 900"),
          ],
        ),
        textoEjercicio: AppLocalizations.of(context)!.propiedadesExponentes,
      );
    },
  );
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
                  children: [
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
                    child: Text(
                      AppLocalizations.of(context)!.cerrar,
                      style: kTextoCerrar,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}
