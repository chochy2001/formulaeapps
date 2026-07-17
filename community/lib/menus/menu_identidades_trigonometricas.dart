import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuIdentidadesTrigonometricas extends StatefulWidget {
  const MenuIdentidadesTrigonometricas({super.key});

  @override
  MenuIdentidadesTrigonometricasState createState() =>
      MenuIdentidadesTrigonometricasState();
}

class MenuIdentidadesTrigonometricasState
    extends State<MenuIdentidadesTrigonometricas> {
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
                    AppLocalizations.of(context)!.identidadesTrigonometricas,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.deAnguloDobleYMedio,
                    ruta: kRutaIdentidadesTrigonometricasDeAnguloDobleYMedio,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.deSumaAProductoYViceversa,
                    ruta:
                        kRutaIdentidadesTrigonometricasDeSumaAProductoYViceversa,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.deSumaYRestaDeAngulos,
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
