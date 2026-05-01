import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constantes/contantes_mapa_pdfs.dart';
import '../constantes/export_constantes.dart';
import '../screens_personalizados/configuracion.dart';

openURL(String url) {
  //todo actualizar despues este paquete
  // ignore: deprecated_member_use
  launch(url);
}

void openURLNuevo1(BuildContext context, String id) {
  Locale currentLocale =
      Provider.of<LocaleProvider>(context, listen: false).locale;
  Map<String, String>? urlMap = urlPdfMap[id];

  if (urlMap != null) {
    String? url = urlMap[currentLocale.languageCode];
    if (url != null) {
      launchUrl(
        Uri.parse(url).removeFragment(),
      );
    } else {
      // manejar el caso cuando no hay URL para el idioma del dispositivo
    }
  } else {
    // manejar el caso cuando no hay URL para el ID proporcionado
  }
}

openURLNuevo(String url) {
  launchUrl(
    Uri.parse(url).removeFragment(),
  );
}
