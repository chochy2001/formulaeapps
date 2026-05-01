import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class VectorDeDesplazamientoElectrico extends StatefulWidget {
  @override
  State<VectorDeDesplazamientoElectrico> createState() =>
      _VectorDeDesplazamientoElectricoState();
}

class _VectorDeDesplazamientoElectricoState
    extends State<VectorDeDesplazamientoElectrico> {
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
              AppLocalizations.of(context)!.vectorDesplazamientoElectrico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .vectorDesplazamientoElectrico,
                      widgetName: kWidgetVectorDeDesplazamientoElectrico),
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
                                  .vectorDesplazamientoElectrico,
                              widgetName:
                                  kWidgetVectorDeDesplazamientoElectrico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .vectorDesplazamientoElectrico,
                              widgetName:
                                  kWidgetVectorDeDesplazamientoElectrico),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.paraMaterialesLineales,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\vec{D} = \varepsilon \vec{E}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"\vec{D} = \varepsilon \vec{E} = k_e \varepsilon_0 \vec{E}= (1+ \chi_e) \varepsilon_0 \vec{E} + \varepsilon_0 \chi_e \vec{E}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\vec{D} = \varepsilon_0 \vec{E} +\vec{P}"),
                  const SizedBox(height: 40.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeGaussGeneralizada,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\oiint \vec{E}\cdot d\vec{A} = \frac{q_{enc}}{\varepsilon_0}"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\left| \vec{E} \right|= \frac{q_l}{\varepsilon A}"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\left| \vec{E} \right|= \frac{\sigma_l}{\varepsilon}"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText: r"\oiint \vec{D}\cdot d\vec{A} = q_l"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\oiint \vec{D}\cdot d\vec{A} = DA = \varepsilon EA"),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"\left| \vec{D} \right|= \sigma_l"),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetVectorDeDesplazamientoElectrico,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetVectorDeDesplazamientoElectrico,
            ),
          ],
        ),
      ),
    );
  }
}
