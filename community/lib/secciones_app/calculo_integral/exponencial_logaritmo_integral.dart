import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class ExponencialyLogaritmoIntegral extends StatefulWidget {
  @override
  _ExponencialyLogaritmoIntegralState createState() =>
      _ExponencialyLogaritmoIntegralState();
}

class _ExponencialyLogaritmoIntegralState
    extends State<ExponencialyLogaritmoIntegral> {
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
                    .integralesDelExponencialYLogaritmos,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                        title: AppLocalizations.of(context)!
                            .integralesDelExponencialYLogaritmos,
                        widgetName: kWidgetExponencialLogaritmoIntegral),
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
                                    .integralesDelExponencialYLogaritmos,
                                widgetName:
                                    kWidgetExponencialLogaritmoIntegral),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                                title: AppLocalizations.of(context)!
                                    .integralesDelExponencialYLogaritmos,
                                widgetName:
                                    kWidgetExponencialLogaritmoIntegral),
                          );
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(
                height: 30.0,
              ),
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"\int e^u\space du = e^u+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int a^u\space du = \frac{a^u}{ln|a|}+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int u\thinspace a^u\space du = \frac{a^u}{ln|a|}\left(u-\frac{1}{ln|a|}\right)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int u\thinspace e^u\space du = (u-1)e^u+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int e^{au}\sin(bu)\thinspace du = \frac{e^{(au)}}{a^2+b^2}(a\thinspace \sin(bu)-b\cos(bu))+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int e^{au}\cos(bu)\thinspace du = \frac{e^{(au)}}{a^2+b^2}(a\thinspace \cos(bu)+b\sin(bu))+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int ln\thinspace u\space du = u\thinspace ln(u) - u + C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int \frac{1}{u\thinspace ln(u)}du = ln|ln(u)|+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int log_au\thinspace du = \frac{1}{ln|a|}(u\space ln|u|-u)=\frac{u}{ln|a|}(ln\thinspace u-1)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int ulog_au\thinspace du = \frac{u^2}{4}(2log_au-1)+C"),
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\int u\thinspace ln|u| \space du = \frac{u^2}{4}(2ln|u|-1)+C"),
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
                url: kWidgetExponencialLogaritmoIntegral,
              ),
              //Descargar PDF
              const DescargarPDF(
                url: kWidgetExponencialLogaritmoIntegral,
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
                    const Latex(formulaText: r"ln(u) = log_e(u)"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText:
                            r"ln(x) = \int_1 ^x \frac{dt}{t},\space x>0"),
                    const SizedBox(height: kEspacioEntreBotones),
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.logaritmoNaturalDefinicion,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"e \thickapprox 2,71828"),
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
