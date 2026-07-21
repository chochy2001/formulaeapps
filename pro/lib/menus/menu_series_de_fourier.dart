import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuSeriesDeFourier extends StatefulWidget {
  const MenuSeriesDeFourier({super.key});

  @override
  MenuSeriesDeFourierState createState() => MenuSeriesDeFourierState();
}

class MenuSeriesDeFourierState extends State<MenuSeriesDeFourier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(visible: false),
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
                    AppLocalizations.of(context)!.seriesFourier,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.convolucion,
                    ruta: kRutaConvolucion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.formaComplejaDeLasSeriesDeFourier,
                    ruta: kRutaFormaComplejaDeLasSeriesDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.formulasOperacionalesDeLaTransformadaDeLaplace,
                    ruta: kRutaFormulasOperacionalesDeLaTransformadaDeLaplace,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.funcionImpulsoUnitario,
                    ruta: kRutaFuncionImpulsoUnitario,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.funcionUnitariaDeHeaviside,
                    ruta: kRutaFuncionUnitariaDeHeaviside,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.serieYCoeficientesDeFourier,
                    ruta: kRutaSerieYCoeficientesDeFourier,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.simetrias,
                    ruta: kRutaMenuSimetrias,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.transformadas,
                    ruta: kRutaMenuTransformadas,
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
