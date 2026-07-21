import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';
import 'package:formulae/constantes/export_constantes.dart';
import 'package:formulae/widgets_personalizados/export_widgets_personalizados.dart';

class MenuNumerosRealesYDesigualdades extends StatefulWidget {
  const MenuNumerosRealesYDesigualdades({super.key});

  @override
  MenuNumerosRealesYDesigualdadesState createState() =>
      MenuNumerosRealesYDesigualdadesState();
}

class MenuNumerosRealesYDesigualdadesState
    extends State<MenuNumerosRealesYDesigualdades> {
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
                    AppLocalizations.of(
                      context,
                    )!.seccionNumerosRealesYDesigualdades,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.axiomasDeCampoNumerosReales,
                    ruta: kRutaAxiomasDeCampoNumerosReales,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.axiomasDeOrdenYTeoremasReales,
                    ruta: kRutaAxiomasDeOrdenYTeoremasReales,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.desigualdadesTeoremasDeOrden,
                    ruta: kRutaDesigualdadesTeoremasDeOrden,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.conjuntosEIntervalos,
                    ruta: kRutaConjuntosEIntervalos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.valorAbsoluto,
                    ruta: kRutaValorAbsoluto,
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
