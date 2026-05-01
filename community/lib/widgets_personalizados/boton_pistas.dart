import 'package:flutter/material.dart';
import '../../../constantes/export_constantes.dart';

class VerPistas extends StatelessWidget {
  //const VerPistas ({Key? key}) : super(key: key);
  final Widget latex;

  VerPistas(this.latex);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              latex,
              SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}

class BotonVerPistas extends StatelessWidget {
  final Widget latex;

  BotonVerPistas(this.latex);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorBotones,
        textStyle: kTextoBotones,
        elevation: 20.0,
        shadowColor: kColorBotones,
      ),
      child: Text("Pista", style: kTextoBotones),
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

  BotonVerRespuesta(this.latex);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorBotones,
        textStyle: kTextoBotones,
        elevation: 20.0,
        shadowColor: kColorBotones,
      ),
      child: Text("Respuesta", style: kTextoBotones),
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: kColorBotones,
            builder: (context) => VerPistas(latex),
            context: context);
      },
    );
  }
}
