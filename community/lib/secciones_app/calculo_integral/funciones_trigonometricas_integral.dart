import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class FuncionesTrigonometricasIntegral extends StatefulWidget {
  @override
  _FuncionesTrigonometricasIntegralState createState() =>
      _FuncionesTrigonometricasIntegralState();
}

class _FuncionesTrigonometricasIntegralState
    extends State<FuncionesTrigonometricasIntegral> {
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
                AppLocalizations.of(context)!
                    .integralesDeFuncionesTrigonometricas,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                        title: AppLocalizations.of(context)!
                            .integralesDeFuncionesTrigonometricas,
                        widgetName: kWidgetFuncionesTrigonometricasIntegral),
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
                                    .integralesDeFuncionesTrigonometricas,
                                widgetName:
                                    kWidgetFuncionesTrigonometricasIntegral),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                                title: AppLocalizations.of(context)!
                                    .integralesDeFuncionesTrigonometricas,
                                widgetName:
                                    kWidgetFuncionesTrigonometricasIntegral),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(
                height: 20.0,
              ),
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sin\thinspace u\space du = -\cos\thinspace u + C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \cos\thinspace u\space du = \sin\thinspace u + C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sec\thinspace u \cdot \tan\thinspace u \thinspace du =\frac{1}{\cos\thinspace u}+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \sec^2u\space du = \tan\thinspace u+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \csc^2\thinspace u\thinspace du = \cot\thinspace u +C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int (\sec \thinspace u \cdot \tan\thinspace u)\space du = \sec\thinspace u +C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int(\csc\thinspace u \cdot \cot\thinspace u)du = \sec\thinspace u +C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int u\cdot \sin\space u\space du = \sin\thinspace u - u\cdot \cos\thinspace u + C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int u\cdot \cos\thinspace u\space du = \cos\thinspace u + u\cdot \sin\thinspace u+ C"),
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
                url: kWidgetFuncionesTrigonometricasIntegral,
              ),
              //Descargar PDF
              const DescargarPDF(
                url: kWidgetFuncionesTrigonometricasIntegral,
              ),

              Container(
                decoration: BoxDecoration(
                  color: kColorBotones,
                  border: Border.all(
                    color: kColorFondo,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Notas(),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\sin"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.seno,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cos"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.coseno,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\tan"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.tangente,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\csc"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cosecante,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\sec"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.secante,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\cot"),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.cotangente,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\frac{du}{dx} = u^{'}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const SizedBox(height: kEspacioEntreBotones),
                    const CapdesisLatex(),
                    const SizedBox(height: kEspacioEntreBotones),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
