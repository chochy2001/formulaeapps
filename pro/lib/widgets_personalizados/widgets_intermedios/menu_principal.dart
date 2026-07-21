import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:universal_io/io.dart';

import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuPrincipal1 extends StatelessWidget {
  const MenuPrincipal1({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        double drawerWidth;
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          drawerWidth = MediaQuery.of(context).size.width * .7;
        } else {
          drawerWidth = MediaQuery.of(context).size.width * .4;
        }

        if (Platform.isAndroid) {
          return ScaffoldScreen(
            appBar: const AppBarHome(visible: false),
            drawer: SizedBox(
              width: drawerWidth,
              child: const DrawerPersonalizado(0),
            ),
            body: const PrincipalMenu(),
          );
        } else if (Platform.isIOS || Platform.isMacOS) {
          return ScaffoldScreen(
            appBar: const AppBarHome(visible: false),
            drawer: SizedBox(
              width: drawerWidth,
              child: const DrawerPersonalizado(1),
            ),
            body: const PrincipalMenu(),
          );
        } else {
          return ScaffoldScreen(
            appBar: const AppBarHome(visible: false),
            drawer: SizedBox(
              width: drawerWidth,
              child: const DrawerPersonalizado(2),
            ),
            body: const PrincipalMenu(),
          );
        }
      },
    );
  }
}
