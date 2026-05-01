import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class PropiedadesLimites extends StatefulWidget {
  @override
  _PropiedadesLimitesState createState() => _PropiedadesLimitesState();
}

class _PropiedadesLimitesState extends State<PropiedadesLimites> {
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
            Column(
              children: [
                //Propiedades de los limites
                TituloPersonalizado(
                  AppLocalizations.of(context)!.propiedadesDeLosLimites,
                ),
                adContainer,
                Consumer<FavoritesNotifier>(
                  builder: (context, favoritesNotifier, child) {
                    bool isFavorite = favoritesNotifier.isFavorite(
                      Favorite(
                          title: AppLocalizations.of(context)!
                              .propiedadesDeLosLimites,
                          widgetName: kWidgetPropiedadesLimites),
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
                                      .propiedadesDeLosLimites,
                                  widgetName: kWidgetPropiedadesLimites),
                            );
                          } else {
                            favoritesNotifier.addFavorite(
                              Favorite(
                                  title: AppLocalizations.of(context)!
                                      .propiedadesDeLosLimites,
                                  widgetName: kWidgetPropiedadesLimites),
                            );
                          }
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: kEspacioEntreBotones),
                const ZoomPersonalizado(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Latex(formulaText: r"\lim_{x \to c}k=k"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}k\cdot f(x)=k\cdot\lim_{x \to c}f(x)"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}[f(x)\pm g(x)]=\lim_{x \to c}f(x)\pm\lim_{x \to c}g(x)"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}[f(x)\cdot g(x)] = \lim_{x \to c}f(x)\cdot\lim_{x \to c}g(x)"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}\frac{f(x)}{g(x)} =  \frac{\lim_{x \to c}f(x)}{\lim_{x \to c}g(x)}"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x\to c}[f(x)^{g(x)}]=\lim_{x\to c}f(x)^{\lim_{x\to c}g(x)}"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x\to c}\log \cdot f(x) =\log\cdot \lim_{x\to c}f(x)"),

                      SizedBox(height: 70),
                      //Limites laterales
                      TextoEcuaciones('Límites Laterales'),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to c}f(x)=L \space\space\mathsf{Si\space y\space solo\space si}"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to c^-}f(x)=L"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(formulaText: r"\lim_{x \to c^+}f(x)=L"),

                      SizedBox(height: 70),

                      //Limites al infinito

                      TextoEcuaciones('Límites al infinito'),
                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to +\infty}\frac{k}{x^n} = 0"),

                      SizedBox(height: kEspacioEntreBotones),
                      Latex(
                          formulaText:
                              r"\lim_{x \to -\infty}\frac{k}{x^n} = 0"),

                      SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),

                //Boton para acceder al formulario en PDF
                const VerPDF(
                  url: kWidgetPropiedadesLimites,
                ),
                //Descargar PDF
                const DescargarPDF(
                  url: kWidgetPropiedadesLimites,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
