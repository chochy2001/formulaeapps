import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class IntegralEnCoordenadasCilindricas extends StatefulWidget {
  @override
  _IntegralEnCoordenadasCilindricasState createState() =>
      _IntegralEnCoordenadasCilindricasState();
}

class _IntegralEnCoordenadasCilindricasState
    extends State<IntegralEnCoordenadasCilindricas> {
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
        child: ListView(
          children: [
            TituloPersonalizado(
              AppLocalizations.of(context)!.integralCoordenadasCilindricas,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .integralCoordenadasCilindricas,
                      widgetName: kWidgetIntegralEnCoordenasCilindricas),
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
                                  .integralCoordenadasCilindricas,
                              widgetName:
                                  kWidgetIntegralEnCoordenasCilindricas),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .integralCoordenadasCilindricas,
                              widgetName:
                                  kWidgetIntegralEnCoordenasCilindricas),
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
            ZoomPersonalizado(
              child: Column(
                children: [
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .coordenadasCartesianaACilindricas,
                  ),
                  const Latex(
                      formulaText:
                          r"\int_{D_{xyz}}\iint F(x,y,z)dx\thinspace dy\thinspace dz=\int_0^r\int_0^{2\pi}\int_0^z G(r,\phi,z)r\thinspace dr\thinspace d\phi\thinspace dz"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .coordenadasCartesianaAEsfericas,
                  ),
                  const Latex(
                      formulaText:
                          r"\int_{D_{xyz}}\iint F(x,y,z)dx\thinspace dy\thinspace dz=\int_0^r\int_{\frac{-\pi}{2}}^{\frac{\pi}{2}}\int_0^{2\pi} G(r,\theta,\phi)r^2\thinspace \sin\theta\space dr d\theta d\phi"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetIntegralEnCoordenasCilindricas,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetIntegralEnCoordenasCilindricas,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
