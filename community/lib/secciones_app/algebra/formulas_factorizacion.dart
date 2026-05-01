import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class FormulasDeFactorizacion extends StatefulWidget {
  @override
  _FormulasDeFactorizacionState createState() =>
      _FormulasDeFactorizacionState();
}

class _FormulasDeFactorizacionState extends State<FormulasDeFactorizacion> {
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
                    AppLocalizations.of(context)!.formulasFactorizacion,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .formulasFactorizacion,
                            widgetName: kWidgetFormulasDeFactorizacion),
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
                                        .formulasFactorizacion,
                                    widgetName: kWidgetFormulasDeFactorizacion),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .formulasFactorizacion,
                                    widgetName: kWidgetFormulasDeFactorizacion),
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

                  const ZoomPersonalizado(
                    child: Column(
                      children: [
                        Latex(formulaText: r"na+nb=n(a+b)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^2+2ab+b^2=(a+b)^2"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^2+b^2=(a+b)^2-2ab =(a-b)^2+2ab"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^2-b^2=(a+b)(a-b)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"a^3+b^3=(a+b)(a^2-ab+b^2)=(a+b)^3-3ab(a+b)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"a^3-b^3=(a-b)(a^2+ab+b^2)=(a-b)^3+3ab(a-b)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(
                            formulaText:
                                r"a^3+b^3+c^3-3abc=(a+b+c)(a^2+b^2+c^2-ab-bc-ca)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"a^4+b^4=(a+b)(a-b)[(a+b)^2-2ab]"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"ax+ay+bx+by=(a+b)(x+y)"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"x^2+bx+c=x^2+(m+n)x+mn"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"m+n=b"),
                        SizedBox(height: kEspacioEntreBotones),
                        Latex(formulaText: r"mn=c"),
                        SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetFormulasDeFactorizacion,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetFormulasDeFactorizacion,
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
