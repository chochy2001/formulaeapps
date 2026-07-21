import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuMedidas extends StatefulWidget {
  const MenuMedidas({super.key});

  @override
  MenuMedidasState createState() => MenuMedidasState();
}

class MenuMedidasState extends State<MenuMedidas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
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
                    AppLocalizations.of(context)!.medidas,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.dispersionParaDatosNoAgrupados,
                    ruta: kRutaMedidasDeDispersionParaDatosNoAgrupados,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.posicionParaDatosNoAgrupados,
                    ruta: kRutaMedidasDePosicionParaDatosNoAgrupados,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.tendenciaCentralParaDatosAgrupados,
                    ruta: kRutaMedidasDeTendenciaCentralParaDatosAgrupados,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.tendenciaCentralParaDatosNoAgrupados,
                    ruta: kRutaMedidasDeTendenciaCentralParaDatosNoAgrupados,
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
