import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuProbabilidadYEstadistica extends StatefulWidget {
  const MenuProbabilidadYEstadistica({Key? key}) : super(key: key);

  @override
  MenuProbabilidadYEstadisticaState createState() =>
      MenuProbabilidadYEstadisticaState();
}

class MenuProbabilidadYEstadisticaState
    extends State<MenuProbabilidadYEstadistica> {
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
                    AppLocalizations.of(context)!.probabilidadEstadistica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .combinacionesYPermutaciones,
                    ruta: kRutaCombinacionesYPermutaciones,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .cuantilesParaDatosAgrupados,
                    ruta: kRutaCuantilesParaDatosAgrupados,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.distribuciones,
                    ruta: kRutaMenuDistribuciones,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.estadisticaInferencial,
                    ruta: kRutaEstadisticaInferencial,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.intervalosDeConfianza,
                    ruta: kRutaIntervalosDeConfianza,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.mediaGeometrica,
                    ruta: kRutaMediaGeometrica,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.medidas,
                    ruta: kRutaMenuMedidas,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.momentosEstadisticos,
                    ruta: kRutaMomentosEstadisticos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.probabilidad,
                    ruta: kRutaProbabilidad,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.tamanioMuestral,
                    ruta: kRutaTamanioMuestral,
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
