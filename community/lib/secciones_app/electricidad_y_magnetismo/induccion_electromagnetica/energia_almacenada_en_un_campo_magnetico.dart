import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class EnergiaAlmacenadaEnUnCampoMagnetico extends StatefulWidget {
  @override
  State<EnergiaAlmacenadaEnUnCampoMagnetico> createState() =>
      _EnergiaAlmacenadaEnUnCampoMagneticoState();
}

class _EnergiaAlmacenadaEnUnCampoMagneticoState
    extends State<EnergiaAlmacenadaEnUnCampoMagnetico> {
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
              AppLocalizations.of(context)!.energiaAlmacenadaEnUnCampoMagnetico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .energiaAlmacenadaEnUnCampoMagnetico,
                      widgetName: kWidgetEnergiaAlmacenadaEnUnCampoMagnetico),
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
                                  .energiaAlmacenadaEnUnCampoMagnetico,
                              widgetName:
                                  kWidgetEnergiaAlmacenadaEnUnCampoMagnetico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .energiaAlmacenadaEnUnCampoMagnetico,
                              widgetName:
                                  kWidgetEnergiaAlmacenadaEnUnCampoMagnetico),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.enElCasoDeUnSolenoideLargo,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"L = \frac{\mu_0N^2A}{l}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"U = \frac{1}{2}LI^2 = \frac{1}{2}\frac{\mu_0N^2A}{l}I^2"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.enFuncionDelCampoMagnetico,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"B= \frac{\mu_0NI}{I}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"U = \frac{1}{2}B^2 \frac{Al}{\mu_0}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"U = \frac{1}{2\mu_0}B^2V'"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.energiaPorUnidadDeVolumen,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"u = \frac{U}{V'} = \frac{B^2}{2\mu_0}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"[u]_u = \left[\frac{J}{m^3}\right]"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .energiaDeUnCampoMagneticoNoHomogeneo,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"U = \frac{1}{2\mu_0}\iiint B^2 dV'"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetEnergiaAlmacenadaEnUnCampoMagnetico,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetEnergiaAlmacenadaEnUnCampoMagnetico,
            ),
          ],
        ),
      ),
    );
  }
}
