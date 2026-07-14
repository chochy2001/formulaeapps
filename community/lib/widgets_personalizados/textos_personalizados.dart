import 'dart:math' as math;

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
    // These labels live next to an expand/collapse icon inside cards as narrow
    // as 250 px. Scrolling a fixed 90%-of-screen box made the surrounding Wrap
    // overflow on phones; constrain and wrap the localized label instead.
    final maxTextWidth =
        (MediaQuery.of(context).size.width * 0.65).clamp(0.0, 220.0).toDouble();

    return SizedBox(
      width: maxTextWidth,
      child: Text(
        texto,
        style: kTextoBotonesDelgado,
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Latex extends StatelessWidget {
  final String formulaText;

  const Latex({super.key, required this.formulaText});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width * .95;
        final maxTextWidth = constraints.maxWidth.isFinite
            ? math.min(constraints.maxWidth, screenWidth)
            : screenWidth;

        return SizedBox(
          width: maxTextWidth,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: maxTextWidth),
              child: Center(
                child: Math.tex(
                  formulaText,
                  mathStyle: MathStyle.display,
                  textStyle: kTextoLatexFormulas,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CapdesisLatex extends StatelessWidget {
  const CapdesisLatex({super.key});

  @override
  Widget build(BuildContext context) {
    return Math.tex(r"\mathrm{CAPDESIS}",
        mathStyle: MathStyle.display, textStyle: kTextoLatexFormulas);
  }
}

class Notas extends StatelessWidget {
  const Notas({super.key});

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
