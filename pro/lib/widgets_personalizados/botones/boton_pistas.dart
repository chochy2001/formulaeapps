import 'package:flutter/material.dart';

import '../../../../constantes/export_constantes.dart';

class VerPistas extends StatelessWidget {
  final Widget latex;

  const VerPistas(this.latex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: kColorBotones,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.23,
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              latex,
              SizedBox(height: MediaQuery.of(context).size.height * .05),
            ],
          )
        ],
      ),
    );
  }
}

class BotonVerPistas extends StatelessWidget {
  final Widget latex;

  const BotonVerPistas(this.latex, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: kTextoBotones,
        elevation: 20.0,
        shadowColor: kColorBotones,
      ),
      child: Text(AppLocalizations.of(context)!.pista, style: kTextoBotones),
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            builder: (context) => VerPistas(latex),
            context: context);
      },
    );
  }
}

class BotonVerRespuesta extends StatelessWidget {
  final Widget latex;

  const BotonVerRespuesta(this.latex, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: kTextoBotones,
        elevation: 20.0,
        shadowColor: kColorBotones,
      ),
      child:
          Text(AppLocalizations.of(context)!.respuesta, style: kTextoBotones),
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            builder: (context) => VerPistas(latex),
            context: context);
      },
    );
  }
}
