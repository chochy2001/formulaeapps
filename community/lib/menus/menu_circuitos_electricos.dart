import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MenuCircuitosElectricos extends StatefulWidget {
  const MenuCircuitosElectricos({Key? key}) : super(key: key);
  static final AdRequest request = AdMobConfig.defaultRequest;

  static const int maxFailedLoadAttempts = 3;

  @override
  State<MenuCircuitosElectricos> createState() =>
      _MenuCircuitosElectricosState();
}

class _MenuCircuitosElectricosState extends State<MenuCircuitosElectricos> {
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
        request: MenuCircuitosElectricos.request,
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
                MenuCircuitosElectricos.maxFailedLoadAttempts) {
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
                    AppLocalizations.of(context)!.circuitosElectricos,
                    style: kTextoBotones,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  adContainer,
                  BotonesMenu(
                    ruta: kRutaPortadoresDeCargaLibre,
                    textoBoton:
                        AppLocalizations.of(context)!.portadoresCargaLibre,
                  ),
                  BotonesMenu(
                    ruta: kRutaMovimientoDePortadoresDeCargaLibre,
                    textoBoton: AppLocalizations.of(context)!
                        .movimientoPortadoresCargaLibreDensidadCorriente,
                  ),
                  BotonesMenu(
                    ruta: kRutaDensidadDeCorrienteYCorrienteElectrica,
                    textoBoton: AppLocalizations.of(context)!
                        .densidadCorrienteCorrienteElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaTiposDeCorrienteElectrica,
                    textoBoton:
                        AppLocalizations.of(context)!.tiposCorrienteElectrica,
                  ),
                  BotonesMenu(
                    ruta: kRutaConductividadYResistividad,
                    textoBoton:
                        AppLocalizations.of(context)!.conductividadResistividad,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeOhm,
                    textoBoton: AppLocalizations.of(context)!.leyOhm,
                  ),
                  BotonesMenu(
                    ruta: kRutaEcuacionDeOhm,
                    textoBoton: AppLocalizations.of(context)!.ecuacionOhm,
                  ),
                  BotonesMenu(
                    ruta: kRutaResistividadYTemperatura,
                    textoBoton:
                        AppLocalizations.of(context)!.resistividadTemperatura,
                  ),
                  BotonesMenu(
                    ruta: kRutaEfectoJoule,
                    textoBoton: AppLocalizations.of(context)!.efectoJoule,
                  ),
                  BotonesMenu(
                    ruta: kRutaResistorSimbologiaBasica,
                    textoBoton:
                        AppLocalizations.of(context)!.resistorSimbologiaBasica,
                  ),
                  BotonesMenu(
                    ruta: kRutaResistorLinealYNoLineal,
                    textoBoton:
                        AppLocalizations.of(context)!.resistorLinealNoLineal,
                  ),
                  BotonesMenu(
                    ruta: kRutaConexionEnSerieResistor,
                    textoBoton:
                        AppLocalizations.of(context)!.conexionSerieResistor,
                  ),
                  BotonesMenu(
                    ruta: kRutaConexionEnParaleloResistor,
                    textoBoton:
                        AppLocalizations.of(context)!.conexionParaleloResistor,
                  ),
                  BotonesMenu(
                    ruta: kRutaFuenteDeFuerzaElectromotriz,
                    textoBoton:
                        AppLocalizations.of(context)!.fuenteFuerzaElectromotriz,
                  ),
                  BotonesMenu(
                    ruta: kRutaElementosCapacitorYResistor,
                    textoBoton: AppLocalizations.of(context)!
                        .elementosCapacitorResistor,
                  ),
                  BotonesMenu(
                    ruta: kRutaElementosFem,
                    textoBoton: AppLocalizations.of(context)!
                        .elementosFuerzaElectromotriz,
                  ),
                  BotonesMenu(
                    ruta: kRutaTeoriaDeCircuitos,
                    textoBoton: AppLocalizations.of(context)!.teoriaCircuitos,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeVoltajesDeKirchhoff,
                    textoBoton:
                        AppLocalizations.of(context)!.leyVoltajesKirchhoff,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyDeCorrientesDeKirchhoff,
                    textoBoton:
                        AppLocalizations.of(context)!.leyCorrientesKirchhoff,
                  ),
                  BotonesMenu(
                    ruta: kRutaReglasParaLVKyLCK,
                    textoBoton: AppLocalizations.of(context)!.reglasLVKLCK,
                  ),
                  BotonesMenu(
                    ruta: kRutaCircuitoRCyVoltajeContinuo,
                    textoBoton:
                        AppLocalizations.of(context)!.circuitoRCVoltajeContinuo,
                  ),
                  BotonesMenu(
                    ruta: kRutaLeyesDeKirchhoffCircuitoRC,
                    textoBoton:
                        AppLocalizations.of(context)!.leyesKirchhoffCircuitoRC,
                  ),
                  BotonesMenu(
                    ruta: kRutaNomenclaturaBasicaEmpleadaEnCircuitos,
                    textoBoton: AppLocalizations.of(context)!
                        .nomenclaturaBasicaCircuitos,
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
