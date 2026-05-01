import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constantes/constantes_codigo.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.label,
      this.fontSize = 18,
      this.color,
      this.fontWeight})
      : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    String normalizedString = Intl.canonicalizedLocale(label);
    return Text(
      normalizedString,
      style: kTextoBotonesDelgado,
    );
  }
}
