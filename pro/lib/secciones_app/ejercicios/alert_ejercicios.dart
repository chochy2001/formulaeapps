import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../../widgets_personalizados/textos_personalizados.dart';

class AlertEjercicios extends StatelessWidget {
  final String textoEjercicio, ruta;
  final Column ejercicioEjemplo;

  const AlertEjercicios(
      {Key? key,
      required this.textoEjercicio,
      required this.ejercicioEjemplo,
      required this.ruta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AlertDialog(
          backgroundColor: kColorFondo,
          //Hace que los Bortdes sean redondeados
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          title: TextoEcuaciones(
            AppLocalizations.of(context)!.ejercicios,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextoEcuaciones(
                textoEjercicio,
              ),
              //Imagen del logo capdesis para darle un mejor formato y más calidad
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: FadeInImage(
                  height: 100.0,
                  width: 100.0,
                  placeholder: AssetImage(kUrlImagenGifCarga),
                  image: NetworkImage(kUrlImagenFormulae),
                ),
              ),
              const SizedBox(height: kEspacioEntreBotones),
              ejercicioEjemplo,
              const SizedBox(height: kEspacioEntreBotones),
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
            TextButton(
              onPressed: () => Navigator.pushNamed(context, ruta),
              child: Text(
                AppLocalizations.of(context)!.verLosEjercicios,
                style: kTexto,
              ),
            )
          ],
        ),
      ],
    );
  }
}
