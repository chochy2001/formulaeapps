import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuTransformadas extends StatefulWidget {
  const MenuTransformadas({super.key});

  @override
  MenuTransformadasState createState() => MenuTransformadasState();
}

class MenuTransformadasState extends State<MenuTransformadas> {
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
                    AppLocalizations.of(context)!.transformadas,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadaDeFourier,
                    ruta: kRutaTransformadaDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadaDeLaplace,
                    ruta: kRutaTransformadaDeLaplace,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadaSenoYCosenoDeFourier,
                    ruta: kRutaTransformadaSenoYCosenoDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadasBasicasDeFourier,
                    ruta: kRutaTransformadasBasicasDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadasDeFourier,
                    ruta: kRutaTransformadasDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.transformadasDeLaplace,
                    ruta: kRutaTransformadasDeLaplace,
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
