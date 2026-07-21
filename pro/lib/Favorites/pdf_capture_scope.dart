import 'package:flutter/widgets.dart';

class PdfCaptureScope extends InheritedWidget {
  final bool isCapturing;

  const PdfCaptureScope({
    super.key,
    required this.isCapturing,
    required super.child,
  });

  static bool of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<PdfCaptureScope>()
            ?.isCapturing ??
        false;
  }

  @override
  bool updateShouldNotify(PdfCaptureScope oldWidget) {
    return oldWidget.isCapturing != isCapturing;
  }
}

// RepaintBoundary etiquetado con su formula LaTeX; el generador de PDF lo
// localiza en el arbol offscreen para capturar la formula como imagen.
class PdfFormulaBoundary extends RepaintBoundary {
  final String formulaText;

  const PdfFormulaBoundary({super.key, required this.formulaText, super.child});
}
