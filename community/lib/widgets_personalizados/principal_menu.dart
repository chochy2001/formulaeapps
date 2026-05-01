import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class PrincipalMenu extends StatefulWidget {
  const PrincipalMenu({
    Key? key,
  }) : super(key: key);
  @override
  State<PrincipalMenu> createState() => _PrincipalMenuState();
}

class _PrincipalMenuState extends State<PrincipalMenu> {
  static const AdRequest request = AdMobConfig.defaultRequest;

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
    return SafeArea(
      child: ListView(
        children: [
          //Imagen Formulae (Boton Capdesis)

          GestureDetector(
            onTap: () {
              openURLNuevo('https://capdesis.com/');
            },
            child: const FadeInImage(
              height: 100.0,
              width: 100.0,
              placeholder: AssetImage(kUrlImagenGifCarga),
              image: NetworkImage(kUrlImagenCapdesisTexto),
            ),
          ),
          adContainer,
          SizedBox(
            height: 20,
          ),
          BotonRedSocial(
            icon: FontAwesomeIcons.solidStar,
            //create a instagram icon
            text: AppLocalizations.of(context)!.descargarPro,
            url: () {
              openURLNuevo('https://linktr.ee/formulae_');
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Boton de Generales*/
                  BotonesMenu(
                    ruta: kRutaGenerales,
                    textoBoton: AppLocalizations.of(context)!.generales,
                  ),
                  /*Boton de Algebra*/
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.algebra,
                    ruta: kRutaMenuAlgebra,
                  ),
                  /*Boton de Algebra Lineal*/
                  BotonesMenu(
                    textoBoton: AppLocalizations.of(context)!.algebraLineal,
                    ruta: kRutaAlgebraLinealMenu,
                  ),
                  /*Boton de Calculo Diferencial*/
                  BotonesMenu(
                    ruta: kRutaCalculoDiferencial,
                    textoBoton:
                        AppLocalizations.of(context)!.calculoDiferencial,
                  ),
                  /*Boton de Calculo Integral*/
                  BotonesMenu(
                    ruta: kRutaCalculoIntegral,
                    textoBoton: AppLocalizations.of(context)!.calculoIntegral,
                  ),
                  /*Boton de Calculo Multivariable*/
                  BotonesMenu(
                    ruta: kRutaMenuCalculoMultivariable,
                    textoBoton:
                        AppLocalizations.of(context)!.calculoMultivariable,
                  ),
                  /*Boton de Ecuaciones Diferenciales*/
                  BotonesMenu(
                    ruta: kRutaEcuacionesDiferenciales,
                    textoBoton:
                        AppLocalizations.of(context)!.ecuacionesDiferenciales,
                  ),
                  //Boton de Electricidad y Magnetismo
                  BotonesMenu(
                    ruta: kRutaMenuElectricidadYMagnetismo,
                    textoBoton:
                        AppLocalizations.of(context)!.electricidadMagnetismo,
                  ),
                  //Boton de Geometria
                  BotonesMenu(
                    ruta: kRutaMenuGeometria,
                    textoBoton: AppLocalizations.of(context)!.geometria,
                  ),
                  //Boton Matematicas Discretas
                  BotonesMenu(
                    ruta: kRutaMenuMatematicasDiscretas,
                    textoBoton:
                        AppLocalizations.of(context)!.matematicasDiscretas,
                  ),
                  //Boton Matematicas Financieras
                  BotonesMenu(
                    ruta: kRutaMenuMatematicasFinancieras,
                    textoBoton:
                        AppLocalizations.of(context)!.matematicasFinancieras,
                  ),
                  /*Boton de Probabilidad y Estadistica*/
                  BotonesMenu(
                    ruta: kRutaMenuProbabilidadYEstadistica,
                    textoBoton:
                        AppLocalizations.of(context)!.probabilidadEstadistica,
                  ),
                  /*Boton de Series de Fourier*/
                  BotonesMenu(
                    ruta: kRutaMenuSeriesDeFourier,
                    textoBoton: AppLocalizations.of(context)!.seriesFourier,
                  ),
                  /*Boton de Trigonometria*/
                  BotonesMenu(
                    ruta: kRutaMenuTrigonometria,
                    textoBoton: AppLocalizations.of(context)!.trigonometria,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
