import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../constantes/export_constantes.dart';

class TituloPersonalizado extends StatelessWidget {
  final String titulo;

  const TituloPersonalizado(this.titulo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: kTextoBotones,
      textAlign: TextAlign.center,
    );
  }
}

class TextoEcuaciones extends StatelessWidget {
  final String texto;

  const TextoEcuaciones(this.texto, {super.key});

  @override
  Widget build(BuildContext context) {
    // Calcula el ancho máximo del texto en función del tamaño de la pantalla.
    double maxTextWidth = MediaQuery.of(context).size.width * 0.9;

    return SingleChildScrollView(
      child: SizedBox(
        width: maxTextWidth,
        child: Text(
          texto,
          style: kTextoEcuaciones,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TextoBotonesDelgado extends StatelessWidget {
  final String texto;

  const TextoBotonesDelgado(this.texto, {super.key});

  @override
  Widget build(BuildContext context) {
    // Calcula el ancho máximo del texto en función del tamaño de la pantalla.
    double maxTextWidth = MediaQuery.of(context).size.width * 0.9;

    return SingleChildScrollView(
      child: SizedBox(
        width: maxTextWidth,
        child: Text(
          texto,
          style: kTextoBotonesDelgado,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Latex extends StatelessWidget {
  final String formulaText;

  const Latex({super.key, required this.formulaText});

  @override
  Widget build(BuildContext context) {
    double maxTextWidth = MediaQuery.of(context).size.width * .95;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: maxTextWidth,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                formulaText,
                mathStyle: MathStyle.display,
                textStyle: kTextoLatexFormulas,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CapdesisLatex extends StatelessWidget {
  const CapdesisLatex({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Math.tex(r"\mathrm{CAPDESIS}",
        mathStyle: MathStyle.display, textStyle: kTextoLatexFormulas);
  }
}

class Notas extends StatelessWidget {
  const Notas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.notas,
        style: kTextoBotones,
      ),
    );
  }
}
