import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class SegmentoConductorRecto extends StatefulWidget {
  @override
  State<SegmentoConductorRecto> createState() => _SegmentoConductorRectoState();
}

class _SegmentoConductorRectoState extends State<SegmentoConductorRecto> {
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
              AppLocalizations.of(context)!.segmentoConductorRecto,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.segmentoConductorRecto,
                      widgetName: kWidgetSegmentoConductoRecto),
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
                                  .segmentoConductorRecto,
                              widgetName: kWidgetSegmentoConductoRecto),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .segmentoConductorRecto,
                              widgetName: kWidgetSegmentoConductoRecto),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenSegmentoDeConductorRecto),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeBiotSavart,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"d\vec{B}= \frac{\mu_0}{4\pi}\frac{id\vec{l}\times \bar{r}}{r^3}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .magnitudDelCampoMagneticoMitadConductor,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = \frac{\mu_0}{4\pi}i \int_{\frac{-L}{2}}^{\frac{L}{2}} \frac{dl\sin{\alpha}}{r^2}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = \frac{\mu_0}{4\pi}i \int_{\frac{-L}{2}}^{\frac{L}{2}} \frac{y dx}{(x^2+y^2)^{\frac{3}{2}}}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"B = \frac{\mu_0 i}{4\pi y} \frac{L}{(\frac{L^2}{4}+y^2)^{\frac{1}{2}}}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conductorMuyLargo,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\vec{B} = \frac{\mu_0 i}{2\pi r}\hat{r}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetSegmentoConductoRecto,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetSegmentoConductoRecto,
            ),
          ],
        ),
      ),
    );
  }
}
