import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import '../../../widgets_personalizados/export_widgets_personalizados.dart';
import '../../Favorites/favorites_screen.dart';

class FavoritesIntermedio extends StatelessWidget {
  const FavoritesIntermedio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const ScaffoldScreen(
        appBar: AppBarHome(
          visible: false,
        ),
        drawer: DrawerPersonalizado(0),
        body: FavoritesScreen(),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      return const ScaffoldScreen(
        appBar: AppBarHome(
          visible: false,
        ),
        drawer: DrawerPersonalizado(1),
        body: FavoritesScreen(),
      );
    } else {
      return const ScaffoldScreen(
        appBar: AppBarHome(
          visible: false,
        ),
        drawer: DrawerPersonalizado(2),
        body: FavoritesScreen(),
      );
      //Se puso un else, ya que si no es ni android ni IOS entrará ahí y se quita el warning
    }
  }
}
