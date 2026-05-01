import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MenuCapacitanciaYDielectricos extends StatefulWidget {
  const MenuCapacitanciaYDielectricos({Key? key}) : super(key: key);

  static final AdRequest request = AdMobConfig.defaultRequest;

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuCapacitanciaYDielectricos> createState() =>
      _MenuCapacitanciaYDielectricosState();
}

class _MenuCapacitanciaYDielectricosState
    extends State<MenuCapacitanciaYDielectricos> {
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
        request: MenuCapacitanciaYDielectricos.request,
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
                MenuCapacitanciaYDielectricos.maxFailedLoadAttempts) {
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
                    AppLocalizations.of(context)!.capacitanciaDielectricos,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaCapacitor,
                    textoBoton: AppLocalizations.of(context)!.capacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaCargaDeUnCapacitor,
                    textoBoton: AppLocalizations.of(context)!.cargaCapacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaDefinicionDeCapacitancia,
                    textoBoton:
                        AppLocalizations.of(context)!.definicionCapacitancia,
                  ),
                  BotonesMenu(
                    ruta: kRutaGraficaDeCapacitancia,
                    textoBoton:
                        AppLocalizations.of(context)!.graficaCapacitancia,
                  ),
                  BotonesMenu(
                    ruta: kRutaSimbologiaCapacitores,
                    textoBoton:
                        AppLocalizations.of(context)!.simbologiaCapacitores,
                  ),
                  BotonesMenu(
                    ruta: kRutaCapacitorDePlacasPlanasYParalelas,
                    textoBoton: AppLocalizations.of(context)!
                        .capacitorPlacasPlanasParalelas,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaYCapacitancia,
                    textoBoton:
                        AppLocalizations.of(context)!.energiaCapacitancia,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaAlmacenadaPorUnCapacitor,
                    textoBoton: AppLocalizations.of(context)!
                        .energiaAlmacenadaCapacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaConexionEnSerieCapacitor,
                    textoBoton:
                        AppLocalizations.of(context)!.conexionSerieCapacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaConexionEnParaleloCapacitor,
                    textoBoton:
                        AppLocalizations.of(context)!.conexionParaleloCapacitor,
                  ),
                  BotonesMenu(
                    ruta: kRutaPolarizacion,
                    textoBoton: AppLocalizations.of(context)!.polarizacion,
                  ),
                  BotonesMenu(
                    ruta: kRutaPolarizacionYCargaInducida,
                    textoBoton:
                        AppLocalizations.of(context)!.polarizacionCargaInducida,
                  ),
                  BotonesMenu(
                    ruta: kRutaConstantesDielectricas,
                    textoBoton:
                        AppLocalizations.of(context)!.constantesDielectricas,
                  ),
                  BotonesMenu(
                    ruta: kRutaRigidezDielectrica,
                    textoBoton:
                        AppLocalizations.of(context)!.rigidezDielectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaVectorDeDesplazamientoElectrico,
                    textoBoton: AppLocalizations.of(context)!
                        .vectorDesplazamientoElectrico,
                  ),
                  BotonesMenu(
                    ruta: kRutaRepresentacionDeLosVectoresElectricos,
                    textoBoton: AppLocalizations.of(context)!
                        .representacionVectoresElectricos,
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
