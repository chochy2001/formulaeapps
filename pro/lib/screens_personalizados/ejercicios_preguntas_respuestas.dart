import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';
import '../constantes/constantes_codigo.dart';

class PreguntasEjercicios extends StatelessWidget {
  final String texto;
  final Widget pregunta;

  const PreguntasEjercicios({
    super.key,
    required this.texto,
    required this.pregunta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Número de Pregunta
        Center(child: Text(texto, style: kTextoEcuaciones)),
        pregunta,
      ],
    );
  }
}

class RespuestaEjercicios extends StatelessWidget {
  final String texto;
  final Widget respuesta;

  const RespuestaEjercicios({
    super.key,
    required this.texto,
    required this.respuesta,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Número de Pregunta
        Center(child: Text(texto, style: kTextoEcuaciones)),
        respuesta,
      ],
    );
  }
}
