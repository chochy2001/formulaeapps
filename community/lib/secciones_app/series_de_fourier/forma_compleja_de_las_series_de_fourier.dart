import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class FormaComplejaDeLasSeriesDeFourier extends StatefulWidget {
  @override
  _FormaComplejaDeLasSeriesDeFourierState createState() =>
      _FormaComplejaDeLasSeriesDeFourierState();
}

class _FormaComplejaDeLasSeriesDeFourierState
    extends State<FormaComplejaDeLasSeriesDeFourier> {
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
                    AppLocalizations.of(context)!
                        .formaComplejaDeLasSeriesDeFourier,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .formaComplejaDeLasSeriesDeFourier,
                            widgetName:
                                kWidgetFormaComplejaDeLasSeriesDeFourier),
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
                                        .formaComplejaDeLasSeriesDeFourier,
                                    widgetName:
                                        kWidgetFormaComplejaDeLasSeriesDeFourier),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .formaComplejaDeLasSeriesDeFourier,
                                    widgetName:
                                        kWidgetFormaComplejaDeLasSeriesDeFourier),
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
                          AppLocalizations.of(context)!.serieComplejaFourier,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"f(t) = c_0+\sum_{n=1}^{\infty} (c_n e^{jn\omega _0 t}+c_{-n}e^{-jn\omega _0t})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"f(t) = c_0+\sum_{n=1}^{\infty} c_n e^{jn\omega _0 t}+\sum_{n=-1}^{-\infty}c_{n}e^{jn\omega _0t}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"f(t) = \sum_{n=-\infty}^{\infty}c_{n}e^{jn\omega _0t}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieComplejaFourier,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"c_0 = \frac{1}{2}a_0 = \frac{1}{T}\int_{-T/2}^{T/2}f(t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"c_n = \frac{1}{2} (a_n-jb_n)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"c_n = \frac{1}{T}\int_{-T/2}^{T/2}f(t)e^{-jn\omega _0t}dt= \frac{1}{T}\int_{0}^{T}f(t)e^{-jn\omega _0t}dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"c_{-n} = \frac{1}{2}(a_n+jb_n)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"c_{-n} = \frac{1}{T}\int_{-T/2}^{T/2}f(t)e^{jn\omega _0t}dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\cos(n\omega _0 t) = \frac{1}{2}(e^{jn\omega _0 t}+e^{-jn\omega _0t})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\sin(n\omega _0 t) = \frac{1}{2j}(e^{jn\omega _0 t}-e^{-jn\omega _0t})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.seObtieneAnterior,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a_n = 2\mathrm{Re}[c_n]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"b_n = -2\mathrm{Im}[c_n]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a_0 = 2c_0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.teniendo,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c_n = |c_n|e^{j\phi n}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"c_{-n} = |c_n|e^{-j\phi n}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.porLoTanto,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"|c_n| = \frac{1}{2}\sqrt{a_n^2+b_n^2}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\phi _n = \tan ^{-1}\left(-\frac{b_n}{a_n}\right)"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetFormaComplejaDeLasSeriesDeFourier,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetFormaComplejaDeLasSeriesDeFourier,
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
