import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuCircuitosElectricos extends StatefulWidget {
  const MenuCircuitosElectricos({super.key});

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuCircuitosElectricos> createState() =>
      _MenuCircuitosElectricosState();
}

class _MenuCircuitosElectricosState extends State<MenuCircuitosElectricos> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
  }


  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

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
                    AppLocalizations.of(context)!.circuitosElectricos,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaPortadoresDeCargaLibre,
                    textoBoton:
                        AppLocalizations.of(context)!.portadoresCargaLibre,
                  ),
                  BotonesMenu(
                    ruta: kRutaMovimientoDePortadoresDeCargaLibre,
                    textoBoton: AppLocalizations.of(context)!
                        .movimientoPortadoresCargaLibreDensidadCorriente,
                  ),
                  BotonesMenu(
                    ruta: kRutaDensidadDeCorrienteYCorrienteElectrica,
                    textoBoton: AppLocalizations.of(context)!
                        .densidadCorrienteCorrienteElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaTiposDeCorrienteElectrica,
                    textoBoton:
                        AppLocalizations.of(context)!.tiposCorrienteElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaConductividadYResistividad,
                    textoBoton:
                        AppLocalizations.of(context)!.conductividadResistividad,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeOhm,
                    textoBoton: AppLocalizations.of(context)!.leyOhm,
                  ),
                  BotonesMenu(
                    ruta: kRutaEcuacionDeOhm,
                    textoBoton: AppLocalizations.of(context)!.ecuacionOhm,
                  ),
                  BotonesMenu(
                    ruta: kRutaResistividadYTemperatura,
                    textoBoton:
                        AppLocalizations.of(context)!.resistividadTemperatura,
                  ),
                  BotonesMenu(
                    ruta: kRutaEfectoJoule,
                    textoBoton: AppLocalizations.of(context)!.efectoJoule,
                  ),
                  BotonesMenu(
                    ruta: kRutaResistorSimbologiaBasica,
                    textoBoton:
                        AppLocalizations.of(context)!.resistorSimbologiaBasica,
                  ),
                  BotonesMenu(
                    ruta: kRutaResistorLinealYNoLineal,
                    textoBoton:
                        AppLocalizations.of(context)!.resistorLinealNoLineal,
                  ),
                  BotonesMenu(
                    ruta: kRutaConexionEnSerieResistor,
                    textoBoton:
                        AppLocalizations.of(context)!.conexionSerieResistor,
                  ),
                  BotonesMenu(
                    ruta: kRutaConexionEnParaleloResistor,
                    textoBoton:
                        AppLocalizations.of(context)!.conexionParaleloResistor,
                  ),
                  BotonesMenu(
                    ruta: kRutaFuenteDeFuerzaElectromotriz,
                    textoBoton:
                        AppLocalizations.of(context)!.fuenteFuerzaElectromotriz,
                  ),
                  BotonesMenu(
                    ruta: kRutaElementosCapacitorYResistor,
                    textoBoton: AppLocalizations.of(context)!
                        .elementosCapacitorResistor,
                  ),
                  BotonesMenu(
                    ruta: kRutaElementosFem,
                    textoBoton: AppLocalizations.of(context)!
                        .elementosFuerzaElectromotriz,
                  ),
                  BotonesMenu(
                    ruta: kRutaTeoriaDeCircuitos,
                    textoBoton: AppLocalizations.of(context)!.teoriaCircuitos,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeVoltajesDeKirchhoff,
                    textoBoton:
                        AppLocalizations.of(context)!.leyVoltajesKirchhoff,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeCorrientesDeKirchhoff,
                    textoBoton:
                        AppLocalizations.of(context)!.leyCorrientesKirchhoff,
                  ),
                  BotonesMenu(
                    ruta: kRutaReglasParaLVKyLCK,
                    textoBoton: AppLocalizations.of(context)!.reglasLVKLCK,
                  ),
                  BotonesMenu(
                    ruta: kRutaCircuitoRCyVoltajeContinuo,
                    textoBoton:
                        AppLocalizations.of(context)!.circuitoRCVoltajeContinuo,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyesDeKirchhoffCircuitoRC,
                    textoBoton:
                        AppLocalizations.of(context)!.leyesKirchhoffCircuitoRC,
                  ),
                  BotonesMenu(
                    ruta: kRutaNomenclaturaBasicaEmpleadaEnCircuitos,
                    textoBoton: AppLocalizations.of(context)!
                        .nomenclaturaBasicaCircuitos,
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
