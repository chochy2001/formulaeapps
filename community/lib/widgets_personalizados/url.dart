import 'package:url_launcher/url_launcher.dart';

openURL(String url) {
  //todo actualizar despues este paquete
  // ignore: deprecated_member_use
  launch(url);
}

openURLNuevo(String url) {
  launchUrl(Uri.parse(url).removeFragment());
}
