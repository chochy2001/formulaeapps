import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class SerieTaylorMaClaurin extends StatefulWidget {
  @override
  _SerieTaylorMaClaurinState createState() => _SerieTaylorMaClaurinState();
}

class _SerieTaylorMaClaurinState extends State<SerieTaylorMaClaurin> {
  bool seleccionadoMostrar = false;
  double catetoOpuesto = 0.0, catetoAdyacente = 0.0, hipotenusa = 0.0;

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
                    AppLocalizations.of(context)!.serieTaylorMaclaurin,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .serieTaylorMaclaurin,
                            widgetName: kWidgetSerieDeTaylorYMaClaurin),
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
                                        .serieTaylorMaclaurin,
                                    widgetName: kWidgetSerieDeTaylorYMaClaurin),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .serieTaylorMaclaurin,
                                    widgetName: kWidgetSerieDeTaylorYMaClaurin),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieDeTaylor,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Column(
                          children: [
                            SizedBox(height: 10),
                            Latex(
                                formulaText:
                                    r"f(x)=\sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!}(x-a)^n"),
                            SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieDeMaclaurin,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Column(
                          children: [
                            SizedBox(height: 10),
                            Latex(
                                formulaText:
                                    r"f(x)=\sum_{n=0}^{\infty} \frac{f^{(n)}(0)}{n!}x^n"),
                            SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.serieDePotencias,
                        ),
                        const Column(
                          children: [
                            SizedBox(height: kEspacioEntreBotones),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"e^x=1+x+\frac{x^2}{2!}+\frac{x^3}{3!}+\frac{x^4}{4!}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"\sin x=x-\frac{x^3}{3!}+\frac{x^5}{5!}-\frac{x^7}{7!}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"\cos x=1-\frac{x^2}{2!}+\frac{x^4}{4!}-\frac{x^6}{6!}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"\tan^{-1}x=x-\frac{x^3}{3}+\frac{x^5}{5}-\frac{x^7}{7}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            Latex(
                                formulaText:
                                    r"\ln(1+x)=x-\frac{x^2}{2}+\frac{x^3}{3}-\frac{x^4}{4}+..."),
                            SizedBox(height: kEspacioEntreBotones),
                            SizedBox(height: kEspacioEntreBotones),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetSerieDeTaylorYMaClaurin,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetSerieDeTaylorYMaClaurin,
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
