import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constantes/export_constantes.dart';

const _kFormulaeProductionImageOrigin = 'https://formulaeapps.com';

/// Allows a local landing server to supply the canonical diagrams during UI
/// review without changing the URLs used by release builds.
const _kFormulaeImageOrigin = String.fromEnvironment(
  'FORMULAE_IMAGE_ORIGIN',
  defaultValue: _kFormulaeProductionImageOrigin,
);

String resolveFormulaeImageUrl(String url) {
  if (_kFormulaeImageOrigin == _kFormulaeProductionImageOrigin ||
      !url.startsWith(_kFormulaeProductionImageOrigin)) {
    return url;
  }

  return '$_kFormulaeImageOrigin${url.substring(_kFormulaeProductionImageOrigin.length)}';
}

/// Displays remote Formulae diagrams with a bounded loading state.
///
/// The canonical host can be temporarily unavailable during an asset
/// promotion. A failed or stalled request must never leave an unbounded spinner
/// or raw broken-image glyph in the lesson.
class ZoomImagePersonalizado extends StatelessWidget {
  final String urlImagen;

  const ZoomImagePersonalizado({super.key, required this.urlImagen});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    final Widget image = ImagenRemotaRobusta(
      urlImagen: urlImagen,
      height: isMobile ? null : 300.0,
      width: isMobile ? null : double.infinity,
    );

    return isMobile || kIsWeb ? InteractiveViewer(child: image) : image;
  }
}

/// Cached remote image with a timeout fallback and a localized error state.
class ImagenRemotaRobusta extends StatefulWidget {
  final String urlImagen;
  final double? height;
  final double? width;

  const ImagenRemotaRobusta({
    super.key,
    required this.urlImagen,
    this.height,
    this.width,
  });

  @override
  State<ImagenRemotaRobusta> createState() => _ImagenRemotaRobustaState();
}

class _ImagenRemotaRobustaState extends State<ImagenRemotaRobusta> {
  static const Duration _timeoutCarga = Duration(seconds: 12);

  Timer? _timeoutTimer;
  bool _expirado = false;
  bool _cargado = false;

  @override
  void initState() {
    super.initState();
    _iniciarTimeout();
  }

  @override
  void didUpdateWidget(covariant ImagenRemotaRobusta oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.urlImagen != widget.urlImagen) {
      _cargado = false;
      _expirado = false;
      _iniciarTimeout();
    }
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _iniciarTimeout() {
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(_timeoutCarga, () {
      if (mounted && !_cargado) {
        setState(() => _expirado = true);
      }
    });
  }

  void _marcarCargada() {
    _cargado = true;
    _timeoutTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (_expirado) {
      return _PlaceholderImagen(
        error: true,
        height: widget.height,
        width: widget.width,
      );
    }

    return CachedNetworkImage(
      imageUrl: resolveFormulaeImageUrl(widget.urlImagen),
      fadeInDuration: const Duration(milliseconds: 150),
      imageBuilder: (context, imageProvider) {
        _marcarCargada();
        return Image(
          image: imageProvider,
          fit: BoxFit.contain,
          height: widget.height,
          width: widget.width,
        );
      },
      placeholder: (context, url) => _PlaceholderImagen(
        error: false,
        height: widget.height,
        width: widget.width,
      ),
      errorWidget: (context, url, error) {
        _marcarCargada();
        return _PlaceholderImagen(
          error: true,
          height: widget.height,
          width: widget.width,
        );
      },
    );
  }
}

class _PlaceholderImagen extends StatelessWidget {
  final bool error;
  final double? height;
  final double? width;

  const _PlaceholderImagen({
    required this.error,
    this.height,
    this.width,
  });

  static const Color _colorMuteado = Color(0xFF9294C0);
  static const Color _colorBorde = Color(0xFF4B4D7A);

  @override
  Widget build(BuildContext context) {
    final esCompacta = (width != null && width! <= 120) ||
        (height != null && height! <= 120);
    final Widget contenido = error
        ? esCompacta
            ? const Icon(
                Icons.image_not_supported_outlined,
                size: 24,
                color: _colorMuteado,
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.image_not_supported_outlined,
                    size: 40,
                    color: _colorMuteado,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.imagenNoDisponible,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: _colorMuteado,
                      fontSize: 13,
                    ),
                  ),
                ],
              )
        : const SizedBox(
            height: 28,
            width: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              valueColor: AlwaysStoppedAnimation<Color>(kColorAmarilloCapdesis),
            ),
          );

    return Container(
      height: height ?? 160,
      width: width,
      // Small logos and icons pass an explicit size. Do not force the generic
      // diagram minimum onto them, or their error placeholder would overflow
      // drawers and dialogs while the remote host is unavailable.
      constraints: BoxConstraints(
        minWidth: width == null ? 160 : 0,
        minHeight: height == null ? 96 : 0,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(esCompacta ? 4 : 12),
      decoration: BoxDecoration(
        color: kColorBotones,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _colorBorde),
      ),
      child: contenido,
    );
  }
}

class ZoomPersonalizado extends StatelessWidget {
  final Widget child;

  const ZoomPersonalizado({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: LayoutBuilder(
                  builder: (context, constraints) => InteractiveViewer(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: constraints.maxWidth),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          )
        : child;
  }
}
