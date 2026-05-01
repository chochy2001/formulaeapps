import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LeyesDeSenosCosenosTangentes extends StatefulWidget {
  @override
  _LeyesDeSenosCosenosTangentesState createState() =>
      _LeyesDeSenosCosenosTangentesState();
}

class _LeyesDeSenosCosenosTangentesState
    extends State<LeyesDeSenosCosenosTangentes> {
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
                    AppLocalizations.of(context)!.leyDeSenosCosenosYTangente,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .leyDeSenosCosenosYTangente,
                            widgetName: kWidgetLeyesDeSenosCosenosTangentes),
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
                                        .leyDeSenosCosenosYTangente,
                                    widgetName:
                                        kWidgetLeyesDeSenosCosenosTangentes),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .leyDeSenosCosenosYTangente,
                                    widgetName:
                                        kWidgetLeyesDeSenosCosenosTangentes),
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
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.leySenos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{a}{\sin A} = \frac{b}{\sin B} = \frac{c}{\sin C}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.leyCosenos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a^2=b^2+c^2-2bc\cdot\cos A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"b^2=a^2+c^2-2ac\cdot\cos B"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c^2=a^2+b^2-2ab\cdot\cos C"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\cos A = \frac{b^2+c^2-a^2}{2bc}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\cos B = \frac{a^2+c^2-b^2}{2ac}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\cos C = \frac{a^2+b^2-c^2}{2ab}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.teoremaTangente,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{a+b}{a-b} = \frac{\tan\left[\frac{A+B}{2}\right]}{tan \left[\frac{A-B}{2}\right]}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{a+c}{a-c} = \frac{\tan\left[\frac{A+C}{2}\right]}{tan \left[\frac{A-C}{2}\right]}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{b+c}{b-c} = \frac{\tan\left[\frac{B+C}{2}\right]}{tan \left[\frac{B-C}{2}\right]}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetLeyesDeSenosCosenosTangentes,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetLeyesDeSenosCosenosTangentes,
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
