import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';

import '../../constantes/export_constantes.dart';
import '../constantes/contantes_mapa_pdfs.dart';
import '../pdf/community_pdf_document.dart';
import '../pdf/community_pdf_downloader.dart';

typedef CommunityPdfBuilder =
    Future<Uint8List> Function(CommunityPdfContent content);
typedef CommunityPdfExporter =
    Future<void> Function(Uint8List bytes, String fileName);

class VerPDF extends StatefulWidget {
  final String url;
  @visibleForTesting
  final CommunityPdfBuilder? pdfBuilder;

  const VerPDF({super.key, required this.url, this.pdfBuilder});

  @override
  State<VerPDF> createState() => _VerPDFState();
}

class _VerPDFState extends State<VerPDF> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  Future<void> _openPdf(CommunityPdfContent content) async {
    await _ads.showInterstitialIfReady();
    if (!mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => VerPDFNuevo(
          pdfUrl: 'local:${widget.url}',
          pdfTitle: content.title,
          pdfLoader: (_) =>
              (widget.pdfBuilder ?? CommunityPdfDocument.build)(content),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final legacyUrl = getUrlPdfById(context, widget.url);
    if (legacyUrl == null || widget.url.isEmpty) {
      return const SizedBox.shrink();
    }

    final content = _localPdfContent(
      context,
      resourceId: widget.url,
      legacyUrl: legacyUrl,
    );

    return TextButton(
      onPressed: () => _openPdf(content),
      child: _PdfActionCard(
        widthFactor: 0.4,
        label: AppLocalizations.of(context)!.verPDF,
      ),
    );
  }
}

class DescargarPDF extends StatefulWidget {
  final String url;
  @visibleForTesting
  final CommunityPdfBuilder? pdfBuilder;
  @visibleForTesting
  final CommunityPdfExporter? pdfExporter;

  const DescargarPDF({
    super.key,
    required this.url,
    this.pdfBuilder,
    this.pdfExporter,
  });

  @override
  State<DescargarPDF> createState() => _DescargarPDFState();
}

class _DescargarPDFState extends State<DescargarPDF> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  Future<void> _exportPdf(CommunityPdfContent content) async {
    await _ads.showInterstitialIfReady();
    if (!mounted) return;

    try {
      final bytes = await (widget.pdfBuilder ?? CommunityPdfDocument.build)(
        content,
      );
      if (!CommunityPdfDocument.hasPdfSignature(bytes)) {
        throw const FormatException(
          'Local PDF generator returned invalid data',
        );
      }

      await (widget.pdfExporter ?? downloadCommunityPdf)(
        bytes,
        CommunityPdfDocument.fileNameForTitle(content.title),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pdfExportado)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noSePudoExportarPDF),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final legacyUrl = getUrlPdfById(context, widget.url);
    if (legacyUrl == null || widget.url.isEmpty) {
      return const SizedBox.shrink();
    }

    final content = _localPdfContent(
      context,
      resourceId: widget.url,
      legacyUrl: legacyUrl,
    );

    return TextButton(
      onPressed: () => _exportPdf(content),
      child: _PdfActionCard(
        widthFactor: 0.7,
        label: AppLocalizations.of(context)!.descargarImprimirPDF,
      ),
    );
  }
}

CommunityPdfContent _localPdfContent(
  BuildContext context, {
  required String resourceId,
  required String legacyUrl,
}) {
  final localizations = AppLocalizations.of(context)!;
  return CommunityPdfContent(
    appTitle: localizations.formulaePro,
    title: CommunityPdfDocument.titleFromLegacyUrl(
      legacyUrl: legacyUrl,
      fallbackId: resourceId,
      languageCode: Localizations.localeOf(context).languageCode,
    ),
    generatedLocallyMessage: localizations.pdfGeneradoLocalmente,
    lessonHint: localizations.consultaLaLeccionEnLaApp,
  );
}

class _PdfActionCard extends StatelessWidget {
  final double widthFactor;
  final String label;

  const _PdfActionCard({required this.widthFactor, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColorBotones,
        border: Border.all(color: kColorFondo, width: 8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * widthFactor,
            child: Text(
              label,
              style: kTextoBotones,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class VerPDFNuevo extends StatefulWidget {
  final String pdfUrl;
  final String? pdfTitle;
  @visibleForTesting
  final Future<Uint8List> Function(String resource)? pdfLoader;

  const VerPDFNuevo({
    super.key,
    required this.pdfUrl,
    this.pdfTitle,
    this.pdfLoader,
  });

  @override
  State<VerPDFNuevo> createState() => VerPDFNuevoState();
}

class VerPDFNuevoState extends State<VerPDFNuevo> {
  Uint8List? _pdfData;
  bool _loading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    if (mounted) {
      setState(() {
        _loading = true;
        _hasError = false;
        _pdfData = null;
      });
    }

    try {
      final loader = widget.pdfLoader;
      if (loader == null) {
        throw StateError('No local PDF loader was configured');
      }

      final data = await loader(widget.pdfUrl);
      if (!CommunityPdfDocument.hasPdfSignature(data)) {
        throw const FormatException(
          'Local PDF data does not contain a PDF header',
        );
      }
      if (!mounted) return;
      setState(() {
        _pdfData = data;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.pdfTitle ?? localizations.formulaePDF)),
      body: _pdfData != null
          ? SfPdfViewer.memory(_pdfData!)
          : _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.picture_as_pdf_outlined, size: 44),
                    const SizedBox(height: 12),
                    Text(
                      localizations.pdfNoDisponible,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _hasError ? _loadPdf : null,
                      icon: const Icon(Icons.refresh),
                      label: Text(localizations.reintentar),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
