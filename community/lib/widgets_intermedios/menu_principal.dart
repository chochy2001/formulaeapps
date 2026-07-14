import 'package:responsive_builder/responsive_builder.dart';

import '../../../constantes/export_constantes.dart';
import 'package:flutter/material.dart';

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class MenuPrincipal1 extends StatefulWidget {
  const MenuPrincipal1({super.key});
  @override
  State<MenuPrincipal1> createState() => _MenuPrincipal1State();
}

class _MenuPrincipal1State extends State<MenuPrincipal1> {
  @override
  void initState() {
    super.initState();
  }

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
            appBar: const AppBarHome(
              visible: false,
            ),
            drawer: SizedBox(
              width: drawerWidth,
              child: const DrawerPersonalizado(0),
            ),
            body: const PrincipalMenu(),
          );
        } else if (Platform.isIOS || Platform.isMacOS) {
          return ScaffoldScreen(
            appBar: const AppBarHome(
              visible: false,
            ),
            drawer: SizedBox(
              width: drawerWidth,
              child: const DrawerPersonalizado(1),
            ),
            body: const PrincipalMenu(),
          );
        } else {
          return ScaffoldScreen(
            appBar: const AppBarHome(
              visible: false,
            ),
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
