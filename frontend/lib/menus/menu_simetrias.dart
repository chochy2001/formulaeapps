import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuSimetrias extends StatefulWidget {
  const MenuSimetrias({Key? key}) : super(key: key);

  @override
  MenuSimetriasState createState() => MenuSimetriasState();
}

class MenuSimetriasState extends State<MenuSimetrias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.simetrias,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.simetriaDeMediaOnda,
                    ruta: kRutaSimetriaDeMediaOnda,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .simetriaDeUnCuartoDeOndaImpar,
                    ruta: kRutaSimetriaDeUnCuartoDeOndaImpar,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .simetriaDeUnCuartoDeOndaPar,
                    ruta: kRutaSimetriaDeUnCuartoDeOndaPar,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.simetriaImpar,
                    ruta: kRutaSimetriaImpar,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.simetriaPar,
                    ruta: kRutaSimetriaPar,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
