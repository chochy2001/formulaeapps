import 'package:flutter/material.dart';
import '../../../constantes/export_constantes.dart';

class VerPistas extends StatelessWidget {
  //const VerPistas ({Key? key}) : super(key: key);
  final Widget latex;

  const VerPistas(this.latex, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              latex,
              const SizedBox(height: 20),
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
        backgroundColor: kColorBotones,
        textStyle: kTextoBotones,
        elevation: 20.0,
        shadowColor: kColorBotones,
      ),
      child: const Text("Pista", style: kTextoBotones),
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: kColorBotones,
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
        backgroundColor: kColorBotones,
        textStyle: kTextoBotones,
        elevation: 20.0,
        shadowColor: kColorBotones,
      ),
      child: const Text("Respuesta", style: kTextoBotones),
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: kColorBotones,
            builder: (context) => VerPistas(latex),
            context: context);
      },
    );
  }
}
