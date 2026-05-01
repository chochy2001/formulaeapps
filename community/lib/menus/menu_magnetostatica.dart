import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MenuMagnetostatica extends StatefulWidget {
  const MenuMagnetostatica({Key? key}) : super(key: key);
  static final AdRequest request = AdMobConfig.defaultRequest;

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuMagnetostatica> createState() => _MenuMagnetostaticaState();
}

class _MenuMagnetostaticaState extends State<MenuMagnetostatica> {
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
        request: MenuMagnetostatica.request,
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
                MenuMagnetostatica.maxFailedLoadAttempts) {
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
                    AppLocalizations.of(context)!.magnetostatica,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaOrigenDeCampoMagnetico,
                    textoBoton: AppLocalizations.of(context)!
                        .descripcionDeLosImanesYExperimentosDeOersted,
                  ),
                  BotonesMenu(
                    ruta: kRutaFuerzaMagneticaComoVectorSobreCargasEnMovimiento,
                    textoBoton: AppLocalizations.of(context)!
                        .fuerzaMagneticaComoVectorSobreCargasEnMovimiento,
                  ),
                  BotonesMenu(
                    ruta: kRutaDefinicionDeCampoMagnetico,
                    textoBoton: AppLocalizations.of(context)!
                        .definicionDeCampoMagnetico,
                  ),
                  BotonesMenu(
                    ruta: kRutaFuerzaDeLorentz,
                    textoBoton: AppLocalizations.of(context)!.fuerzaDeLorentz,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeBiotSavart,
                    textoBoton: AppLocalizations.of(context)!.leyDeBiotSavart,
                  ),
                  BotonesMenu(
                    ruta: kRutaSegmentoConductorRecto,
                    textoBoton:
                        AppLocalizations.of(context)!.segmentoConductorRecto,
                  ),
                  BotonesMenu(
                    ruta: kRutaEspiraEnFormaDeCircunferencia,
                    textoBoton: AppLocalizations.of(context)!
                        .espiraEnFormaDeCircunferencia,
                  ),
                  BotonesMenu(
                    ruta: kRutaEspiraCuadrada,
                    textoBoton: AppLocalizations.of(context)!.espiraCuadrada,
                  ),
                  BotonesMenu(
                    ruta: kRutaBobina,
                    textoBoton: AppLocalizations.of(context)!.bobina,
                  ),
                  BotonesMenu(
                    ruta: kRutaSolenoide,
                    textoBoton: AppLocalizations.of(context)!.solenoide,
                  ),
                  BotonesMenu(
                    ruta: kRutaCirculacionDeUnCampoVectorial,
                    textoBoton: AppLocalizations.of(context)!
                        .circulacionDeUnCampoVectorial,
                  ),
                  BotonesMenu(
                    ruta: kRutaCampoMagneticoAPartirDeLeyDeAmpere,
                    textoBoton: AppLocalizations.of(context)!
                        .campoMagneticoAPartirDeLeyDeAmpere,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeAmpereEnFormaDiferencial,
                    textoBoton: AppLocalizations.of(context)!
                        .leyDeAmpereEnFormaDiferencial,
                  ),
                  BotonesMenu(
                    ruta: kRutaFlujoMagnetico,
                    textoBoton: AppLocalizations.of(context)!.flujoMagnetico,
                  ),
                  BotonesMenu(
                    ruta: kRutaMotorDeCorrienteDirecta,
                    textoBoton:
                        AppLocalizations.of(context)!.motorDeCorrienteDirecta,
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
