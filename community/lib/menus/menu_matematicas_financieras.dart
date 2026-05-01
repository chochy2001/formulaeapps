import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MenuMatematicasFinancieras extends StatefulWidget {
  const MenuMatematicasFinancieras({Key? key}) : super(key: key);

  @override
  MenuMatematicasFinancierasState createState() =>
      MenuMatematicasFinancierasState();
}

class MenuMatematicasFinancierasState
    extends State<MenuMatematicasFinancieras> {
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
                  AppLocalizations.of(context)!.matematicasFinancieras,
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
                    //Bicondicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.amortizacion,
                      ruta: kRutaAmortizacion,
                    ),
                    //Condicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .anualidadAnticipadaSimpleYCierta,
                      ruta: kRutaAnualidadAnticipadaSimpleYCierta,
                    ),
                    //Conectores Logicos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!
                          .anualidadVencidaSimpleYCierta,
                      ruta: kRutaAnualidadAnticipadaSimpleYCierta,
                    ),
                    //Conjuncion
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.descuentoCompuesto,
                      ruta: kRutaDescuentoCompuesto,
                    ),
                    //Disyuncion
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.descuentoSimple,
                      ruta: kRutaDescuentoSimple,
                    ),
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.interesCompuesto,
                      ruta: kRutaInteresCompuesto,
                    ),
                    //Leyes de la logica proposicional
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.interesSimple,
                      ruta: kRutaInteresSimple,
                    ),
                    //Leyes de la Teoria de Conjuntos
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.saldoInsoluto,
                      ruta: kRutaSaldoInsoluto,
                    ),
                    //Leyes del Algebra de Boole
                    BotonesMenu(
                      textoBoton:
                          AppLocalizations.of(context)!.tasaDeInteresGlobal,
                      ruta: kRutaTasaDeInteresGlobal,
                    ),
                    BotonesMenu(
                      textoBoton: AppLocalizations.of(context)!.tasaEfectiva,
                      ruta: kRutaTasaEfectiva,
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
