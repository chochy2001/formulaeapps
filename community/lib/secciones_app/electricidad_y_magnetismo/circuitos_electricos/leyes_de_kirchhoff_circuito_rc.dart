import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LeyesDeKirchhoffCircuitoRC extends StatefulWidget {
  @override
  State<LeyesDeKirchhoffCircuitoRC> createState() =>
      _LeyesDeKirchhoffCircuitoRCState();
}

class _LeyesDeKirchhoffCircuitoRCState
    extends State<LeyesDeKirchhoffCircuitoRC> {
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
      appBar: const AppBarHome(),
      body: SafeArea(
        child: ListView(
          children: [
            TituloPersonalizado(
              AppLocalizations.of(context)!.leyesKirchhoffCircuitoRC,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .leyesKirchhoffCircuitoRC,
                      widgetName: kWidgetLeyesDeKirchhoffCircuitoRc),
                );
                return IconButton(
                  icon: isFavorite
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  color: isFavorite ? Colors.white : Colors.white,
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        favoritesNotifier.removeFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyesKirchhoffCircuitoRC,
                              widgetName: kWidgetLeyesDeKirchhoffCircuitoRc),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyesKirchhoffCircuitoRC,
                              widgetName: kWidgetLeyesDeKirchhoffCircuitoRc),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeVoltajesDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_1 + V_2 + V_3 = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"-\epsilon + V_R + V_C = 0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeCorrientesDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_e = i_s"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_R = i_C"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .diferenciaDePotencialEnElResistor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_R(t) = Ri_R(t)"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .diferenciaDePotencialEnElCapacitor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"q(t) = CV_c(t)"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"i_C(t) = \frac{dq(t)}{dt} = C \frac{dV_C(t)}{dt}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ecuacionDiferencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\frac{dV_C(t)}{dt}+ \frac{V_C(t)}{RC} = \frac{\epsilon}{RC}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solucionALaEcucacionDiferencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"V_C = V_C,_{homogénea} + V_C,_{particular}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enHomogenea,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\frac{dV_C}{dt}+ \frac{V_C}{RC} = 0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solucionHomogenea,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C = a_1e^{-\frac{1}{RC}t}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ecuacionDiferencialNoHomogenea,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\frac{dV_C}{dt}+ \frac{V_C}{RC} = \frac{\epsilon}{RC}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solucionParticular,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C = a_2 = \epsilon"),
                const SizedBox(height: 20.0),
                const Divider(thickness: .2, color: kColorTextoBotones),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"V_C = a_1e^{-\frac{1}{RC}t}+ \epsilon"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.condicionALaFrontera,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C(0) = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"a_1 = -\epsilon"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .constantesDeTiempoDeCargaEnElCapacitor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\tau = RC[s]"),
                const SizedBox(height: 40.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context,
                            kImagenDiferenciaDePotencialEnElCapacitor) ??
                        kUrlImagenDiferenciaDePotencialEnElCapacitor),
                const SizedBox(height: 40.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenCorrienteEnElCapacitor) ??
                        kUrlImagenCorrienteEnElCapacitor),
                const SizedBox(height: 40.0),
                const Divider(thickness: .2, color: kColorTextoBotones),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenLeyesDeKirchhoffCircuitoRC),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.alTiempoT0InterruptorPosicionB,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.procesoDeDescargaEnUnCapacitor,
                ),
                const SizedBox(height: 40.0),
                const Divider(thickness: .2, color: kColorTextoBotones),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeVoltajesDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_1 + V_2 = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_R + V_C = 0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeCorrientesDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_R(t)+i_C(t)=0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_R(t)= -i_C(t)"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .diferenciaDePotencialEnElResistor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_R(t)= Ri_R(t)"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .diferenciaDePotencialEnElCapacitor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"q(t) = CV_C(t)"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"i_C(t) = \frac{dq(t)}{dt} = C \frac{dV_C(t)}{dt}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"Ri_R(t) - V_C(t) = -RC \frac{dV_C(t)}{dt}-V_C(t)=0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ecuacionDiferencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\frac{dV_C(t)}{dt}+\frac{V_C}{RC}=0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solucionALaEcucacionDiferencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C = a_1e^{-\frac{1}{RC}t}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.condicionALaFrontera,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C(0) = V_0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"a_1 = V_0"),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context,
                            kImagenDiferenciaDePotencialEnElCapacitor1) ??
                        kUrlImagenDiferenciaDePotencialEnElCapacitor1),
                const SizedBox(height: 40.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenCorrienteEnElCapacitor1) ??
                        kUrlImagenCorrienteEnElCapacitor1),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyesDeKirchhoffCircuitoRc,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyesDeKirchhoffCircuitoRc,
            ),
          ],
        ),
      ),
    );
  }
}
