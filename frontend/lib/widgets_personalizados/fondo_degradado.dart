import 'package:flutter/material.dart';

class FondoDegradado extends StatelessWidget {
  final ListView child;

  const FondoDegradado({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(39, 40, 61, 1.0),
              Color.fromRGBO(29, 30, 51, 1.0),
            ])),
        child: child);
  }
}
