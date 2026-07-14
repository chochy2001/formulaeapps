import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    // AppBar reserves room for the home action. Scale the brand mark down on
    // narrow phones instead of overflowing the remaining title slot.
    return const FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(width: 10.0),
          Text(
            'Formulae',
            style: TextStyle(
              color: Color(0xFFE9E9E9),
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Sriracha',
            ),
          ),
          SizedBox(width: 5.0),
          Text('Free', style: kEstiloSubMenu),
          SizedBox(width: 30.0),
        ],
      ),
    );
  }
}
