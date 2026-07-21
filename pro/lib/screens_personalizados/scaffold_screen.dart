import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScaffoldScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget drawer;
  final Widget body;

  const ScaffoldScreen({
    super.key,
    required this.appBar,
    required this.drawer,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return Scaffold(appBar: appBar, drawer: drawer, body: body);
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.tablet) {
          return Scaffold(appBar: appBar, drawer: drawer, body: body);
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.desktop) {
          return Scaffold(
            appBar: appBar,
            body: Row(
              children: [
                Expanded(child: drawer),
                Expanded(flex: 5, child: body),
              ],
            ),
          );
        } else {
          return Scaffold(appBar: appBar, drawer: drawer, body: body);
        }
      },
    );
  }
}

class ScaffoldScreen1 extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget drawer;
  final Widget body;

  const ScaffoldScreen1({
    super.key,
    required this.appBar,
    required this.drawer,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar, drawer: drawer, body: body);
  }
}
