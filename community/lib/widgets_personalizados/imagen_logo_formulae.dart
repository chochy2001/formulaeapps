import 'package:flutter/cupertino.dart';

import '../../../constantes/export_constantes.dart';

class ImagenLogoFormulae extends StatelessWidget {
  const ImagenLogoFormulae({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImagenRemotaRobusta(
      height: 100.0,
      width: 100.0,
      urlImagen: kUrlImagenFormulae,
    );
  }
}
