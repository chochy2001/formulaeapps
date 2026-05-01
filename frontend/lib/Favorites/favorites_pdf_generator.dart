import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../l10n/app_localizations.dart';
import 'favorite.dart';
import 'favorite_pdf_downloader.dart';
import 'pdf_capture_scope.dart';

class FavoriteFormulaCapture {
  final String title;
  final Uint8List imageBytes;

  FavoriteFormulaCapture({
    required this.title,
    required this.imageBytes,
  });
}

class FavoritesPdfGenerator {
  static const Size _captureSize = Size(760, 1100);

  static Future<void> exportFolder({
    required BuildContext context,
    required FavoriteFolder folder,
  }) async {
    if (folder.favorites.isEmpty) {
      throw StateError('empty-folder');
    }

    final localizations = AppLocalizations.of(context)!;
    final appTitle = localizations.formulaePro;
    final captures = <FavoriteFormulaCapture>[];
    for (final favorite in folder.favorites) {
      final imageBytes = await _captureFavorite(context, favorite);
      captures.add(
        FavoriteFormulaCapture(
          title: favorite.title,
          imageBytes: imageBytes,
        ),
      );
    }

    final pdfBytes = await _buildPdf(
      appTitle: appTitle,
      folderName: folder.name,
      captures: captures,
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
    final imageBytes = await _captureFavorite(context, favorite);

    return _buildPdf(
      appTitle: localizations.formulaePro,
      folderName: folderName,
      captures: [
        FavoriteFormulaCapture(
          title: favorite.title,
          imageBytes: imageBytes,
        ),
      ],
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

  static Future<Uint8List> _captureFavorite(
    BuildContext context,
    Favorite favorite,
  ) async {
    final favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    final captureController = ScreenshotController();
    final formulaWidget = favorite.getWidget(context);

    final captureRoot = ChangeNotifierProvider<FavoritesNotifier>.value(
      value: favoritesNotifier,
      child: Localizations.override(
        context: context,
        child: MediaQuery(
          data: mediaQuery.copyWith(size: _captureSize),
          child: PdfCaptureScope(
            isCapturing: true,
            child: SizedBox(
              width: _captureSize.width,
              height: _captureSize.height,
              child: formulaWidget,
            ),
          ),
        ),
      ),
    );

    return captureController.captureFromWidget(
      captureRoot,
      context: context,
      targetSize: _captureSize,
      pixelRatio: 1.6,
      delay: const Duration(milliseconds: 900),
    );
  }

  static Future<Uint8List> _buildPdf({
    required String appTitle,
    required String folderName,
    required List<FavoriteFormulaCapture> captures,
  }) async {
    final logoBytes = await _readAssetBytes('assets/images/capdesis_logo.png');
    final logoImage = pw.MemoryImage(logoBytes);
    final pdf = pw.Document();

    for (var index = 0; index < captures.length; index++) {
      final capture = captures[index];
      final formulaImage = pw.MemoryImage(capture.imageBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(24),
          build: (pdfContext) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                _buildHeader(
                  logoImage: logoImage,
                  title: appTitle,
                  subtitle: folderName,
                ),
                pw.SizedBox(height: 14),
                pw.Text(
                  capture.title,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Expanded(
                  child: pw.Center(
                    child: pw.Image(
                      formulaImage,
                      fit: pw.BoxFit.contain,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    '${index + 1}/${captures.length}',
                    style: const pw.TextStyle(fontSize: 9),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  static pw.Widget _buildHeader({
    required pw.ImageProvider logoImage,
    required String title,
    required String subtitle,
  }) {
    return pw.Row(
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
    );
  }

  static Future<Uint8List> _readAssetBytes(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
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
