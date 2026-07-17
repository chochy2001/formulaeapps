import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../Favorites/pdf_capture_scope.dart';
import '../constantes/export_constantes.dart';
import 'formula_overflow.dart';

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
    if (PdfCaptureScope.of(context)) {
      return _buildParaCapturaPdf(formulaText);
    }

    // Presentacion en pantalla: cabe -> centra; se pasa poco -> reduce;
    // demasiado ancha -> scroll horizontal con desvanecido en los bordes para
    // que las formulas anchas nunca queden recortadas en silencio.
    return AdaptiveFormula(formulaText: formulaText);
  }
}

class CapdesisLatex extends StatelessWidget {
  static const String formulaCapdesis = r"\mathrm{CAPDESIS}";

  const CapdesisLatex({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (PdfCaptureScope.of(context)) {
      return _buildParaCapturaPdf(formulaCapdesis);
    }

    return Math.tex(formulaCapdesis,
        mathStyle: MathStyle.display, textStyle: kTextoLatexFormulas);
  }
}

// En modo captura la formula se pinta sin scroll horizontal (ancho
// intrinseco, sin recorte) y con el estilo oscuro para pagina blanca.
// El FittedBox solo escala la vista offscreen; la captura toma el
// RepaintBoundary a tamano completo.
Widget _buildParaCapturaPdf(String formulaText) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: PdfFormulaBoundary(
      formulaText: formulaText,
      child: Math.tex(
        formulaText,
        mathStyle: MathStyle.display,
        textStyle: kTextoLatexFormulasPdf,
      ),
    ),
  );
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
