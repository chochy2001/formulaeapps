import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuProbabilidadYEstadistica extends StatefulWidget {
  const MenuProbabilidadYEstadistica({Key? key}) : super(key: key);

  @override
  MenuProbabilidadYEstadisticaState createState() =>
      MenuProbabilidadYEstadisticaState();
}

class MenuProbabilidadYEstadisticaState
    extends State<MenuProbabilidadYEstadistica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(
        visible: false,
      ),
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
                    AppLocalizations.of(context)!.probabilidadEstadistica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .combinacionesYPermutaciones,
                    ruta: kRutaCombinacionesYPermutaciones,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .cuantilesParaDatosAgrupados,
                    ruta: kRutaCuantilesParaDatosAgrupados,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.distribuciones,
                    ruta: kRutaMenuDistribuciones,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.estadisticaInferencial,
                    ruta: kRutaEstadisticaInferencial,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.intervalosDeConfianza,
                    ruta: kRutaIntervalosDeConfianza,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.mediaGeometrica,
                    ruta: kRutaMediaGeometrica,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.medidas,
                    ruta: kRutaMenuMedidas,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.momentosEstadisticos,
                    ruta: kRutaMomentosEstadisticos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.probabilidad,
                    ruta: kRutaProbabilidad,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.tamanioMuestral,
                    ruta: kRutaTamanioMuestral,
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
