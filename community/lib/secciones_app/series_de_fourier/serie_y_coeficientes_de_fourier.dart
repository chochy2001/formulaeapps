import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class SerieYCoeficientesDeFourier extends StatefulWidget {
  @override
  _SerieYCoeficientesDeFourierState createState() =>
      _SerieYCoeficientesDeFourierState();
}

class _SerieYCoeficientesDeFourierState
    extends State<SerieYCoeficientesDeFourier> {
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
                    AppLocalizations.of(context)!.serieYCoeficientesDeFourier,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .serieYCoeficientesDeFourier,
                            widgetName: kWidgetSerieYCoeficientesDeFourier),
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
                                        .serieYCoeficientesDeFourier,
                                    widgetName:
                                        kWidgetSerieYCoeficientesDeFourier),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .serieYCoeficientesDeFourier,
                                    widgetName:
                                        kWidgetSerieYCoeficientesDeFourier),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieFourier,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"f(t) = \frac{1}{2}a_0+\sum_{n=1}^{\infty}[a_n\cos(n\omega_0t)+b_n\sin(n\omega_0t)]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.donde,
                        ),
                        const Latex(formulaText: r"\omega_0 = \frac{2\pi}{T}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieFourier,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a_0 = \frac{2}{T}\int_{-T/2}^{T/2}f(t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a_n = \frac{2}{T}\int_{-T/2}^{T/2}f(t)\cos(n\omega_0t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.para,
                        ),
                        const Latex(formulaText: r"n = 0,1,2\cdots"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"b_n = \frac{2}{T}\int_{-T/2}^{T/2}f(t)\sin(n\omega_0t)dt"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.para,
                        ),
                        const Latex(formulaText: r"n = 1,2,3\cdots"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSerieYCoeficientesDeFourier,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSerieYCoeficientesDeFourier,
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
