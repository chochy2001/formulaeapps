import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class Generales extends StatefulWidget {
  const Generales({Key? key}) : super(key: key);

  @override
  GeneralesState createState() => GeneralesState();
}

class GeneralesState extends State<Generales> {
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
                    AppLocalizations.of(context)!.generales,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //Propiedades Logaritmos
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.propiedadesLogaritmos,
                    ruta: kRutaPropiedadesLogaritmos,
                  ),
                  //Funciones Trigonometricas
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.funcionesTrigonometricas,
                    ruta: kRutaFuncionesTrigonometricasGenerales,
                  ),
                  //Identidades Trigonometricas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .identidadesTrigonometricas,
                    ruta: kRutaIdentidadesTrigonometricas,
                  ),
                  //Trigonometricas Hiperbolicas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .trigonometricasHiperbolicas,
                    ruta: kRutaTrigonometricasHiperbolicas,
                  ),
                  //Identidades Hiperbolicas
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.identidadesHiperbolicas,
                    ruta: kRutaIdentidadesHiperbolicas,
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
