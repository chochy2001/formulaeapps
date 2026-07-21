import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Content that can be rendered into Formulae Community's offline PDF sheet.
///
/// The legacy resource host is no longer available. This model deliberately
/// describes the document as an in-app study sheet instead of representing it
/// as a recovered copy of the historical remote PDF.
class CommunityPdfContent {
  final String appTitle;
  final String title;
  final String generatedLocallyMessage;
  final String lessonHint;

  const CommunityPdfContent({
    required this.appTitle,
    required this.title,
    required this.generatedLocallyMessage,
    required this.lessonHint,
  });
}

/// Builds small, self-contained PDF documents without a network request.
class CommunityPdfDocument {
  const CommunityPdfDocument._();

  static Future<Uint8List> build(CommunityPdfContent content) async {
    final fontData = await rootBundle.load('fonts/Poppins-Bold.ttf');
    final font = pw.Font.ttf(fontData);
    final document = pw.Document();

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pw.ThemeData.withFont(
          base: font,
          bold: font,
          italic: font,
          boldItalic: font,
        ),
        header: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              content.appTitle,
              style: pw.TextStyle(
                color: PdfColors.blue900,
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Divider(color: PdfColors.blueGrey300),
          ],
        ),
        footer: (context) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            '${context.pageNumber}/${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
        build: (_) => [
          pw.SizedBox(height: 24),
          pw.Text(
            content.title,
            style: pw.TextStyle(fontSize: 21, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue50,
              border: pw.Border.all(color: PdfColors.blue200),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Text(
              content.generatedLocallyMessage,
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
          pw.SizedBox(height: 18),
          pw.Text(
            content.lessonHint,
            style: const pw.TextStyle(fontSize: 11, lineSpacing: 3),
          ),
        ],
      ),
    );

    return document.save();
  }

  static bool hasPdfSignature(Uint8List bytes) {
    return bytes.length >= 5 &&
        bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46 &&
        bytes[4] == 0x2D;
  }

  /// Uses the already-declared legacy map as a locale-aware title registry.
  /// No URL returned here is opened or fetched.
  static String titleFromLegacyUrl({
    required String? legacyUrl,
    required String fallbackId,
    required String languageCode,
  }) {
    var title = (legacyUrl ?? '')
        .split('/')
        .last
        .split('?')
        .first
        .split('#')
        .first;

    try {
      title = Uri.decodeFull(title);
    } catch (_) {
      title = '';
    }

    title = title
        .replaceFirst(RegExp(r'\.pdf$', caseSensitive: false), '')
        .replaceAll('uPrima', '')
        .replaceAll(RegExp(r'[_-]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (languageCode == 'en' && title.length > 1 && title.endsWith('I')) {
      title = title.substring(0, title.length - 1).trim();
    }

    if (title.isEmpty) {
      return _humanizeIdentifier(fallbackId);
    }

    return _separateCamelCase(title);
  }

  static String fileNameForTitle(String title) {
    final normalized = _removeDiacritics(title)
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
    final safeTitle = normalized.isEmpty ? 'documento' : normalized;
    return 'formulae_$safeTitle.pdf';
  }

  static String _humanizeIdentifier(String resourceId) {
    final title = resourceId.replaceFirst(RegExp(r'^kWidget'), '').trim();
    if (title.isEmpty) {
      return 'Formulae Community';
    }
    return _separateCamelCase(title);
  }

  static String _separateCamelCase(String value) {
    return value
        .replaceAllMapped(
          RegExp(r'([a-záéíóúüñ])([A-Z])'),
          (match) => '${match[1]} ${match[2]}',
        )
        .replaceAllMapped(
          RegExp(r'([A-Z])([A-Z][a-z])'),
          (match) => '${match[1]} ${match[2]}',
        )
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static String _removeDiacritics(String value) {
    const accents = 'áàäâÁÀÄÂéèëêÉÈËÊíìïîÍÌÏÎóòöôÓÒÖÔúùüûÚÙÜÛñÑçÇ';
    const plain = 'aaaaAAAAeeeeEEEEiiiiIIIIooooOOOOuuuuUUUUnNcC';
    var normalized = value;
    for (var index = 0; index < accents.length; index++) {
      normalized = normalized.replaceAll(accents[index], plain[index]);
    }
    return normalized;
  }
}
