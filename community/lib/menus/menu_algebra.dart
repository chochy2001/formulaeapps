import 'package:flutter/material.dart';

import '../../../constantes/export_constantes.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class MenuAlgebra extends StatefulWidget {
  const MenuAlgebra({Key? key}) : super(key: key);

  @override
  MenuAlgebraState createState() => MenuAlgebraState();
}

class MenuAlgebraState extends State<MenuAlgebra> {
  static final AdRequest request = AdMobConfig.defaultRequest;

  static const int maxFailedLoadAttempts = 3;

  late BannerAd myBanner;
  late InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    myBanner = BannerAd(
      adUnitId: AdMobConfig.bannerAdUnitId,
      size: AdSize.banner,
      request: AdMobConfig.defaultRequest,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            // Update adContainer with the correct width and height.
            adContainer = Container(
              alignment: Alignment.center,
              child: AdWidget(ad: myBanner),
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
            );
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    myBanner.load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobConfig.interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd?.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  Container adContainer = Container(
    alignment: Alignment.center,
    child: SizedBox(
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
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
              TextButton(
                onPressed: () {},
                child: const ImagenLogoFormulae(),
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.algebra,
                  style: kTextoBotones,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              adContainer,
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SolucionEcuaciones
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.solucionEcuaciones,
                      ruta: kRutaSolucionEcuaciones,
                    ),
                    //Ecuaciones Lineales
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.ecuacionesLineales,
                      ruta: kRutaEcuacionesLineales,
                    ),
                    //Formula General
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.formulaGeneral,
                      ruta: kRutaFormulaGeneral,
                    ),
                    //Formulas de Productos
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.formulaProductos,
                      ruta: kRutaFormulasDeProductos,
                    ),
                    //Formulas de Factorizacion
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.formulasFactorizacion,
                      ruta: kRutaFormulasDeFactorizacion,
                    ),
                    //Numeros complejos
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.numerosComplejos,
                      ruta: kRutaNumerosComplejos,
                    ),
                    //Operaciones con Fracciones Algebraicas
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .operacionesFraccionesAlgebraicas,
                      ruta: kRutaOperacionesFraccionesAlgebraicas,
                    ),
                    //Propiedades de los Exponentes
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.operacionesPolinomios,
                      ruta: kRutaOperacionesConPolinomios,
                    ),
                    //Propiedades de las Desigualdades
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.propiedadesExponentes,
                      ruta: kRutaPropiedadesDeLosExponentes,
                    ),
                    //Propiedades de los radicales
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .propiedadesDesigualdades,
                      ruta: kRutaPropiedadesDesigualdad,
                    ),
                    //Serie taylor y MaClaurin
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.propiedadesRadicales,
                      ruta: kRutaPropiedadesRadicales,
                    ),
                    //Serie de Taylor y MaClaurin
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.serieTaylorMaclaurin,
                      ruta: kRutaSerieTaylorMaClaurin,
                    ),
                    //Teorema de la Sumatoria
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.teoremaSumatoria,
                      ruta: kRutaTeoremaSumatorias,
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
