import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MenuOptica extends StatefulWidget {
  const MenuOptica({super.key});

  @override
  MenuOpticaState createState() => MenuOpticaState();
}

class MenuOpticaState extends State<MenuOptica> {
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
                    AppLocalizations.of(context)!.seccionOptica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.leyDeLaIluminacion,
                    ruta: kRutaLeyDeLaIluminacion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.reflexionYAumentoFormaNewtoniana,
                    ruta: kRutaReflexionYAumentoFormaNewtoniana,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.ecuacionDeLasLentesFormaGaussiana,
                    ruta: kRutaEcuacionDeLasLentesFormaGaussiana,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.refraccionDeLaLuzLeyDeSnell,
                    ruta: kRutaRefraccionDeLaLuzLeyDeSnell,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.tiposDeLentesYMarchaDeRayos,
                    ruta: kRutaTiposDeLentesYMarchaDeRayos,
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
