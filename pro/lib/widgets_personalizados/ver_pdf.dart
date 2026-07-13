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
    try {
      final document = await FavoritesPdfGenerator.buildFavoritePdfDocument(
        context: context,
        favorite: Favorite(
          title: localizations.formulaePDF,
          widgetName: widget.url,
        ),
        folderName: localizations.formulaePDF,
      );

      if (!context.mounted) {
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerPDFGenerado(
            pdfData: document.bytes,
            title: document.title,
          ),
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Formulae PDF generation failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.mensajeError)),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }
}

class VerPDFGenerado extends StatelessWidget {
  final Uint8List pdfData;
  final String? title;

  const VerPDFGenerado({super.key, required this.pdfData, this.title});

  @override
  Widget build(BuildContext context) {
    final resolvedTitle = (title != null && title!.trim().isNotEmpty)
        ? title!.trim()
        : AppLocalizations.of(context)!.formulaePDF;

    return Scaffold(
      appBar: AppBar(
        title: Text(resolvedTitle),
      ),
      body: buildPdfInlineViewer(pdfData),
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
      await FavoritesPdfGenerator.exportFavorite(
        context: context,
        favorite: Favorite(
          title: localizations.formulaePDF,
          widgetName: widget.url,
        ),
        folderName: localizations.formulaePDF,
      );

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.pdfGenerado)),
      );
    } catch (error, stackTrace) {
      debugPrint('Formulae PDF export failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.mensajeError)),
      );
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
    _downloadPDF(widget.pdfUrl).then((data) {
      if (!mounted) {
        return;
      }
      setState(() {
        _pdfData = data;
      });
    }).catchError((error) {
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
            'Error al descargar el archivo PDF: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al descargar el archivo PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.formulaePDF,
        ),
      ),
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
                          _downloadPDF(widget.pdfUrl).then((data) {
                            setState(() {
                              _pdfData = data;
                              _errorMessage = null;
                            });
                          }).catchError((error) {
                            setState(() {
                              _errorMessage =
                                  AppLocalizations.of(context)!.mensajeError;
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
