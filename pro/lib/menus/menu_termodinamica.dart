import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MenuTermodinamica extends StatefulWidget {
  const MenuTermodinamica({super.key});

  @override
  MenuTermodinamicaState createState() => MenuTermodinamicaState();
}

class MenuTermodinamicaState extends State<MenuTermodinamica> {
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
              MenuColumn(
                children: [
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {},
                    child: const ImagenLogoFormulae(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.seccionTermodinamica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.transferenciaDeCalor,
                    ruta: kRutaTransferenciaDeCalor,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.capacidadCalorificaYCalorLatente,
                    ruta: kRutaCapacidadCalorificaYCalorLatente,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.leyesDeLosGases,
                    ruta: kRutaLeyesDeLosGases,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.cicloDeCarnotYLeyesDeLaTermodinamica,
                    ruta: kRutaCicloDeCarnotYLeyesDeLaTermodinamica,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.trabajoTermodinamico,
                    ruta: kRutaTrabajoTermodinamico,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.entalpiaYEnergiaInterna,
                    ruta: kRutaEntalpiaYEnergiaInterna,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.dilatacionLineal,
                    ruta: kRutaDilatacionLineal,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.dilatacionSuperficialYVolumetrica,
                    ruta: kRutaDilatacionSuperficialYVolumetrica,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.entropiaYTeoriaCinetica,
                    ruta: kRutaEntropiaYTeoriaCinetica,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.procesosTermodinamicos,
                    ruta: kRutaProcesosTermodinamicos,
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
