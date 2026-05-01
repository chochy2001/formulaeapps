import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Favorites/pdf_capture_scope.dart';
import '../constantes/export_constantes.dart';

class ZoomImagePersonalizado extends StatelessWidget {
  final String urlImagen;

  const ZoomImagePersonalizado({super.key, required this.urlImagen});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || PdfCaptureScope.of(context)) {
      return const SizedBox.shrink();
    }

    bool isMobile = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    Widget fadeInImage = isMobile
        ? CachedNetworkImage(
            imageUrl: urlImagen,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : FadeInImage(
            height: 300.0,
            width: double.infinity,
            placeholder: const AssetImage(kUrlImagenGifCarga),
            image: NetworkImage(urlImagen),
            imageErrorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          );

    return isMobile ? InteractiveViewer(child: fadeInImage) : fadeInImage;
  }
}

class ZoomPersonalizado extends StatelessWidget {
  final Widget child;

  const ZoomPersonalizado({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isMobile = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return InteractiveViewer(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: constraints.maxWidth),
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
