import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MenuCampoYPotencialElectricos extends StatefulWidget {
  const MenuCampoYPotencialElectricos({Key? key}) : super(key: key);
  static final AdRequest request = AdMobConfig.defaultRequest;

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuCampoYPotencialElectricos> createState() =>
      _MenuCampoYPotencialElectricosState();
}

class _MenuCampoYPotencialElectricosState
    extends State<MenuCampoYPotencialElectricos> {
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
        request: MenuCampoYPotencialElectricos.request,
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
                MenuCampoYPotencialElectricos.maxFailedLoadAttempts) {
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
                    AppLocalizations.of(context)!.campoYPotencialElectricos,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaElectricidad,
                    textoBoton: AppLocalizations.of(context)!.electricidad,
                  ),
                  BotonesMenu(
                    ruta: kRutaCargaElectrica,
                    textoBoton: AppLocalizations.of(context)!.cargaElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaCargaProtonElectron,
                    textoBoton: AppLocalizations.of(context)!
                        .cargaElectricaProtonElectron,
                  ),
                  BotonesMenu(
                    ruta: kRutaDistribucionesDeCargaElectrica,
                    textoBoton: AppLocalizations.of(context)!
                        .distribucionesCargaElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeCoulomb,
                    textoBoton: AppLocalizations.of(context)!.leyCoulomb,
                  ),
                  BotonesMenu(
                    ruta: kRutaPrincipioDeSuperposicion,
                    textoBoton:
                        AppLocalizations.of(context)!.principioSuperposicion,
                  ),
                  BotonesMenu(
                    ruta: kRutaCampoElectrico,
                    textoBoton: AppLocalizations.of(context)!.campoElectrico,
                  ),
                  BotonesMenu(
                    ruta: kRutaCampoElectricoOriginadoPorDistribucionesDeCarga,
                    textoBoton: AppLocalizations.of(context)!
                        .campoElectricoDistribucionesCarga,
                  ),
                  BotonesMenu(
                    ruta: kRutaFlujoDeUnCampoVectorial,
                    textoBoton: AppLocalizations.of(context)!
                        .flujoElectricoCampoVectorial,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeGauss,
                    textoBoton: AppLocalizations.of(context)!.leyGauss,
                  ),
                  BotonesMenu(
                    ruta: kRutaEnergiaPotencialElectrica,
                    textoBoton:
                        AppLocalizations.of(context)!.energiaPotencialElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaCalculoDeDiferenciasDePotencial,
                    textoBoton: AppLocalizations.of(context)!
                        .calculoDiferenciasPotencial,
                  ),
                  BotonesMenu(
                    ruta: kRutaTeoremaDeLaDivergencia,
                    textoBoton:
                        AppLocalizations.of(context)!.teoremaDivergencia,
                  ),
                  BotonesMenu(
                    ruta: kRutaTeoremaDelRotacional,
                    textoBoton: AppLocalizations.of(context)!.teoremaRotacional,
                  ),
                  BotonesMenu(
                    ruta: kRutaCirculacionDelCampoElectrostatico,
                    textoBoton: AppLocalizations.of(context)!
                        .circulacionCampoElectrostatico,
                  ),
                  BotonesMenu(
                    ruta: kRutaRotacionalDelCampoElectrostatico,
                    textoBoton: AppLocalizations.of(context)!
                        .rotacionalCampoElectrostatico,
                  ),
                  BotonesMenu(
                    ruta: kRutaOperadorGradiente,
                    textoBoton: AppLocalizations.of(context)!.operadorGradiente,
                  ),
                  BotonesMenu(
                    ruta: kRutaGradienteDeUnaFuncionEscalar,
                    textoBoton:
                        AppLocalizations.of(context)!.gradienteFuncionEscalar,
                  ),
                  BotonesMenu(
                    ruta: kRutaGradienteDePotencialElectrico,
                    textoBoton: AppLocalizations.of(context)!
                        .gradientePotencialElectrico,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeGaussEnFormaDiferencial,
                    textoBoton:
                        AppLocalizations.of(context)!.leyGaussFormaDiferencial,
                  ),
                  BotonesMenu(
                    ruta: kRutaEcuacionDePoissonYLaplace,
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionPoissonLaplace,
                  ),
                  BotonesMenu(
                    ruta: kRutaSuperficiesEquipotenciales,
                    textoBoton: AppLocalizations.of(context)!
                        .superficiesEquipotenciales,
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
