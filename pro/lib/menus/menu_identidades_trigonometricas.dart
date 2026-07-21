import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuIdentidadesTrigonometricas extends StatefulWidget {
  const MenuIdentidadesTrigonometricas({super.key});

  @override
  MenuIdentidadesTrigonometricasState createState() =>
      MenuIdentidadesTrigonometricasState();
}

class MenuIdentidadesTrigonometricasState
    extends State<MenuIdentidadesTrigonometricas> {
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
                    AppLocalizations.of(context)!.identidadesTrigonometricas,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.deAnguloDobleYMedio,
                    ruta: kRutaIdentidadesTrigonometricasDeAnguloDobleYMedio,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.deSumaAProductoYViceversa,
                    ruta:
                        kRutaIdentidadesTrigonometricasDeSumaAProductoYViceversa,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.deSumaYRestaDeAngulos,
                    ruta: kRutaIdentidadesTrigonometricasDeSumaYRestaDeAngulos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.extras,
                    ruta: kRutaIdentidadesTrigonometricasExtras,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.fundamentales,
                    ruta: kRutaIdentidadesTrigonometricasFundamentales,
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
