import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class FlujoDeUnCampoVectorial extends StatefulWidget {
  @override
  State<FlujoDeUnCampoVectorial> createState() =>
      _FlujoDeUnCampoVectorialState();
}

class _FlujoDeUnCampoVectorialState extends State<FlujoDeUnCampoVectorial> {
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
            TituloPersonalizado(
              AppLocalizations.of(context)!.flujoElectricoCampoVectorial,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .flujoElectricoCampoVectorial,
                      widgetName: kWidgetFlujoElectricoDeUnCampoVectorial),
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
                                  .flujoElectricoCampoVectorial,
                              widgetName:
                                  kWidgetFlujoElectricoDeUnCampoVectorial),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .flujoElectricoCampoVectorial,
                              widgetName:
                                  kWidgetFlujoElectricoDeUnCampoVectorial),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            TextoEcuaciones(
              AppLocalizations.of(context)!
                  .flujoCampoVectorialSuperficieFijaImaginaria,
            ),

            const SizedBox(height: 20.0),
            const ZoomImagePersonalizado(urlImagen: kUrlImagenFlujo1),
            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.flujoCampoVectorialSuperficieAreaA,
            ),

            const SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .flujoCampoVectorialRespectoSuperficie,
                ),
                const Latex(
                    formulaText:
                        r"\phi = V A \cos \theta = \vec{V} \cdot \vec{A}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenFlujoRespectoASuperficie),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .flujoCampoVectorialRespectoSuperficiesDiscretas,
                ),
                const Latex(
                    formulaText:
                        r"\phi = \sum_{i=1}^{n} V_i A_i \cos \theta_i = \sum_{i=1}^{n} \vec{V_i} \cdot \vec{A_i}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenFlujoRespectoASuperficies),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .flujoCampoVectorialSuperficieContinua,
                ),
                const Latex(
                    formulaText: r"\phi = \iint \vec{V} \cdot d\vec{A}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenFlujoRespectoASuperficieContinua),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.flujoCampoElectricoEntenderse,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\phi _E = \iint \vec{E} \cdot d\vec{A}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.flujoCampoElectricoNumeroLineas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.integralFuncionContinua,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetFlujoElectricoDeUnCampoVectorial,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetFlujoElectricoDeUnCampoVectorial,
            ),
          ],
        ),
      ),
    );
  }
}
