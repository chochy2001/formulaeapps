import 'package:flutter/material.dart';
import 'package:formulae/constantes/contantes_rutas.dart';

import '../../../constantes/export_constantes.dart';
import '../../../widgets_personalizados/export_widgets_personalizados.dart';

class MenuCampoYPotencialElectricos extends StatelessWidget {
  const MenuCampoYPotencialElectricos({super.key});

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
                    AppLocalizations.of(context)!.campoYPotencialElectricos,
                    style: kTextoBotones,
                  ),
                  const SizedBox(height: 30.0),
                  BotonesMenu(
                    ruta: kRutaElectricidad,
                    textoBoton: AppLocalizations.of(context)!.electricidad,
                  ),
                  BotonesMenu(
                    ruta: kRutaCargaElectrica,
                    textoBoton: AppLocalizations.of(context)!.cargaElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaCargaProtonElectron,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.cargaElectricaProtonElectron,
                  ),
                  BotonesMenu(
                    ruta: kRutaDistribucionesDeCargaElectrica,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.distribucionesCargaElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeCoulomb,
                    textoBoton: AppLocalizations.of(context)!.leyCoulomb,
                  ),
                  BotonesMenu(
                    ruta: kRutaPrincipioDeSuperposicion,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.principioSuperposicion,
                  ),
                  BotonesMenu(
                    ruta: kRutaCampoElectrico,
                    textoBoton: AppLocalizations.of(context)!.campoElectrico,
                  ),
                  BotonesMenu(
                    ruta: kRutaCampoElectricoOriginadoPorDistribucionesDeCarga,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.campoElectricoDistribucionesCarga,
                  ),
                  BotonesMenu(
                    ruta: kRutaFlujoDeUnCampoVectorial,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.flujoElectricoCampoVectorial,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeGauss,
                    textoBoton: AppLocalizations.of(context)!.leyGauss,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaPotencialElectrica,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.energiaPotencialElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaCalculoDeDiferenciasDePotencial,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.calculoDiferenciasPotencial,
                  ),
                  BotonesMenu(
                    ruta: kRutaTeoremaDeLaDivergencia,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.teoremaDivergencia,
                  ),
                  BotonesMenu(
                    ruta: kRutaTeoremaDelRotacional,
                    textoBoton: AppLocalizations.of(context)!.teoremaRotacional,
                  ),
                  BotonesMenu(
                    ruta: kRutaCirculacionDelCampoElectrostatico,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.circulacionCampoElectrostatico,
                  ),
                  BotonesMenu(
                    ruta: kRutaRotacionalDelCampoElectrostatico,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.rotacionalCampoElectrostatico,
                  ),
                  BotonesMenu(
                    ruta: kRutaOperadorGradiente,
                    textoBoton: AppLocalizations.of(context)!.operadorGradiente,
                  ),
                  BotonesMenu(
                    ruta: kRutaGradienteDeUnaFuncionEscalar,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.gradienteFuncionEscalar,
                  ),
                  BotonesMenu(
                    ruta: kRutaGradienteDePotencialElectrico,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.gradientePotencialElectrico,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeGaussEnFormaDiferencial,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.leyGaussFormaDiferencial,
                  ),
                  BotonesMenu(
                    ruta: kRutaEcuacionDePoissonYLaplace,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.ecuacionPoissonLaplace,
                  ),
                  BotonesMenu(
                    ruta: kRutaSuperficiesEquipotenciales,
                    textoBoton: AppLocalizations.of(
                      context,
                    )!.superficiesEquipotenciales,
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
