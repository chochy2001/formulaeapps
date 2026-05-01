import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class InductanciaPropiaDeUnSolenoide extends StatefulWidget {
  @override
  State<InductanciaPropiaDeUnSolenoide> createState() =>
      _InductanciaPropiaDeUnSolenoideState();
}

class _InductanciaPropiaDeUnSolenoideState
    extends State<InductanciaPropiaDeUnSolenoide> {
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
              AppLocalizations.of(context)!.inductanciaPropiaDeUnSolenoide,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .inductanciaPropiaDeUnSolenoide,
                      widgetName: kWidgetInductanciaPropiaDeUnSolenoide),
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
                                  .inductanciaPropiaDeUnSolenoide,
                              widgetName:
                                  kWidgetInductanciaPropiaDeUnSolenoide),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .inductanciaPropiaDeUnSolenoide,
                              widgetName:
                                  kWidgetInductanciaPropiaDeUnSolenoide),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const ZoomImagePersonalizado(
                urlImagen: kUrlImagenInductanciaPropiaDeUnSolenoide),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .flujoMagneticoEnUnSolenoideIdeal,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\Phi_B = \iint \vec{B} \cdot d\vec{A} = \mu_0 nIA"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.flujoTotalConcatenado,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\lambda = N\Phi_B = \frac{\mu_0 N^2IA}{l}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laInductancia,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"L = \frac{\lambda }{I} = \frac{\mu_0 N^2A}{l}"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetInductanciaPropiaDeUnSolenoide,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetInductanciaPropiaDeUnSolenoide,
            ),
          ],
        ),
      ),
    );
  }
}
