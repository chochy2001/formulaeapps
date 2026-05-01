import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class IntegralesExtraIntegral extends StatefulWidget {
  @override
  _IntegralesExtraIntegralState createState() =>
      _IntegralesExtraIntegralState();
}

class _IntegralesExtraIntegralState extends State<IntegralesExtraIntegral> {
  bool seleccionadoMostrar = true;

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
        child: SafeArea(
          child: ListView(
            children: [
              TituloPersonalizado(
                AppLocalizations.of(context)!.integralesExtras,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                        title: AppLocalizations.of(context)!.integralesExtras,
                        widgetName: kWidgetIntegralesExtrasIntegral),
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
                                    .integralesExtras,
                                widgetName: kWidgetIntegralesExtrasIntegral),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                                title: AppLocalizations.of(context)!
                                    .integralesExtras,
                                widgetName: kWidgetIntegralesExtrasIntegral),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(
                height: 40.0,
              ),
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{\sqrt{a^2-u^2}}du = \sin^{-1}\left(\frac{u}{a}\right)+C = -\cos^{-1}\left(\frac{u}{a}\right)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{u\sqrt{a^2\pm u^2}}du = \frac{1}{a}ln|\frac{u}{a+\sqrt{a^2\pm u^2}}|+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{\sqrt{u^2\pm a^2}}du = ln|u+\sqrt{u^2\pm a^2}|+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{u\sqrt{u^2- a^2}}du = \frac{1}{a}\cos^{-1}(\frac{a}{u})+C = \frac{1}{a}\sec^{-1}(\frac{u}{a})+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{a^2+u^2}du = \frac{1}{a}\tan^{-1}(\frac{u}{a})+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{a^2-u^2}du = \frac{1}{2a}ln|\frac{u+a}{u-a}|+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{u^2-a^2}du = \frac{1}{2a}ln|\frac{u-a}{u+a}|+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sqrt{a^2+u^2}du = \frac{u}{2}\sqrt{a^2+u^2}+\frac{a^2}{2}ln|u+\sqrt{a^2+u^2}|+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sqrt{a^2-u^2}du = \frac{u}{2}\sqrt{a^2-u^2}+\frac{a^2}{2}\sin^{-1}(\frac{u}{a})+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sqrt{u^2\pm a^2}du = \frac{u}{2}\sqrt{u^2\pm a^2}\pm\frac{a^2}{2}ln|u+\sqrt{u^2\pm a^2}|+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sqrt{2au- u^2}du= \frac{u-a}{2}\sqrt{2au-u^2}+\frac{a^2}{2}\cos^{-1}(\frac{a-u}{a})+C"),
                    SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),

              const SizedBox(
                height: kEspacioEntreBotones,
              ),

              const Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              //Boton para acceder al formulario en PDF
              const VerPDF(
                url: kWidgetIntegralesExtrasIntegral,
              ),
              //Descargar PDF
              const DescargarPDF(
                url: kWidgetIntegralesExtrasIntegral,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
