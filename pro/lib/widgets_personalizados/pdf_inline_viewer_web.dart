// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';

// En Flutter web (CanvasKit) SfPdfViewer.memory se dibuja en blanco porque no
// pinta el PDF sobre el lienzo. En su lugar embebemos el PDF con un Blob y un
// <iframe>, de modo que el visor de PDF nativo del navegador renderiza el
// contenido (las formulas van como imagenes) dentro de la app.
Widget buildPdfInlineViewer(Uint8List pdfData) {
  return _WebPdfInlineViewer(pdfData);
}

class _WebPdfInlineViewer extends StatefulWidget {
  final Uint8List pdfData;

  const _WebPdfInlineViewer(this.pdfData);

  @override
  State<_WebPdfInlineViewer> createState() => _WebPdfInlineViewerState();
}

class _WebPdfInlineViewerState extends State<_WebPdfInlineViewer> {
  late final String _viewType;
  late final String _objectUrl;

  @override
  void initState() {
    super.initState();

    final blob = html.Blob(<Uint8List>[widget.pdfData], 'application/pdf');
    _objectUrl = html.Url.createObjectUrlFromBlob(blob);

    // Un viewType unico por instancia evita reutilizar un iframe con bytes de un
    // PDF anterior cuando se abren varias formulas en la misma sesion.
    _viewType =
        'formulae-pdf-iframe-${identityHashCode(this)}-${DateTime.now().microsecondsSinceEpoch}';

    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) => html.IFrameElement()
        ..src = _objectUrl
        ..title = 'Formulae PDF'
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%',
    );
  }

  @override
  void dispose() {
    html.Url.revokeObjectUrl(_objectUrl);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
