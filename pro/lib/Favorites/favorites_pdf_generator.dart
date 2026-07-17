import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chat_gpt/chat_gpt_button.dart';
import '../l10n/app_localizations.dart';
import '../widgets_personalizados/textos_personalizados.dart';
import 'favorite.dart';
import 'favorite_pdf_downloader.dart';
import 'pdf_capture_scope.dart';

// Tamano con el que las formulas se dibujan dentro del PDF. Escala el tamano
// fisico de la imagen capturada en la pagina sin tocar la nitidez de captura
// (pixelRatio) ni el respaldo de texto.
enum PdfFormulaSize {
  small,
  medium,
  large,
}

extension PdfFormulaSizeScale on PdfFormulaSize {
  double get scale {
    switch (this) {
      case PdfFormulaSize.small:
        return 0.78;
      case PdfFormulaSize.medium:
        return 1.0;
      case PdfFormulaSize.large:
        return 1.32;
    }
  }

  String get storageValue => name;
}

enum FormulaPdfBlockType {
  heading,
  text,
  formula,
}

class FormulaPdfBlock {
  final FormulaPdfBlockType type;
  final String text;

  // Imagen PNG de la formula renderizada; si es null el PDF usa el texto
  // como respaldo. width/height van en pixeles logicos.
  final Uint8List? image;
  final double imageWidth;
  final double imageHeight;

  const FormulaPdfBlock({
    required this.type,
    required this.text,
    this.image,
    this.imageWidth = 0,
    this.imageHeight = 0,
  });
}

class FavoriteFormulaContent {
  final String title;
  final List<FormulaPdfBlock> blocks;

  const FavoriteFormulaContent({
    required this.title,
    required this.blocks,
  });
}

class FavoritesPdfGenerator {
  static const Size _extractionSize = Size(760, 1100);
  static const int _formulaLineLength = 88;

  // Escala de captura de formulas (nitidez de impresion) y conversion de
  // pixeles logicos a puntos PDF (72 pt = 96 px).
  static const double _formulaPixelRatio = 3.0;
  static const double _formulaPointsPerPixel = 0.75;
  static const double _formulaMaxWidth = 470;

  // Ancho util de una pagina A4 con margenes de 24 pt (595.28 - 48). Las
  // formulas nunca deben superar este limite aunque el usuario elija "grande".
  static const double _pageUsableWidth = 545;

  // Clave de SharedPreferences para el tamano de formula elegido por el
  // usuario. Se comparte entre Ver PDF, Descargar PDF y exportar carpeta.
  static const String _formulaSizeStorageKey = 'pdfFormulaSize';

  // Solo para tests: desactiva la captura de imagenes para ejercitar el
  // respaldo de texto.
  @visibleForTesting
  static bool debugDisableFormulaCapture = false;

  // Lee el tamano de formula persistido; por defecto medium.
  static Future<PdfFormulaSize> loadFormulaSize() async {
    final prefs = await SharedPreferences.getInstance();
    return formulaSizeFromStorage(prefs.getString(_formulaSizeStorageKey));
  }

  static Future<void> saveFormulaSize(PdfFormulaSize size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_formulaSizeStorageKey, size.storageValue);
  }

  static PdfFormulaSize formulaSizeFromStorage(String? raw) {
    return PdfFormulaSize.values.firstWhere(
      (size) => size.storageValue == raw,
      orElse: () => PdfFormulaSize.medium,
    );
  }

  static Future<void> exportFolder({
    required BuildContext context,
    required FavoriteFolder folder,
    PdfFormulaSize size = PdfFormulaSize.medium,
  }) async {
    if (folder.favorites.isEmpty) {
      throw StateError('empty-folder');
    }

    final localizations = AppLocalizations.of(context)!;
    final contents = <FavoriteFormulaContent>[];
    for (final favorite in folder.favorites) {
      contents.add(await _extractFavoriteContent(context, favorite));
    }

    final pdfBytes = await _buildPdf(
      appTitle: localizations.formulaePro,
      folderName: folder.name,
      contents: contents,
      size: size,
    );
    await downloadFavoritePdf(
      pdfBytes,
      downloadFileNameForTitle(folder.name),
    );
  }

  // Genera el PDF y devuelve tambien el titulo real de la pantalla origen para
  // que el visor y el nombre de archivo puedan reutilizarlo.
  static Future<({String title, Uint8List bytes})> buildFavoritePdfDocument({
    required BuildContext context,
    required Favorite favorite,
    required String folderName,
    PdfFormulaSize size = PdfFormulaSize.medium,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    final content = await _extractFavoriteContent(context, favorite);

    final bytes = await _buildPdf(
      appTitle: localizations.formulaePro,
      folderName: folderName,
      contents: [content],
      size: size,
    );

    return (title: content.title, bytes: bytes);
  }

  static Future<Uint8List> buildFavoritePdfBytes({
    required BuildContext context,
    required Favorite favorite,
    required String folderName,
    PdfFormulaSize size = PdfFormulaSize.medium,
  }) async {
    final document = await buildFavoritePdfDocument(
      context: context,
      favorite: favorite,
      folderName: folderName,
      size: size,
    );

    return document.bytes;
  }

  static Future<void> exportFavorite({
    required BuildContext context,
    required Favorite favorite,
    required String folderName,
    PdfFormulaSize size = PdfFormulaSize.medium,
  }) async {
    final document = await buildFavoritePdfDocument(
      context: context,
      favorite: favorite,
      folderName: folderName,
      size: size,
    );

    await downloadFavoritePdf(
      document.bytes,
      downloadFileNameForTitle(document.title),
    );
  }

  // Extrae el contenido (titulo + bloques con las formulas capturadas como
  // imagen) de una pantalla. Lo usa el visor web para dibujar una vista previa
  // nativa fiel del PDF sin depender del visor de PDF del navegador.
  static Future<FavoriteFormulaContent> extractFavoriteFormulaContent({
    required BuildContext context,
    required Favorite favorite,
  }) {
    return _extractFavoriteContent(context, favorite);
  }

  // Construye los bytes del PDF a partir de un contenido ya extraido, evitando
  // volver a montar la pantalla offscreen. No depende de BuildContext para que
  // el visor pueda regenerar con otro tamano tras un await.
  static Future<Uint8List> buildPdfFromContents({
    required String appTitle,
    required String folderName,
    required List<FavoriteFormulaContent> contents,
    PdfFormulaSize size = PdfFormulaSize.medium,
  }) {
    return _buildPdf(
      appTitle: appTitle,
      folderName: folderName,
      contents: contents,
      size: size,
    );
  }

  static Future<FavoriteFormulaContent> _extractFavoriteContent(
    BuildContext context,
    Favorite favorite,
  ) async {
    final overlay =
        Overlay.maybeOf(context, rootOverlay: true) ?? Overlay.maybeOf(context);
    if (overlay == null) {
      throw StateError('overlay-not-found');
    }

    final favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    final rootKey = GlobalKey();
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (overlayContext) {
        return Positioned(
          left: -10000,
          top: -10000,
          width: _extractionSize.width,
          height: _extractionSize.height,
          child: IgnorePointer(
            child: TickerMode(
              enabled: false,
              child: ChangeNotifierProvider<FavoritesNotifier>.value(
                value: favoritesNotifier,
                child: Localizations.override(
                  context: context,
                  child: MediaQuery(
                    data: mediaQuery.copyWith(size: _extractionSize),
                    child: PdfCaptureScope(
                      isCapturing: true,
                      child: KeyedSubtree(
                        key: rootKey,
                        child: Material(
                          color: Colors.transparent,
                          child: SizedBox(
                            width: _extractionSize.width,
                            height: _extractionSize.height,
                            child: favorite.getWidget(overlayContext),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(entry);
    try {
      await WidgetsBinding.instance.endOfFrame;
      await Future<void>.delayed(Duration.zero);

      final collector = _FormulaWidgetCollector();
      final formulaImages = <String, _FormulaImage>{};
      final rootContext = rootKey.currentContext;
      if (rootContext != null && rootContext.mounted) {
        rootContext.visitChildElements(collector.collectFromElement);
        final boundaries = _collectFormulaBoundaries(rootContext);

        // Captura cada formula renderizada (RepaintBoundary) como PNG antes
        // de retirar el overlay; si falla, el bloque conserva solo el texto.
        for (final boundary in boundaries) {
          final key = boundary.formulaText.trim();
          if (key.isEmpty || formulaImages.containsKey(key)) {
            continue;
          }
          final image = await _captureFormulaImage(boundary.renderObject);
          if (image != null) {
            formulaImages[key] = image;
          }
        }
      }

      final blocks = collector.blocks
          .map((block) => _attachFormulaImage(block, formulaImages))
          .toList();

      return FavoriteFormulaContent(
        title: _resolveContentTitle(blocks, favorite.title),
        blocks: blocks,
      );
    } finally {
      entry.remove();
    }
  }

  // El titulo real de la formula proviene del encabezado que la pantalla
  // renderiza (TituloPersonalizado). Los botones VerPDF/DescargarPDF crean un
  // Favorite con un titulo generico ("Formulae PDF"), por lo que preferimos el
  // primer encabezado capturado y solo caemos al titulo guardado si la pantalla
  // no aporto uno.
  static String _resolveContentTitle(
    List<FormulaPdfBlock> blocks,
    String fallbackTitle,
  ) {
    for (final block in blocks) {
      if (block.type == FormulaPdfBlockType.heading &&
          block.text.trim().isNotEmpty) {
        return block.text.trim();
      }
    }

    return fallbackTitle.trim();
  }

  static List<_FormulaBoundaryHandle> _collectFormulaBoundaries(
    BuildContext rootContext,
  ) {
    final boundaries = <_FormulaBoundaryHandle>[];

    void visit(Element element) {
      final widget = element.widget;
      if (widget is PdfFormulaBoundary) {
        final renderObject = element.renderObject;
        if (renderObject is RenderRepaintBoundary) {
          boundaries.add(
            _FormulaBoundaryHandle(
              formulaText: widget.formulaText,
              renderObject: renderObject,
            ),
          );
        }
        return;
      }
      element.visitChildren(visit);
    }

    rootContext.visitChildElements(visit);
    return boundaries;
  }

  static Future<_FormulaImage?> _captureFormulaImage(
    RenderRepaintBoundary boundary,
  ) async {
    if (debugDisableFormulaCapture) {
      return null;
    }

    try {
      final image = await boundary.toImage(pixelRatio: _formulaPixelRatio);
      try {
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData == null || byteData.lengthInBytes == 0) {
          return null;
        }
        return _FormulaImage(
          bytes: byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          ),
          width: image.width / _formulaPixelRatio,
          height: image.height / _formulaPixelRatio,
        );
      } finally {
        image.dispose();
      }
    } catch (error) {
      // Si el renderer no soporta toImage (p.ej. HTML) se usa el texto.
      debugPrint('Formulae PDF formula capture failed: $error');
      return null;
    }
  }

  static FormulaPdfBlock _attachFormulaImage(
    FormulaPdfBlock block,
    Map<String, _FormulaImage> formulaImages,
  ) {
    if (block.type != FormulaPdfBlockType.formula) {
      return block;
    }

    final image = formulaImages[block.text.trim()];
    if (image == null) {
      return block;
    }

    return FormulaPdfBlock(
      type: block.type,
      text: block.text,
      image: image.bytes,
      imageWidth: image.width,
      imageHeight: image.height,
    );
  }

  static Future<Uint8List> _buildPdf({
    required String appTitle,
    required String folderName,
    required List<FavoriteFormulaContent> contents,
    PdfFormulaSize size = PdfFormulaSize.medium,
  }) async {
    final logoBytes = await _readAssetBytes('assets/images/capdesis_logo.png');
    final logoImage = pw.MemoryImage(logoBytes);
    final font = pw.Font.ttf(await rootBundle.load('fonts/Poppins-Bold.ttf'));
    final mathFont =
        pw.Font.ttf(await rootBundle.load('fonts/NotoSansMath-Regular.ttf'));
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        theme: pw.ThemeData.withFont(
          base: font,
          bold: font,
          italic: font,
          boldItalic: font,
          fontFallback: [mathFont],
        ),
        header: (_) => _buildHeader(
          logoImage: logoImage,
          title: appTitle,
          subtitle: folderName,
        ),
        footer: (pdfContext) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            '${pdfContext.pageNumber}/${pdfContext.pagesCount}',
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
        build: (_) => _buildPdfContent(contents, size),
      ),
    );

    return pdf.save();
  }

  static List<pw.Widget> _buildPdfContent(
    List<FavoriteFormulaContent> contents,
    PdfFormulaSize size,
  ) {
    final widgets = <pw.Widget>[];

    for (var index = 0; index < contents.length; index++) {
      final content = contents[index];
      if (index > 0) {
        widgets.add(pw.NewPage());
      }

      widgets
        ..add(pw.SizedBox(height: 12))
        ..add(
          pw.Text(
            content.title,
            style: pw.TextStyle(
              fontSize: 15,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        )
        ..add(pw.SizedBox(height: 10));

      if (content.blocks.isEmpty) {
        widgets.add(_buildTextBlock(content.title));
        continue;
      }

      for (final block in content.blocks) {
        switch (block.type) {
          case FormulaPdfBlockType.heading:
            if (block.text.trim() != content.title.trim()) {
              widgets.add(_buildHeadingBlock(block.text));
            }
          case FormulaPdfBlockType.text:
            widgets.add(_buildTextBlock(block.text));
          case FormulaPdfBlockType.formula:
            widgets.add(_buildFormulaBlock(block, size));
        }
      }
    }

    return widgets;
  }

  static pw.Widget _buildHeadingBlock(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 10, bottom: 6),
      child: pw.Text(
        text.trim(),
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget _buildTextBlock(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 7),
      child: pw.Text(
        text.trim(),
        style: const pw.TextStyle(fontSize: 10.5),
      ),
    );
  }

  static pw.Widget _buildFormulaBlock(FormulaPdfBlock block, PdfFormulaSize size) {
    final image = block.image;
    final pw.Widget child;

    if (image != null && block.imageWidth > 0 && block.imageHeight > 0) {
      // Escala pixeles logicos a puntos aplicando el tamano elegido; las
      // formulas anchas (matrices) se reducen proporcionalmente sin superar el
      // ancho util de la pagina.
      final pointsPerPixel = _formulaPointsPerPixel * size.scale;
      final maxWidth = math.min(_formulaMaxWidth * size.scale, _pageUsableWidth);
      var width = block.imageWidth * pointsPerPixel;
      var height = block.imageHeight * pointsPerPixel;
      if (width > maxWidth) {
        height = height * maxWidth / width;
        width = maxWidth;
      }

      child = pw.Center(
        child: pw.Image(
          pw.MemoryImage(image),
          width: width,
          height: height,
          fit: pw.BoxFit.contain,
        ),
      );
    } else {
      child = pw.Text(
        _formatFormulaForPdf(block.text),
        style: const pw.TextStyle(
          fontSize: 10.2,
          lineSpacing: 3,
        ),
      );
    }

    return pw.Container(
      width: double.infinity,
      margin: const pw.EdgeInsets.only(bottom: 9),
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        border: pw.Border.all(color: PdfColors.grey500, width: 0.5),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: child,
    );
  }

  static pw.Widget _buildHeader({
    required pw.ImageProvider logoImage,
    required String title,
    required String subtitle,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey400, width: 0.5),
        ),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Image(
            logoImage,
            width: 52,
            height: 52,
            fit: pw.BoxFit.contain,
          ),
          pw.SizedBox(width: 12),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                subtitle,
                style: const pw.TextStyle(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<Uint8List> _readAssetBytes(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  static String _formatFormulaForPdf(String formula) {
    final normalized = formula
        .replaceAll(r'\\', '\n')
        .replaceAll('&', '   ')
        .replaceAll(r'\left', '')
        .replaceAll(r'\right', '')
        .replaceAll(r'\cdot', ' · ')
        .replaceAll(r'\times', ' × ')
        .replaceAll(r'\nabla', '∇')
        .replaceAll(r'\partial', '∂')
        .replaceAll(r'\infty', '∞')
        .replaceAll(r'\pi', 'π')
        .replaceAll(r'\theta', 'θ')
        .replaceAll(r'\alpha', 'α')
        .replaceAll(r'\beta', 'β')
        .replaceAll(r'\gamma', 'γ')
        .replaceAll(r'\Delta', 'Δ')
        .replaceAll(r'\sum', 'Σ')
        .replaceAll(r'\int', '∫')
        .replaceAll(r'\oint', '∮')
        .replaceAll(r'\iint', '∬')
        .replaceAll(r'\iiint', '∭')
        .replaceAll(r'\,', ' ')
        .replaceAll(r'\;', ' ')
        .replaceAll(RegExp(r'[ \t]+'), ' ')
        .trim();

    return normalized
        .split('\n')
        .map(_wrapFormulaLine)
        .where((line) => line.trim().isNotEmpty)
        .join('\n');
  }

  static String _wrapFormulaLine(String line) {
    var remaining = line.trim();
    final wrapped = <String>[];

    while (remaining.length > _formulaLineLength) {
      var cut = _formulaLineLength;
      for (var index = _formulaLineLength; index > 48; index--) {
        final char = remaining[index];
        if (' =+-*/,]}'.contains(char)) {
          cut = index + 1;
          break;
        }
      }

      wrapped.add(remaining.substring(0, cut).trimRight());
      remaining = remaining.substring(cut).trimLeft();
    }

    if (remaining.isNotEmpty) {
      wrapped.add(remaining);
    }

    return wrapped.join('\n');
  }

  // Nombre de archivo del PDF derivado del titulo de la pantalla origen. El
  // saneado reutiliza _sanitizeFileName para producir algo como
  // "formulae_movimiento_de_proyectiles.pdf".
  static String downloadFileNameForTitle(String title) {
    return '${_sanitizeFileName(title)}.pdf';
  }

  static String _sanitizeFileName(String folderName) {
    final sanitized = folderName
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');

    if (sanitized.isEmpty) {
      return 'formulae_favoritos';
    }

    return 'formulae_$sanitized';
  }
}

class _FormulaBoundaryHandle {
  final String formulaText;
  final RenderRepaintBoundary renderObject;

  const _FormulaBoundaryHandle({
    required this.formulaText,
    required this.renderObject,
  });
}

class _FormulaImage {
  final Uint8List bytes;
  final double width;
  final double height;

  const _FormulaImage({
    required this.bytes,
    required this.width,
    required this.height,
  });
}

class _FormulaWidgetCollector {
  final List<FormulaPdfBlock> blocks = [];
  final Set<int> _visitedWidgets = {};

  void collectFromElement(Element element) {
    collectFromWidget(element.widget);
    element.visitChildren(collectFromElement);
  }

  void collectFromWidget(Widget? widget) {
    if (widget == null) {
      return;
    }

    final identity = identityHashCode(widget);
    if (!_visitedWidgets.add(identity)) {
      return;
    }

    if (widget is Latex) {
      _addBlock(FormulaPdfBlockType.formula, widget.formulaText);
      return;
    }

    if (widget is CapdesisLatex) {
      _addBlock(FormulaPdfBlockType.formula, CapdesisLatex.formulaCapdesis);
      return;
    }

    if (widget is TituloPersonalizado) {
      _addBlock(FormulaPdfBlockType.heading, widget.titulo);
      return;
    }

    if (widget is TextoEcuaciones) {
      _addBlock(FormulaPdfBlockType.text, widget.texto);
      return;
    }

    if (widget is TextoBotonesDelgado) {
      _addBlock(FormulaPdfBlockType.text, widget.texto);
      return;
    }

    if (widget is Scaffold) {
      collectFromWidget(widget.body);
      return;
    }

    if (widget is ChatGPTButton) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is Visibility) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is ListView) {
      _collectFromSliverDelegate(widget.childrenDelegate);
      return;
    }

    if (widget is MultiChildRenderObjectWidget) {
      for (final child in widget.children) {
        collectFromWidget(child);
      }
      return;
    }

    if (widget is SingleChildRenderObjectWidget) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is ProxyWidget) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is Container) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is SingleChildScrollView) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is GestureDetector) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is InkWell) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is AnimatedContainer) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is Card) {
      collectFromWidget(widget.child);
      return;
    }

    if (widget is Tooltip) {
      collectFromWidget(widget.child);
      return;
    }
  }

  void _collectFromSliverDelegate(SliverChildDelegate delegate) {
    if (delegate is SliverChildListDelegate) {
      for (final child in delegate.children) {
        collectFromWidget(child);
      }
    }
  }

  void _addBlock(FormulaPdfBlockType type, String text) {
    final cleanText = text.trim();
    if (cleanText.isEmpty) {
      return;
    }

    if (blocks.isNotEmpty &&
        blocks.last.type == type &&
        blocks.last.text.trim() == cleanText) {
      return;
    }

    blocks.add(FormulaPdfBlock(type: type, text: cleanText));
  }
}
