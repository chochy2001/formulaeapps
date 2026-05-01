import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class ElipseConCentroDiferenteDelOrigen extends StatefulWidget {
  @override
  _ElipseConCentroDiferenteDelOrigenState createState() =>
      _ElipseConCentroDiferenteDelOrigenState();
}

class _ElipseConCentroDiferenteDelOrigenState
    extends State<ElipseConCentroDiferenteDelOrigen> {
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
                        .elipseConCentroDiferenteDelOrigen,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .elipseConCentroDiferenteDelOrigen,
                            widgetName:
                                kWidgetElipseConCentroDiferenteDelOrigen),
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
                                        .elipseConCentroDiferenteDelOrigen,
                                    widgetName:
                                        kWidgetElipseConCentroDiferenteDelOrigen),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .elipseConCentroDiferenteDelOrigen,
                                    widgetName:
                                        kWidgetElipseConCentroDiferenteDelOrigen),
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
                          AppLocalizations.of(context)!
                              .centroDiferenteOrigenEjeFocalX,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{(x-h)^2}{a^2}+\frac{(y-k)^2}{b^2} = 1"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F(h+c,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F'(h-c,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"V(h+a,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"V'(h-a,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"B(h,k+b)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"B'(h,k-b)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"R(h+c,k-b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"R'(h-c,k-b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L(h+c,k+b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L'(h-c,k+b^2/a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.centroOrigenEjeFocalY,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{(x-h)^2}{b^2}+\frac{(y-k)^2}{a^2} = 1"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F(h,k+c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"F'(h,k-c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"V(h,k+a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"V'(h,k-a)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"B(h+b,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"B'(h-b,k)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"R(h+b^2/a,k+c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"R'(h+b^2/a,k-c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L(h-b^2/a,k+c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"L'(h-b^2/a,k-c)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetElipseConCentroDiferenteDelOrigen,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetElipseConCentroDiferenteDelOrigen,
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
