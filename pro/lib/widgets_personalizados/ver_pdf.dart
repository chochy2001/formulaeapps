import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../Favorites/favorites_pdf_generator.dart';
import '../Favorites/pdf_capture_scope.dart';
import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';
import 'pdf_inline_viewer.dart';

bool isWebPlatform() {
  return kIsWeb;
}

class VerPDF extends StatefulWidget {
  final String url;

  const VerPDF({super.key, required this.url});

  @override
  VerPDFState createState() => VerPDFState();
}

class VerPDFState extends State<VerPDF> {
  bool _isGenerating = false;

  @override
  Widget build(BuildContext context) {
    if (widget.url == '' || PdfCaptureScope.of(context)) {
      return const SizedBox.shrink();
    }

    return BotonMenu(
      onPress: () async {
        if (!_isGenerating) {
          await _openGeneratedPdf(context);
        }
      },
      color: kColorBotones,
      cardChild: Center(
        child: Text(
          _isGenerating
              ? AppLocalizations.of(context)!.generandoPDF
              : AppLocalizations.of(context)!.verPDF,
          style: kTextoBotones,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _openGeneratedPdf(BuildContext context) async {
    setState(() {
      _isGenerating = true;
    });

    final localizations = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);
    final appTitle = localizations.formulaePro;
    final folderName = localizations.formulaePDF;
    try {
      final size = await FavoritesPdfGenerator.loadFormulaSize();

      if (!context.mounted) {
        return;
      }

      final content = await FavoritesPdfGenerator.extractFavoriteFormulaContent(
        context: context,
        favorite: Favorite(
          title: localizations.formulaePDF,
          widgetName: widget.url,
        ),
      );

      Future<Uint8List> buildBytes(PdfFormulaSize selectedSize) {
        return FavoritesPdfGenerator.buildPdfFromContents(
          appTitle: appTitle,
          folderName: folderName,
          contents: [content],
          size: selectedSize,
        );
      }

      // El visor de PDF nativo del navegador no se compone de forma fiable
      // dentro del arbol de Flutter web (CanvasKit), asi que en web mostramos una
      // vista previa nativa del mismo contenido. En movil el visor de Syncfusion
      // dibuja los bytes reales, por lo que se generan por adelantado.
      final initialBytes = kIsWeb ? null : await buildBytes(size);

      navigator.push(
        MaterialPageRoute(
          builder: (context) => VerPDFGenerado(
            previewContents: [content],
            pdfData: initialBytes,
            title: content.title,
            initialSize: size,
            buildBytes: buildBytes,
          ),
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Formulae PDF generation failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.mensajeError)));
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }
}

class VerPDFGenerado extends StatefulWidget {
  // Bytes del PDF real (visor Syncfusion en movil). Puede ser null en web,
  // donde se usa la vista previa nativa.
  final Uint8List? pdfData;

  // Contenido extraido para dibujar la vista previa nativa en web.
  final List<FavoriteFormulaContent>? previewContents;

  final String? title;
  final PdfFormulaSize initialSize;

  // Regenera los bytes del PDF con el tamano elegido (movil).
  final Future<Uint8List> Function(PdfFormulaSize size)? buildBytes;

  const VerPDFGenerado({
    super.key,
    this.pdfData,
    this.previewContents,
    this.title,
    this.initialSize = PdfFormulaSize.medium,
    this.buildBytes,
  });

  @override
  State<VerPDFGenerado> createState() => _VerPDFGeneradoState();
}

class _VerPDFGeneradoState extends State<VerPDFGenerado> {
  late PdfFormulaSize _size;
  Uint8List? _bytes;
  bool _isRegenerating = false;

  @override
  void initState() {
    super.initState();
    _size = widget.initialSize;
    _bytes = widget.pdfData;
  }

  bool get _canChangeSize =>
      widget.previewContents != null || widget.buildBytes != null;

  Future<void> _onSizeSelected(PdfFormulaSize size) async {
    if (size == _size) {
      return;
    }
    setState(() {
      _size = size;
    });
    unawaited(FavoritesPdfGenerator.saveFormulaSize(size));

    // En web la vista previa nativa se reescala sola; en movil hay que volver a
    // generar los bytes que dibuja el visor.
    if (!kIsWeb && widget.buildBytes != null) {
      setState(() {
        _isRegenerating = true;
      });
      try {
        final bytes = await widget.buildBytes!(size);
        if (!mounted) {
          return;
        }
        setState(() {
          _bytes = bytes;
          _isRegenerating = false;
        });
      } catch (error, stackTrace) {
        debugPrint('Formulae PDF resize failed: $error');
        debugPrintStack(stackTrace: stackTrace);
        if (mounted) {
          setState(() {
            _isRegenerating = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final resolvedTitle =
        (widget.title != null && widget.title!.trim().isNotEmpty)
        ? widget.title!.trim()
        : localizations.formulaePDF;

    return Scaffold(
      appBar: AppBar(
        title: Text(resolvedTitle),
        actions: [
          if (_canChangeSize)
            PdfFormulaSizeMenu(
              value: _size,
              onSelected: _isRegenerating ? null : _onSizeSelected,
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isRegenerating) {
      return const Center(
        child: SpinKitSpinningLines(color: Colors.white, size: 90.0),
      );
    }

    final previewContents = widget.previewContents;
    if (kIsWeb && previewContents != null) {
      return FormulaePdfPreview(contents: previewContents, size: _size);
    }

    final bytes = _bytes;
    if (bytes != null) {
      return buildPdfInlineViewer(bytes);
    }

    if (previewContents != null) {
      return FormulaePdfPreview(contents: previewContents, size: _size);
    }

    return const Center(
      child: SpinKitSpinningLines(color: Colors.white, size: 90.0),
    );
  }
}

// Menu de tamano de formula reutilizado por el visor. Persistencia y aplicacion
// del tamano las maneja quien lo consume.
class PdfFormulaSizeMenu extends StatelessWidget {
  final PdfFormulaSize value;
  final ValueChanged<PdfFormulaSize>? onSelected;

  const PdfFormulaSizeMenu({
    super.key,
    required this.value,
    required this.onSelected,
  });

  static String labelFor(BuildContext context, PdfFormulaSize size) {
    final localizations = AppLocalizations.of(context)!;
    switch (size) {
      case PdfFormulaSize.small:
        return localizations.tamanoFormulaPequeno;
      case PdfFormulaSize.medium:
        return localizations.tamanoFormulaMediano;
      case PdfFormulaSize.large:
        return localizations.tamanoFormulaGrande;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return PopupMenuButton<PdfFormulaSize>(
      enabled: onSelected != null,
      initialValue: value,
      tooltip: localizations.tamanoFormula,
      icon: const Icon(Icons.format_size_rounded),
      onSelected: onSelected,
      itemBuilder: (context) => PdfFormulaSize.values
          .map(
            (size) => PopupMenuItem<PdfFormulaSize>(
              value: size,
              child: Row(
                children: [
                  Icon(
                    size == value
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(labelFor(context, size)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// Vista previa nativa del PDF: dibuja el mismo contenido (titulo, encabezados,
// texto y las formulas ya capturadas como imagen) sobre una pagina clara, fiel a
// lo que se descarga. No depende del visor de PDF del navegador.
class FormulaePdfPreview extends StatelessWidget {
  final List<FavoriteFormulaContent> contents;
  final PdfFormulaSize size;

  const FormulaePdfPreview({
    super.key,
    required this.contents,
    required this.size,
  });

  static const Color _pageColor = Color(0xFFF7F7FB);
  static const Color _inkColor = Color(0xFF1A1A2E);
  static const Color _formulaBoxColor = Color(0xFFEDEDF3);
  static const Color _formulaBorderColor = Color(0xFFB8B8C8);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorFondo,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _pageColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildPages(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPages() {
    final widgets = <Widget>[];
    for (var i = 0; i < contents.length; i++) {
      if (i > 0) {
        widgets.add(const Divider(height: 40, color: _formulaBorderColor));
      }
      widgets.addAll(_buildContent(contents[i]));
    }
    return widgets;
  }

  List<Widget> _buildContent(FavoriteFormulaContent content) {
    final widgets = <Widget>[
      Text(
        content.title,
        style: const TextStyle(
          color: _inkColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
    ];

    if (content.blocks.isEmpty) {
      widgets.add(_textBlock(content.title));
      return widgets;
    }

    for (final block in content.blocks) {
      switch (block.type) {
        case FormulaPdfBlockType.heading:
          if (block.text.trim() != content.title.trim()) {
            widgets.add(_headingBlock(block.text));
          }
        case FormulaPdfBlockType.text:
          widgets.add(_textBlock(block.text));
        case FormulaPdfBlockType.formula:
          widgets.add(_formulaBlock(block));
      }
    }
    return widgets;
  }

  Widget _headingBlock(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        text.trim(),
        style: const TextStyle(
          color: _inkColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textBlock(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.trim(),
        style: const TextStyle(color: _inkColor, fontSize: 14, height: 1.35),
      ),
    );
  }

  Widget _formulaBlock(FormulaPdfBlock block) {
    final image = block.image;
    final Widget child;
    if (image != null && block.imageWidth > 0 && block.imageHeight > 0) {
      child = Center(
        child: Image.memory(
          image,
          width: block.imageWidth * size.scale,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      );
    } else {
      child = Text(
        block.text.trim(),
        style: const TextStyle(color: _inkColor, fontSize: 13, height: 1.4),
      );
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _formulaBoxColor,
        border: Border.all(color: _formulaBorderColor, width: 0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}

class DescargarPDF extends StatefulWidget {
  final String url;

  const DescargarPDF({super.key, required this.url});

  @override
  DescargarPDFState createState() => DescargarPDFState();
}

class DescargarPDFState extends State<DescargarPDF> {
  bool _isGenerating = false;

  @override
  Widget build(BuildContext context) {
    if (widget.url == '' || PdfCaptureScope.of(context)) {
      return const SizedBox.shrink();
    }

    return BotonMenu(
      onPress: () {
        if (!_isGenerating) {
          _downloadGeneratedPdf(context);
        }
      },
      color: kColorBotones,
      cardChild: Center(
        child: Text(
          _isGenerating
              ? AppLocalizations.of(context)!.generandoPDF
              : AppLocalizations.of(context)!.descargarImprimirPDF,
          style: kTextoBotones,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _downloadGeneratedPdf(BuildContext context) async {
    setState(() {
      _isGenerating = true;
    });

    final localizations = AppLocalizations.of(context)!;
    try {
      final size = await FavoritesPdfGenerator.loadFormulaSize();

      if (!context.mounted) {
        return;
      }

      await FavoritesPdfGenerator.exportFavorite(
        context: context,
        favorite: Favorite(
          title: localizations.formulaePDF,
          widgetName: widget.url,
        ),
        folderName: localizations.formulaePDF,
        size: size,
      );

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.pdfGenerado)));
    } catch (error, stackTrace) {
      debugPrint('Formulae PDF export failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.mensajeError)));
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }
}

class VerPDFNuevo extends StatefulWidget {
  final String pdfUrl;

  const VerPDFNuevo({super.key, required this.pdfUrl});

  @override
  VerPDFNuevoState createState() => VerPDFNuevoState();
}

class VerPDFNuevoState extends State<VerPDFNuevo> {
  Uint8List? _pdfData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _downloadPDF(widget.pdfUrl)
        .then((data) {
          if (!mounted) {
            return;
          }
          setState(() {
            _pdfData = data;
          });
        })
        .catchError((error) {
          if (!mounted) {
            return;
          }
          setState(() {
            _errorMessage = AppLocalizations.of(context)!.mensajeError;
          });
        });
  }

  Future<Uint8List> _downloadPDF(String url) async {
    try {
      final effectiveUrl = isWebPlatform() ? getCorsProxyUrl(url) : url;
      final response = await http
          .get(
            Uri.parse(effectiveUrl),
            headers: isWebPlatform() ? {'origin': 'localhost'} : {},
          )
          .timeout(const Duration(seconds: 12));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception(
          'Error al descargar el archivo PDF: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al descargar el archivo PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.formulaePDF)),
      body: _pdfData == null
          ? _errorMessage == null
                //todo cambiar por indicador de chat
                ? const Center(
                    child: SpinKitSpinningLines(
                      color: Colors.white,
                      size: 100.0,
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icono_app_nuevo.png',
                          width: 90,
                          height: 90,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            _errorMessage!,
                            style: kTextoBotonesDelgado,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _downloadPDF(widget.pdfUrl)
                                .then((data) {
                                  setState(() {
                                    _pdfData = data;
                                    _errorMessage = null;
                                  });
                                })
                                .catchError((error) {
                                  setState(() {
                                    _errorMessage = AppLocalizations.of(
                                      context,
                                    )!.mensajeError;
                                  });
                                });
                          },
                          child: Column(
                            children: [
                              Text(AppLocalizations.of(context)!.reintentar),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
          : buildPdfInlineViewer(_pdfData!),
    );
  }

  String getCorsProxyUrl(String pdfUrl) {
    const proxyUrl = 'https://cors-anywhere.herokuapp.com/';
    return '$proxyUrl$pdfUrl';
  }
}
