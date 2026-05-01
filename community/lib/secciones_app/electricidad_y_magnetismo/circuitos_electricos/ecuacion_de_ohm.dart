import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class EcuacionDeOhm extends StatefulWidget {
  @override
  State<EcuacionDeOhm> createState() => _EcuacionDeOhmState();
}

class _EcuacionDeOhmState extends State<EcuacionDeOhm> {
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
              AppLocalizations.of(context)!.ecuacionOhm,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.ecuacionOhm,
                      widgetName: kWidgetEcuacionDeOhm),
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
                              title: AppLocalizations.of(context)!.ecuacionOhm,
                              widgetName: kWidgetEcuacionDeOhm),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.ecuacionOhm,
                              widgetName: kWidgetEcuacionDeOhm),
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
                    AppLocalizations.of(context)!.alambreConductor,
                  ),
                  const SizedBox(height: 40.0),
                  const Latex(
                      formulaText: r"i = \iint \vec{J}\cdot d\vec{A} = JA"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"V = - \iint \vec{E}\cdot d\vec{l} = EL"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeOhm,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"|\vec{J}| = \sigma |\vec{E}|"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\frac{i}{A} = \sigma\frac{V}{L}"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"V= \rho\frac{L}{A} i"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.resistenciaElectrica,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"R= \rho\frac{L}{A}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"[R]_u = \left[\frac{V}{A}\right] = [\Omega]"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"V = Ri"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"[\Omega] = Ohm"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.ecuacionDeOhm,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetEcuacionDeOhm,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetEcuacionDeOhm,
            ),
          ],
        ),
      ),
    );
  }
}
