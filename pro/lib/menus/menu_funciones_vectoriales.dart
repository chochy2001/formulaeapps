import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuFuncionesVectoriales extends StatefulWidget {
  const MenuFuncionesVectoriales({super.key});

  @override
  MenuFuncionesVectorialesState createState() =>
      MenuFuncionesVectorialesState();
}

class MenuFuncionesVectorialesState extends State<MenuFuncionesVectoriales> {
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
                    AppLocalizations.of(context)!.funcionesVectoriales,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .derivadasFuncionesVectoriales,
                    ruta: kRutaDerivadaFuncionesVectoriales,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .limitesDerivadasIntegralesFuncionesVectoriales,
                    ruta: kRutaLimiteIntegralDerivadaFuncionVectorial,
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
