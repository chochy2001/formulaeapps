import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

import '../chat_gpt/chat_gpt_button.dart';
import '../l10n/app_localizations.dart';
import '../widgets_personalizados/textos_personalizados.dart';
import 'favorite.dart';
import 'favorite_pdf_downloader.dart';
import 'pdf_capture_scope.dart';

enum FormulaPdfBlockType {
  heading,
  text,
  formula,
}

class FormulaPdfBlock {
  final FormulaPdfBlockType type;
  final String text;

  const FormulaPdfBlock({
    required this.type,
    required this.text,
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

  static Future<void> exportFolder({
    required BuildContext context,
    required FavoriteFolder folder,
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
    );
    await downloadFavoritePdf(
      pdfBytes,
      '${_sanitizeFileName(folder.name)}.pdf',
    );
  }

  static Future<Uint8List> buildFavoritePdfBytes({
    required BuildContext context,
    required Favorite favorite,
    required String folderName,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    final content = await _extractFavoriteContent(context, favorite);

    return _buildPdf(
      appTitle: localizations.formulaePro,
      folderName: folderName,
      contents: [content],
    );
  }

  static Future<void> exportFavorite({
    required BuildContext context,
    required Favorite favorite,
    required String folderName,
  }) async {
    final pdfBytes = await buildFavoritePdfBytes(
      context: context,
      favorite: favorite,
      folderName: folderName,
    );

    await downloadFavoritePdf(
      pdfBytes,
      '${_sanitizeFileName(favorite.title)}.pdf',
    );
  }

  @visibleForTesting
  static Future<FavoriteFormulaContent> extractFavoriteFormulaContent({
    required BuildContext context,
    required Favorite favorite,
  }) {
    return _extractFavoriteContent(context, favorite);
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
      final rootContext = rootKey.currentContext;
      if (rootContext != null && rootContext.mounted) {
        rootContext.visitChildElements(collector.collectFromElement);
      }

      return FavoriteFormulaContent(
        title: favorite.title,
        blocks: collector.blocks,
      );
    } finally {
      entry.remove();
    }
  }

  static Future<Uint8List> _buildPdf({
    required String appTitle,
    required String folderName,
    required List<FavoriteFormulaContent> contents,
  }) async {
    final logoBytes = await _readAssetBytes('assets/images/capdesis_logo.png');
    final logoImage = pw.MemoryImage(logoBytes);
    final font = pw.Font.ttf(await rootBundle.load('fonts/Poppins-Bold.ttf'));
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
        build: (_) => _buildPdfContent(contents),
      ),
    );

    return pdf.save();
  }

  static List<pw.Widget> _buildPdfContent(
    List<FavoriteFormulaContent> contents,
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
            widgets.add(_buildFormulaBlock(block.text));
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

  static pw.Widget _buildFormulaBlock(String formula) {
    return pw.Container(
      width: double.infinity,
      margin: const pw.EdgeInsets.only(bottom: 9),
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        border: pw.Border.all(color: PdfColors.grey500, width: 0.5),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Text(
        _formatFormulaForPdf(formula),
        style: const pw.TextStyle(
          fontSize: 10.2,
          lineSpacing: 3,
        ),
      ),
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
      _addBlock(FormulaPdfBlockType.formula, r'\mathrm{CAPDESIS}');
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
