import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        SizedBox(
          width: 10.0,
        ),
        Text(
          'Formulae',
          style: TextStyle(
              color: Color(0xFFE9E9E9),
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Sriracha'),
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          'Pro',
          style: kEstiloSubMenu,
        ),
        SizedBox(
          width: 30.0,
        ),
      ],
    );
  }
}
