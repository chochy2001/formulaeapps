import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class ExponencialyLogaritmosDiferencial extends StatefulWidget {
  @override
  _ExponencialyLogaritmosDiferencialState createState() =>
      _ExponencialyLogaritmosDiferencialState();
}

class _ExponencialyLogaritmosDiferencialState
    extends State<ExponencialyLogaritmosDiferencial> {
  bool seleccionadoDX = false;
  bool seleccionadoU = true;

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
                    .derivadasDeFuncionesExponencialYLogaritmos,
              ),
              adContainer,
              Consumer<FavoritesNotifier>(
                builder: (context, favoritesNotifier, child) {
                  bool isFavorite = favoritesNotifier.isFavorite(
                    Favorite(
                        title: AppLocalizations.of(context)!
                            .derivadasDeFuncionesExponencialYLogaritmos,
                        widgetName: kWidgetExponencialLogaritmos),
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
                                    .derivadasDeFuncionesExponencialYLogaritmos,
                                widgetName: kWidgetExponencialLogaritmos),
                          );
                        } else {
                          favoritesNotifier.addFavorite(
                            Favorite(
                                title: AppLocalizations.of(context)!
                                    .derivadasDeFuncionesExponencialYLogaritmos,
                                widgetName: kWidgetExponencialLogaritmos),
                          );
                        }
                      });
                    },
                  );
                },
              ),
              //Derivación u
              const ZoomPersonalizado(
                child: Column(
                  children: [
                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"\frac{d}{dx}(a^u) = a^u ln(a) u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(formulaText: r"\frac{d}{dx}(e^u) = e^u u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(u^v) = vu^{v-1} u' + ln(u)u^v v'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(ln\space u) =\frac{u'}{u} = \frac{1}{u}u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(log\space u) = \frac{log\thinspace e}{u}u'"),

                    SizedBox(height: kEspacioEntreBotones),
                    Latex(
                        formulaText:
                            r"\frac{d}{dx}(log_a\thinspace u) = \frac{log_a\thinspace e}{u}u'\space\space\space\space a > 0,\space\space\space a\neq 1"),

                    SizedBox(height: kEspacioEntreBotones),
                    //Boton para acceder al formulario en PDF
                    VerPDF(
                      url: kWidgetExponencialLogaritmos,
                    ),
                    //Descargar PDF
                    DescargarPDF(
                      url: kWidgetExponencialLogaritmos,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kEspacioEntreBotones,
              ),
              const SizedBox(
                height: 20.0,
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
                    TextoEcuaciones(
                      AppLocalizations.of(context)!.explicacionLogaritmo,
                    ),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText: r"\log_a{x} = y\rightarrow a^y = x"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(
                        formulaText: r"3^2 = 9 \rightarrow \log_3{9} = 2"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"e \thickapprox 2,71828"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r"\frac{du}{dx} = u^{'}"),
                    const SizedBox(height: kEspacioEntreBotones),
                    const Latex(formulaText: r""),
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
