import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class MenuLimites extends StatefulWidget {
  const MenuLimites({super.key});

  @override
  MenuLimitesState createState() => MenuLimitesState();
}

class MenuLimitesState extends State<MenuLimites> {
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
                    AppLocalizations.of(context)!.limites,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  //Propiedades de los Limites
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.propiedadesDeLosLimites,
                    ruta: kRutaPropiedadesLimites,
                  ),
                  //Limites Trigonometricos
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.limitesTrigonometricos,
                    ruta: kRutaLimitesTrigonometricos,
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
