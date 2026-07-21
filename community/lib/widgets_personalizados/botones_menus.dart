import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';

class BotonMenu extends StatelessWidget {
  const BotonMenu({
    super.key,
    required this.onPress,
    this.color,
    this.cardChild,
  });

  final Color? color;
  final Widget? cardChild;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3), // Color de la sombra.
              spreadRadius:
                  5, // Extensión de la sombra. Puedes modificarlo a tu gusto.
              blurRadius:
                  10, // Suavizado de la sombra. Puedes modificarlo a tu gusto.
              offset: const Offset(0, 15), // Dirección de la sombra.
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}

class BotonesMenu extends StatelessWidget {
  final String ruta;
  final String textoBoton;

  const BotonesMenu({super.key, required this.ruta, required this.textoBoton});

  @override
  Widget build(BuildContext context) {
    return BotonMenu(
      onPress: () {
        Navigator.pushNamed(context, ruta);
      },
      color: kColorBotones,
      cardChild: Column(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: constraints.maxWidth * 0.8,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.07,
                        ),
                        child: Text(
                          textoBoton,
                          style: kTextoMostrarOcultar,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
