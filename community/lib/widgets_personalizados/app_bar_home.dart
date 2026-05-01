import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constantes/constantes_codigo.dart';
import 'header_bar.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final bool? visible;

  const AppBarHome({Key? key, this.color, this.visible}) : super(key: key);

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
              Navigator.pushNamed(context, '/');
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
