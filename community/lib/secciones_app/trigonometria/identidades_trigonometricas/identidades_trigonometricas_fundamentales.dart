import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class IdentidadesTrigonometricasFundamentales extends StatefulWidget {
  @override
  _IdentidadesTrigonometricasFundamentalesState createState() =>
      _IdentidadesTrigonometricasFundamentalesState();
}

class _IdentidadesTrigonometricasFundamentalesState
    extends State<IdentidadesTrigonometricasFundamentales> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.identidadesTrigonometricas,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .identidadesTrigonometricas,
                            widgetName:
                                kWidgetIdentidadesTrigonometricasFundamentales),
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
                                        .identidadesTrigonometricas,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasFundamentales),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .identidadesTrigonometricas,
                                    widgetName:
                                        kWidgetIdentidadesTrigonometricasFundamentales),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText: r"\sin\alpha = \frac{1}{\csc \alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText: r"\csc\alpha = \frac{1}{\sin\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText: r"\cos\alpha = \frac{1}{\sec\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText: r"\sec\alpha = \frac{1}{\cos\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\tan\alpha = \frac{\sin\alpha}{\cos\alpha} = \frac{1}{\cot\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"\cot \alpha = \frac{\cos\alpha}{\sin\alpha} = \frac{1}{\tan\alpha}"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin^2\alpha+\cos^2\alpha = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\tan^2\alpha+1 = \sec^2\alpha"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cot^2\alpha+1 = \csc^2\alpha"),
                        SizedBox(height: kEspacioEntreBotones),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\sin\alpha\cdot \csc\alpha = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\cos\alpha\cdot\sec\alpha = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"\tan\alpha\cdot\cot\alpha = 1"),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetIdentidadesTrigonometricasFundamentales,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetIdentidadesTrigonometricasFundamentales,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
