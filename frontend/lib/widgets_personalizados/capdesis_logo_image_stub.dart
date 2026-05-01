import 'package:flutter/material.dart';

Widget buildCapdesisLogoImage() {
  return Image.asset(
    'assets/images/capdesis_logo.png',
    fit: BoxFit.contain,
    filterQuality: FilterQuality.high,
  );
}
