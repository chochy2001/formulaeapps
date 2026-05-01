import 'package:flutter/cupertino.dart';

import '../../../constantes/export_constantes.dart';

class ImagenLogoFormulae extends StatelessWidget {
  const ImagenLogoFormulae({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FadeInImage(
      height: 100.0,
      width: 100.0,
      placeholder: AssetImage(kUrlImagenGifCarga),
      image: NetworkImage(kUrlImagenFormulae),
    );
  }
}
