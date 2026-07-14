import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuEcuacionesDiferenciales extends StatefulWidget {
  const MenuEcuacionesDiferenciales({super.key});

  @override
  MenuEcuacionesDiferencialesState createState() =>
      MenuEcuacionesDiferencialesState();
}

class MenuEcuacionesDiferencialesState
    extends State<MenuEcuacionesDiferenciales> {
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
                    AppLocalizations.of(context)!.ecuacionesDiferenciales,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.constantesDeIntegracion,
                    ruta: kRutaConstantesDeIntegracion,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialCoeficientesConstantes,
                    ruta: kRutaEcuacionDiferencialConCoeficientesConstantes,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialRectasNoParalelas,
                    ruta: kRutaEcuacionDiferencialDeRectasNoParalelas,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialRectasParalelas,
                    ruta: kRutaEcuacionDiferencialDeRectasParalelas,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionDiferencialExacta,
                    ruta: kRutaEcuacionDiferencialExacta,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialHomogenea,
                    ruta: kRutaEcuacionDiferencialHomogenea,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialLinealOrdenSuperior,
                    ruta: kRutaEcuacionDiferencialLinealDeOrdenSuperior,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialLinealPrimerOrden,
                    ruta: kRutaEcuacionDiferencialLinealDePrimerOrden,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .ecuacionDiferencialSeparable,
                    ruta: kRutaEcuacionDiferencialSeparable,
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
