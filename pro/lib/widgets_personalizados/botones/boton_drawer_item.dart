import 'package:flutter/material.dart';

import '../../../../constantes/export_constantes.dart';

//Item del menu lateral con animacion de hover en web/escritorio.
class BotonDrawerItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final double? iconSize;
  final int maxLines;

  const BotonDrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconSize,
    this.maxLines = 1,
  });

  @override
  State<BotonDrawerItem> createState() => _BotonDrawerItemState();
}

class _BotonDrawerItemState extends State<BotonDrawerItem> {
  bool _hovered = false;

  void _setHovered(bool value) {
    if (_hovered != value) {
      setState(() {
        _hovered = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: _hovered ? kColorBotones : kColorTransparente,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  widget.icon,
                  color: kColorBlanco,
                  size: widget.iconSize,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    widget.text,
                    style: kTextoBotonesDelgado,
                    maxLines: widget.maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
