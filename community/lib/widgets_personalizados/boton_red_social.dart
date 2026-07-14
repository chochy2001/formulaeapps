import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constantes/export_constantes.dart';

class BotonRedSocial extends StatelessWidget {
  final Function url;
  final FaIconData icon;
  final String text;

  const BotonRedSocial({
    super.key,
    required this.url,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        url();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FaIcon(
            icon,
            color: kColorBlanco,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: kTextoBotonesDelgado,
            ),
          ),
        ],
      ),
    );
  }
}