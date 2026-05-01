import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LeyDeCoulomb extends StatefulWidget {
  @override
  State<LeyDeCoulomb> createState() => _LeyDeCoulombState();
}

class _LeyDeCoulombState extends State<LeyDeCoulomb> {
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
              AppLocalizations.of(context)!.leyCoulomb,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.leyCoulomb,
                      widgetName: kWidgetLeyDeCoulomb),
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
                              title: AppLocalizations.of(context)!.leyCoulomb,
                              widgetName: kWidgetLeyDeCoulomb),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.leyCoulomb,
                              widgetName: kWidgetLeyDeCoulomb),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.leyCoulombTexto,
            ),

            const SizedBox(height: 30.0),
            const ZoomImagePersonalizado(urlImagen: kUrlImagenCargasPuntuales),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unidadFuerza,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"[\vec{F}]_u = [N]"),
                const SizedBox(height: 40.0),
                const Latex(
                    formulaText:
                        r"\vec{F}_{12} = k \frac{q_1 q_2}{{r_{12}}^2}\hat{r}_{12}"),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.constanteCoulomb,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"k = \frac{1}{4\pi\epsilon_0} = 8.99 \times 10^9 \left[\frac{N \cdot m^2}{C^2}\right]"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.permitividadVacio,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\epsilon_0 = 8.854 \times 10^{-12} \left[\frac{C^2}{N\cdot m^2}\right]"),
                const SizedBox(height: 40.0),
              ],
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyDeCoulomb,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyDeCoulomb,
            ),
          ],
        ),
      ),
    );
  }
}
