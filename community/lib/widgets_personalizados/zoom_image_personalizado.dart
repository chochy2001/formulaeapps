import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constantes/export_constantes.dart';

class ZoomImagePersonalizado extends StatelessWidget {
  final String urlImagen;

  const ZoomImagePersonalizado({Key? key, required this.urlImagen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    Widget fadeInImage = FadeInImage(
      height: 300.0,
      width: double.infinity,
      placeholder: const AssetImage(kUrlImagenGifCarga),
      image: NetworkImage(urlImagen),
    );

    return isMobile ? InteractiveViewer(child: fadeInImage) : fadeInImage;
  }
}

class ZoomPersonalizado extends StatelessWidget {
  final Widget child;

  const ZoomPersonalizado({Key? key, required this.child}) : super(key: key);

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
