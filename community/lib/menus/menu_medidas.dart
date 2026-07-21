import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuMedidas extends StatefulWidget {
  const MenuMedidas({super.key});

  @override
  MenuMedidasState createState() => MenuMedidasState();
}

class MenuMedidasState extends State<MenuMedidas> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
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
                  adContainer,
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
