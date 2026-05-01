import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class DefinicionDeCampoMagnetico extends StatefulWidget {
  @override
  State<DefinicionDeCampoMagnetico> createState() =>
      _DefinicionDeCampoMagneticoState();
}

class _DefinicionDeCampoMagneticoState
    extends State<DefinicionDeCampoMagnetico> {
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
              AppLocalizations.of(context)!.definicionDeCampoMagnetico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .definicionDeCampoMagnetico,
                      widgetName: kWidgetDefinicionDeCampoMagnetico),
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
                                  .definicionDeCampoMagnetico,
                              widgetName: kWidgetDefinicionDeCampoMagnetico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .definicionDeCampoMagnetico,
                              widgetName: kWidgetDefinicionDeCampoMagnetico),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.campoMagnetico,
                ),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenExperimentoOersted),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elCampoMagneticoB,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.fenomenologia,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.laIntensidadDelCampoMagnetico,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.siLaVelocidadSeInvierte,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elCampoMagneticoSeAnula,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elCampoMagneticoEsTangente,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .laMagnitudDelCampoMagneticoDisminuye,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenExperimentoOersted),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"B\propto \frac{qv\sin{\theta}}{r^2}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"B=K \frac{qv\sin{\theta}}{r^2}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"K= \frac{\mu _0}{4\pi} = 10^{-7}\left[\frac{T\cdot m}{A}\right]"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.constanteDePermeabilidad,
                ),
                const SizedBox(height: 10.0),
                const Latex(
                    formulaText:
                        r"\mu_0 = 4\pi \times 10^{-7}\left[\frac{T\cdot m}{A}\right]"),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCampoMagnetico),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeBiotSavart,
                ),
                const SizedBox(height: 10.0),
                const Latex(
                    formulaText:
                        r"\vec{B}=\frac{\mu_0}{4\pi}\frac{q\vec{v}\times\hat{r}}{r^2}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{B}=\frac{\mu_0}{4\pi}\frac{q\vec{v}\times\bar{r}}{r^3}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineasDeCampoMagnetico,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elCampoMagneticoSeRepresenta,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.aEstasLineasSeLesDenomina,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.laTangenteALaLineaDeCampo,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .lasLineasDeCampoMagneticoSonContinuas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .lasLineasDeCampoMagneticoSonContinuas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .laMagnitudDelCampoMagneticoEnUnPunto,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetDefinicionDeCampoMagnetico,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetDefinicionDeCampoMagnetico,
            ),
          ],
        ),
      ),
    );
  }
}
