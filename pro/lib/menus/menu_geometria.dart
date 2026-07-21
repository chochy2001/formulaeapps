import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuGeometria extends StatefulWidget {
  const MenuGeometria({super.key});

  @override
  MenuGeometriaState createState() => MenuGeometriaState();
}

class MenuGeometriaState extends State<MenuGeometria> {
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
                    AppLocalizations.of(context)!.geometria,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  //Propiedades Logaritmos
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.angulosEnUnPoligono,
                    ruta: kRutaAngulosEnUnPoligono,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.areas,
                    ruta: kRutaMenuAreasGeometria,
                  ),
                  //Funciones Trigonometricas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.circunferencia,
                    ruta: kRutaCircunferencia,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.distanciaDeUnPuntoAUnaRecta,
                    ruta: kRutaDistanciaDeUnPuntoAUnaRecta,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.distanciaEntreDosPuntos,
                    ruta: kRutaDistanciaEntreDosPuntos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.ecuacionDeLaRecta,
                    ruta: kRutaEcuacionDeLaRecta,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.elipseConCentroDiferenteDelOrigen,
                    ruta: kRutaElipseConCentroDiferenteDelOrigen,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.elipseConCentroEnElOrigen,
                    ruta: kRutaElipseConCentroDiferenteDelOrigen,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.hiperbola,
                    ruta: kRutaHiperbola,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.parabolaConVerticeDiferenteDelOrigen,
                    ruta: kRutaParabolaConVerticeDiferenteDelOrigen,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.parabolaConVerticeEnElOrigen,
                    ruta: kRutaParabolaConVerticeEnElOrigen,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.puntoMedioEntreDosPuntos,
                    ruta: kRutaPuntoMedioEntreDosPuntosGeometria,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.volumenDeCuerposGeometricos,
                    ruta: kRutaVolumenDeCuerposGeometricos,
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
