import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuCapacitanciaYDielectricos extends StatelessWidget {
  const MenuCapacitanciaYDielectricos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHome(),
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
                    AppLocalizations.of(context)!.capacitanciaDielectricos,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BotonesMenu(
                    ruta: kRutaCapacitor,
                    textoBoton: AppLocalizations.of(context)!.capacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaCargaDeUnCapacitor,
                    textoBoton: AppLocalizations.of(context)!.cargaCapacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaDefinicionDeCapacitancia,
                    textoBoton:
                        AppLocalizations.of(context)!.definicionCapacitancia,
                  ),
                  BotonesMenu(
                    ruta: kRutaGraficaDeCapacitancia,
                    textoBoton:
                        AppLocalizations.of(context)!.graficaCapacitancia,
                  ),
                  BotonesMenu(
                    ruta: kRutaSimbologiaCapacitores,
                    textoBoton:
                        AppLocalizations.of(context)!.simbologiaCapacitores,
                  ),
                  BotonesMenu(
                    ruta: kRutaCapacitorDePlacasPlanasYParalelas,
                    textoBoton: AppLocalizations.of(context)!
                        .capacitorPlacasPlanasParalelas,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaYCapacitancia,
                    textoBoton:
                        AppLocalizations.of(context)!.energiaCapacitancia,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaAlmacenadaPorUnCapacitor,
                    textoBoton: AppLocalizations.of(context)!
                        .energiaAlmacenadaCapacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaConexionEnSerieCapacitor,
                    textoBoton:
                        AppLocalizations.of(context)!.conexionSerieCapacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaConexionEnParaleloCapacitor,
                    textoBoton:
                        AppLocalizations.of(context)!.conexionParaleloCapacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaPolarizacion,
                    textoBoton: AppLocalizations.of(context)!.polarizacion,
                  ),
                  BotonesMenu(
                    ruta: kRutaPolarizacionYCargaInducida,
                    textoBoton:
                        AppLocalizations.of(context)!.polarizacionCargaInducida,
                  ),
                  BotonesMenu(
                    ruta: kRutaConstantesDielectricas,
                    textoBoton:
                        AppLocalizations.of(context)!.constantesDielectricas,
                  ),
                  BotonesMenu(
                    ruta: kRutaRigidezDielectrica,
                    textoBoton:
                        AppLocalizations.of(context)!.rigidezDielectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaVectorDeDesplazamientoElectrico,
                    textoBoton: AppLocalizations.of(context)!
                        .vectorDesplazamientoElectrico,
                  ),
                  BotonesMenu(
                    ruta: kRutaRepresentacionDeLosVectoresElectricos,
                    textoBoton: AppLocalizations.of(context)!
                        .representacionVectoresElectricos,
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
