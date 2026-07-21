import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Favorites/pdf_capture_scope.dart';
import '../constantes/export_constantes.dart';

const _kFormulaeProductionImageOrigin = 'https://formulaeapps.com';

/// Permite probar visualmente los diagramas contra un servidor local sin
/// alterar las URLs canónicas que consume la aplicación publicada.
///
/// Producción conserva `https://formulaeapps.com`. Por ejemplo, para una
/// revisión local de la landing se puede inyectar
/// `--dart-define=FORMULAE_IMAGE_ORIGIN=http://127.0.0.1:4321`.
const _kFormulaeImageOrigin = String.fromEnvironment(
  'FORMULAE_IMAGE_ORIGIN',
  defaultValue: _kFormulaeProductionImageOrigin,
);

/// Reescribe exclusivamente las URLs canónicas de Formulae cuando una
/// compilación local configura [FORMULAE_IMAGE_ORIGIN].
String resolveFormulaeImageUrl(String url) {
  if (_kFormulaeImageOrigin == _kFormulaeProductionImageOrigin ||
      !url.startsWith(_kFormulaeProductionImageOrigin)) {
    return url;
  }

  return '$_kFormulaeImageOrigin${url.substring(_kFormulaeProductionImageOrigin.length)}';
}

/// Muestra una imagen remota (formula o diagrama) de forma robusta.
///
/// El host de imagenes puede responder 404 o quedarse colgado sin resolver; en
/// ambos casos esta widget degrada con gracia en lugar de girar para siempre:
///   * el estado de carga esta acotado por un timeout ([_ImagenRemotaRobusta]);
///   * si la imagen falla o expira se muestra un placeholder oscuro con icono
///     en vez de un spinner infinito o el glifo crudo de imagen rota;
///   * conserva el zoom (InteractiveViewer) para las imagenes que SI cargan.
class ZoomImagePersonalizado extends StatelessWidget {
  final String urlImagen;

  const ZoomImagePersonalizado({super.key, required this.urlImagen});

  @override
  Widget build(BuildContext context) {
    if (PdfCaptureScope.of(context)) {
      return const SizedBox.shrink();
    }

    final bool isMobile =
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    final Widget imagen = ImagenRemotaRobusta(
      urlImagen: urlImagen,
      // En escritorio y web conservamos un encuadre estable; en movil dejamos
      // que la imagen tome su tamano natural dentro del InteractiveViewer.
      height: isMobile ? null : 300.0,
      width: isMobile ? null : double.infinity,
    );

    // Flutter web también debe mostrar los diagramas. El zoom mantiene las
    // etiquetas legibles en pantallas pequeñas sin ocultar contenido.
    return isMobile || kIsWeb ? InteractiveViewer(child: imagen) : imagen;
  }
}

/// Carga [urlImagen] mediante [CachedNetworkImage] y garantiza que el estado de
/// carga nunca sea infinito: un timeout de respaldo convierte una peticion
/// colgada en el placeholder de error, mientras que un 404 real cae de
/// inmediato en el mismo placeholder a traves de `errorWidget`.
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
  // Respaldo: si la peticion se cuelga (sin 404 ni exito) mostramos el
  // placeholder de error al vencer este tiempo, en lugar de girar sin fin.
  static const Duration _kTimeoutCarga = Duration(seconds: 12);

  Timer? _timeoutTimer;
  bool _expiro = false;
  bool _cargo = false;

  @override
  void initState() {
    super.initState();
    _arrancarTimeout();
  }

  @override
  void didUpdateWidget(covariant ImagenRemotaRobusta oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.urlImagen != widget.urlImagen) {
      _cargo = false;
      _expiro = false;
      _arrancarTimeout();
    }
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _arrancarTimeout() {
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(_kTimeoutCarga, () {
      if (mounted && !_cargo) {
        setState(() => _expiro = true);
      }
    });
  }

  void _marcarCargada() {
    _cargo = true;
    _timeoutTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (_expiro) {
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

/// Caja oscura, coherente con el tema navy (#27283D), usada tanto para el estado
/// de carga (spinner acotado) como para el estado de error (icono + etiqueta).
class _PlaceholderImagen extends StatelessWidget {
  final bool error;
  final double? height;
  final double? width;

  const _PlaceholderImagen({required this.error, this.height, this.width});

  static const Color _colorMuteado = Color(0xFF9294C0);
  static const Color _colorBorde = Color(0xFF4B4D7A);

  @override
  Widget build(BuildContext context) {
    final bool isCompact =
        (width != null && width! <= 120) || (height != null && height! <= 120);

    final Widget contenido = error
        ? isCompact
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
      constraints: BoxConstraints(
        minWidth: width == null ? 160 : 0,
        minHeight: height == null ? 96 : 0,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(isCompact ? 4 : 12),
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
    bool isMobile =
        !kIsWeb &&
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
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return InteractiveViewer(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth,
                        ),
                        child: child,
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : child;
  }
}
