import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constantes/constantes_codigo.dart';
import 'header_bar.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final bool? visible;

  const AppBarHome({super.key, this.color, this.visible});

  @override
  Widget build(BuildContext context) {
    // Show a back button only when there is a route to pop within the current
    // (tab) navigator, i.e. when the user has drilled into a sub screen. On a
    // tab root there is nothing to pop, so `leading` stays null and Flutter
    // falls back to the drawer hamburger where a drawer exists.
    final bool canPop = Navigator.of(context).canPop();
    return AppBar(
      centerTitle: true,
      backgroundColor: kColorFondo,
      elevation: 0.0,
      leading: canPop
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: color ?? Colors.white,
                size: 20.0,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : null,
      actions: <Widget>[
        Visibility(
          visible: visible ?? true,
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.houseChimneyCrack,
              color: color ?? Colors.white,
              size: 20.0,
            ),
            onPressed: () {
              // Return to the first screen of the current tab while keeping the
              // persistent navigation shell (bottom nav / rail) in place.
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
      ],
      title: const Center(child: HeaderBar()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
