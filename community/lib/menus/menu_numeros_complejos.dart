import 'package:flutter/material.dart';

import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class NumerosComplejos extends StatefulWidget {
  const NumerosComplejos({super.key});

  @override
  NumerosComplejosState createState() => NumerosComplejosState();
}

class NumerosComplejosState extends State<NumerosComplejos> {
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const ImagenLogoFormulae(),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.numerosComplejos,
                        style: kTextoBotones,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    adContainer,
                    //Conjugados de numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .conjugadoDeUnNumeroComplejo,
                      ruta: kRutaConjugadoNumerosComplejos,
                    ),
                    //Modulo y Argumento numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .moduloYArgumentoDeUnNumeroComplejo,
                      ruta: kRutaModuloyArgumentoNumerosComplejos,
                    ),
                    //Operaciones de Numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .operacionesDeNumerosComplejos,
                      ruta: kRutaOperacionesNumerosComplejos,
                    ),
                    //Propiedades Números Complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .propiedadesDeLosNumerosComplejos,
                      ruta: kRutaPropiedadesNumerosComplejos,
                    ),
                    //Representaciones de Numeros complejos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .representacionesDeUnNumeroComplejo,
                      ruta: kRutaRepresentacionesDeNumerosComplejos,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
