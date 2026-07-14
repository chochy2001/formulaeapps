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
    return AppBar(
      centerTitle: true,
      backgroundColor: kColorFondo,
      elevation: 0.0,
      actions: <Widget>[
        Visibility(
          visible: visible ?? true,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.houseChimneyCrack,
              color: color ?? Colors.white,
              size: 20.0,
            ),
            onPressed: () {
              // The root route already hosts the persistent Community shell.
              // Pushing '/' here created another Menu on top of the current
              // stack every time the user pressed Home. Returning to the first
              // route preserves the existing shell and does not duplicate it.
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
      ],
      title: const Center(
        child: HeaderBar(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
