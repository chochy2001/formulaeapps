import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class EcuacionDiferencialLinealDeOrdenSuperior extends StatefulWidget {
  @override
  _EcuacionDiferencialLinealDeOrdenSuperiorState createState() =>
      _EcuacionDiferencialLinealDeOrdenSuperiorState();
}

class _EcuacionDiferencialLinealDeOrdenSuperiorState
    extends State<EcuacionDiferencialLinealDeOrdenSuperior> {
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
                        .ecuacionDiferencialLinealOrdenSuperior,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .ecuacionDiferencialLinealOrdenSuperior,
                            widgetName:
                                kWidgetEcuacionDiferencialLinealDeOrdenSuperior),
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
                                        .ecuacionDiferencialLinealOrdenSuperior,
                                    widgetName:
                                        kWidgetEcuacionDiferencialLinealDeOrdenSuperior),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .ecuacionDiferencialLinealOrdenSuperior,
                                    widgetName:
                                        kWidgetEcuacionDiferencialLinealDeOrdenSuperior),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a_n(x)y^n+a_{n-1}(x)y^{n-1}+\cdots+a_0(x)y= g(x)"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.variacionDeParametros,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionHomogenea,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(
                            formulaText:
                                r"a_ny^n+a_{n-1}(x)y^{n-1}+\cdots + a_0(x)y = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"y_h = c_1u_1+c_2u_2 + \cdots + c_nu_n = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionParticular,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(
                            formulaText:
                                r"y_p = u_1v_1 + u_2v_2 + \cdots + u_nv_n"),
                        const SizedBox(height: 5),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .seResuelveElSistemaDeEcuaciones,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: kEspacioEntreBotones - 15),
                        const Latex(formulaText: r"y_g = y_h+y_p"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialLinealDeOrdenSuperior,
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
