import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// En movil/escritorio SfPdfViewer.memory renderiza las paginas correctamente,
// asi que se mantiene el visor nativo de Syncfusion.
Widget buildPdfInlineViewer(Uint8List pdfData) {
  return SfPdfViewer.memory(pdfData);
}
