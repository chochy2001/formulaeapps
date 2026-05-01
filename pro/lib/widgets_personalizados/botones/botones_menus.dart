import 'package:flutter/material.dart';

import '../../../../constantes/export_constantes.dart';

class BotonMenu extends StatefulWidget {
  const BotonMenu({Key? key, required this.onPress, this.color, this.cardChild})
      : super(key: key);

  final Color? color;
  final Widget? cardChild;
  final void Function() onPress;

  @override
  BotonMenuState createState() => BotonMenuState();
}

class BotonMenuState extends State<BotonMenu> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPress,
        child: AnimatedContainer(
          width: _isHovering
              ? MediaQuery.of(context).size.width * 0.96
              : MediaQuery.of(context).size.width * 0.95,
          height: _isHovering
              ? MediaQuery.of(context).size.height * 0.09
              : MediaQuery.of(context).size.height * 0.08,
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: _isHovering
                    ? Colors.black.withValues(alpha: 0.9)
                    : Colors.black.withValues(alpha: 0.3),
                spreadRadius: _isHovering ? 8 : 5,
                blurRadius: _isHovering ? 15 : 10,
                offset: const Offset(0, 15),
              ),
            ],
            color: widget.color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: widget.cardChild,
        ),
      ),
    );
  }
}

class BotonesMenu extends StatelessWidget {
  final String ruta;
  final String textoBoton;

  const BotonesMenu({Key? key, required this.ruta, required this.textoBoton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BotonMenu(
      onPress: () {
        Navigator.pushNamed(context, ruta);
      },
      color: kColorBotones,
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            minHeight:
                                MediaQuery.of(context).size.height * 0.07),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                textoBoton,
                                style: kTextoMostrarOcultar,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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
