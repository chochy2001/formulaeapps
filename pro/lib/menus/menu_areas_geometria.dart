import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuAreasGeometria extends StatefulWidget {
  const MenuAreasGeometria({super.key});

  @override
  MenuAreasGeometriaState createState() => MenuAreasGeometriaState();
}

class MenuAreasGeometriaState extends State<MenuAreasGeometria> {
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
                    AppLocalizations.of(context)!.areasGeometria,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .areaPerimetroCuadrilateros,
                    ruta: kRutaAreaYPerimetroDeCuadrilateros,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.areaPerimetroTriangulos,
                    ruta: kRutaAreaYPerimetroDeTriangulos,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.areaPerimetroCirculo,
                    ruta: kRutaAreaYPerimetroDelCirculo,
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
