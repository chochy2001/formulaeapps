import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuFormulasBessel extends StatefulWidget {
  const MenuFormulasBessel({super.key});

  @override
  MenuFormulasBesselState createState() => MenuFormulasBesselState();
}

class MenuFormulasBesselState extends State<MenuFormulasBessel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
      body: SafeArea(
        child: FondoDegradado(
          child: ListView(
            children: [
              MenuColumn(
                children: [
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.formulasDeBessel,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.teoremaDeLaCotangente,
                    ruta: kRutaTeoremaDeLaCotangente,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.teoremaDelCosenoParaAngulos,
                    ruta: kRutaTeoremaDelCosenoParaAngulos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.teoremaDelCosenoParaLados,
                    ruta: kRutaTeoremaDelCosenoParaLados,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.teoremaDelSeno,
                    ruta: kRutaTeoremaDelSeno,
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
