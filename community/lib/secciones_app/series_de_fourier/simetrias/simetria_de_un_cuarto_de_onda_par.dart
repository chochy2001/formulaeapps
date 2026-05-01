import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class SimetriaDeUnCuartoDeOndaPar extends StatefulWidget {
  @override
  _SimetriaDeUnCuartoDeOndaParState createState() =>
      _SimetriaDeUnCuartoDeOndaParState();
}

class _SimetriaDeUnCuartoDeOndaParState
    extends State<SimetriaDeUnCuartoDeOndaPar> {
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
                    AppLocalizations.of(context)!.simetriaDeUnCuartoDeOndaPar,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .simetriaDeUnCuartoDeOndaPar,
                            widgetName: kWidgetSimetriaDeUnCuartoDeOndaPar),
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
                                        .simetriaDeUnCuartoDeOndaPar,
                                    widgetName:
                                        kWidgetSimetriaDeUnCuartoDeOndaPar),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .simetriaDeUnCuartoDeOndaPar,
                                    widgetName:
                                        kWidgetSimetriaDeUnCuartoDeOndaPar),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: kEspacioEntreBotones),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simetriaCuartoOndaPar,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"f(t) = f(-t)"),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"f(t) = -f\left(t+\frac{T}{2}\right)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"f(t) = \sum_{n=1}^{\infty} a_{2n-1}\cos[(2n-1)\omega_0t]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .coeficientesSerieFourier,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"a_0 = 0"),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"a_{2n-1} = \frac{8}{T}\int_{0}^{T/4}f(t)\cos[(2n-1)\omega_0t]dt"),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"b_{2n-1} = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSimetriaDeUnCuartoDeOndaPar,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSimetriaDeUnCuartoDeOndaPar,
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
