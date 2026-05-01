import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MenuGeometria extends StatefulWidget {
  const MenuGeometria({Key? key}) : super(key: key);

  @override
  MenuGeometriaState createState() => MenuGeometriaState();
}

class MenuGeometriaState extends State<MenuGeometria> {
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
                    AppLocalizations.of(context)!.geometria,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  //Propiedades Logaritmos
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.angulosEnUnPoligono,
                    ruta: kRutaAngulosEnUnPoligono,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.areas,
                    ruta: kRutaMenuAreasGeometria,
                  ),
                  //Funciones Trigonometricas
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.circunferencia,
                    ruta: kRutaCircunferencia,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .distanciaDeUnPuntoAUnaRecta,
                    ruta: kRutaDistanciaDeUnPuntoAUnaRecta,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.distanciaEntreDosPuntos,
                    ruta: kRutaDistanciaEntreDosPuntos,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.ecuacionDeLaRecta,
                    ruta: kRutaEcuacionDeLaRecta,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .elipseConCentroDiferenteDelOrigen,
                    ruta: kRutaElipseConCentroDiferenteDelOrigen,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.elipseConCentroEnElOrigen,
                    ruta: kRutaElipseConCentroDiferenteDelOrigen,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.hiperbola,
                    ruta: kRutaHiperbola,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .parabolaConVerticeDiferenteDelOrigen,
                    ruta: kRutaParabolaConVerticeDiferenteDelOrigen,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .parabolaConVerticeEnElOrigen,
                    ruta: kRutaParabolaConVerticeEnElOrigen,
                  ),
                  BotonesMenu(
                    textoBoton:
                        AppLocalizations.of(context)!.puntoMedioEntreDosPuntos,
                    ruta: kRutaPuntoMedioEntreDosPuntosGeometria,
                  ),
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!
                        .volumenDeCuerposGeometricos,
                    ruta: kRutaVolumenDeCuerposGeometricos,
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
