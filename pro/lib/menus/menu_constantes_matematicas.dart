import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MenuConstantesMatematicas extends StatefulWidget {
  const MenuConstantesMatematicas({super.key});

  @override
  MenuConstantesMatematicasState createState() => MenuConstantesMatematicasState();
}

class MenuConstantesMatematicasState extends State<MenuConstantesMatematicas> {
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
                    AppLocalizations.of(context)!.seccionConstantesMatematicas,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.constantesMatematicas,
                    ruta: kRutaConstantesMatematicas,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.constantesFisicasUniversales,
                    ruta: kRutaConstantesFisicasUniversales,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.constantesElectromagneticas,
                    ruta: kRutaConstantesElectromagneticas,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.constantesAtomicasMoleculares,
                    ruta: kRutaConstantesAtomicasMoleculares,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.constantesTerrestresAstronomicas,
                    ruta: kRutaConstantesTerrestresAstronomicas,
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
