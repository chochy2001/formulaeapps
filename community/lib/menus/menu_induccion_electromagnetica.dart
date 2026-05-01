import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MenuInduccionElectromagnetica extends StatefulWidget {
  const MenuInduccionElectromagnetica({Key? key}) : super(key: key);
  static final AdRequest request = AdMobConfig.defaultRequest;

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuInduccionElectromagnetica> createState() =>
      _MenuInduccionElectromagneticaState();
}

class _MenuInduccionElectromagneticaState
    extends State<MenuInduccionElectromagnetica> {
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
        request: MenuInduccionElectromagnetica.request,
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
            if (_numInterstitialLoadAttempts <
                MenuInduccionElectromagnetica.maxFailedLoadAttempts) {
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
                    AppLocalizations.of(context)!.induccionElectromagnetica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaGeneradorHomopolar,
                    textoBoton:
                        AppLocalizations.of(context)!.generadorHomopolar,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaPropia,
                    textoBoton: AppLocalizations.of(context)!.inductanciaPropia,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaMutua,
                    textoBoton: AppLocalizations.of(context)!.inductanciaMutua,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaPropiaDeUnSolenoide,
                    textoBoton: AppLocalizations.of(context)!
                        .inductanciaPropiaDeUnSolenoide,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaParaUnToroide,
                    textoBoton:
                        AppLocalizations.of(context)!.inductanciaParaUnToroide,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductanciaMutuaEntreDosSolenoidesCoaxiales,
                    textoBoton: AppLocalizations.of(context)!
                        .inductanciaMutuaEntreDosSolenoidesCoaxiales,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeInduccionDeFaraday,
                    textoBoton: AppLocalizations.of(context)!
                        .leyDeInduccionDeFaradayYEnergisEnUnInductor,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaAlmacenadaEnUnCampoMagnetico,
                    textoBoton: AppLocalizations.of(context)!
                        .energiaAlmacenadaEnUnCampoMagnetico,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductor,
                    textoBoton: AppLocalizations.of(context)!.inductor,
                  ),
                  BotonesMenu(
                    ruta: kRutaInductorEnSerie,
                    textoBoton: AppLocalizations.of(context)!.inductoresEnSerie,
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
