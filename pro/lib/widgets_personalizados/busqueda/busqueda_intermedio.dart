import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import '../../../../widgets_personalizados/export_widgets_personalizados.dart';
import 'busqueda.dart';

class BusquedaIntermedio extends StatelessWidget {
  const BusquedaIntermedio({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const ScaffoldScreen(
        appBar: AppBarBusqueda(),
        drawer: DrawerPersonalizado(0),
        body: Busqueda(),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      return const ScaffoldScreen(
        appBar: AppBarBusqueda(),
        drawer: DrawerPersonalizado(1),
        body: Busqueda(),
      );
    } else {
      return const ScaffoldScreen(
        appBar: AppBarBusqueda(),
        drawer: DrawerPersonalizado(2),
        body: Busqueda(),
      );
      //Se puso un else, ya que si no es ni android ni IOS entrará ahí y se quita el warning
    }
  }
}
