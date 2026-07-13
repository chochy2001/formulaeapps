import 'package:flutter/material.dart';

import 'boton_drawer_item.dart';

class BotonRedSocial extends StatelessWidget {
  final Function url;
  final IconData icon;
  final String text;

  const BotonRedSocial(
      {super.key, required this.url, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return BotonDrawerItem(
      icon: icon,
      text: text,
      onTap: () {
        url();
      },
    );
  }
}
