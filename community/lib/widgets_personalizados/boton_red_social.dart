import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';

class BotonRedSocial extends StatelessWidget {
  final Function url;
  final IconData icon;
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
          Icon(
            icon,
            color: kColorBlanco,
            //color: Colors.white,
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
