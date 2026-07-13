import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MenuMecanica extends StatefulWidget {
  const MenuMecanica({super.key});

  @override
  MenuMecanicaState createState() => MenuMecanicaState();
}

class MenuMecanicaState extends State<MenuMecanica> {
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
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.seccionMecanica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.aceleracionYMrua,
                    ruta: kRutaAceleracionYMrua,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.caidaLibreYTiroVertical,
                    ruta: kRutaCaidaLibreYTiroVertical,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.movimientoDeProyectiles,
                    ruta: kRutaMovimientoDeProyectiles,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.movimientoCircularUniforme,
                    ruta: kRutaMovimientoCircularUniforme,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.cinematicaAngular,
                    ruta: kRutaCinematicaAngular,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.aceleracionYFuerzaCentripeta,
                    ruta: kRutaAceleracionYFuerzaCentripeta,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.leyesDeNewton,
                    ruta: kRutaLeyesDeNewton,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.pesoYGravedad,
                    ruta: kRutaPesoYGravedad,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.cantidadDeMovimientoEImpulso,
                    ruta: kRutaCantidadDeMovimientoEImpulso,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.friccion,
                    ruta: kRutaFriccion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.movimientoArmonicoSimple,
                    ruta: kRutaMovimientoArmonicoSimple,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.penduloSimple,
                    ruta: kRutaPenduloSimple,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.equilibrioDeCuerposRigidos,
                    ruta: kRutaEquilibrioDeCuerposRigidos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.momentoDeTorsion,
                    ruta: kRutaMomentoDeTorsion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.eficiencia,
                    ruta: kRutaEficiencia,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.hidrostatica,
                    ruta: kRutaHidrostatica,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.hidrodinamica,
                    ruta: kRutaHidrodinamica,
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
