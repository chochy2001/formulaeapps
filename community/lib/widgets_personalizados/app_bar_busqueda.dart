import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constantes/export_constantes.dart';
import '../busqueda/search_delegate.dart';

class AppBarBusqueda extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBusqueda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Activar la búsqueda automáticamente al entrar a la página
      showSearch(
          context: context,
          delegate: DataSearch(
            buscarFormula: AppLocalizations.of(context)!.buscarFormula,
          ));
    });

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        elevation: 0.0,
        backgroundColor: kColorFondo,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontFamily: 'Poppins', fontSize: 20),
        actions: <Widget>[
          Animate(
            effects: const [
              MoveEffect(
                curve: Curves.bounceIn,
                duration: Duration(milliseconds: 100),
              ),
              ShakeEffect(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 100),
              ),
              ScaleEffect(
                curve: Curves.bounceIn,
                duration: Duration(milliseconds: 10),
              ),
            ],
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: kColorBlanco,
                size: 22.0,
              ),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: DataSearch(
                      buscarFormula:
                          AppLocalizations.of(context)!.buscarFormula,
                    ));
              },
            ),
          ),
        ],
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.buscarFormula,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
