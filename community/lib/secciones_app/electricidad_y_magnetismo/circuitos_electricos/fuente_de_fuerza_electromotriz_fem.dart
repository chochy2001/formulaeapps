import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class FuenteDeFuerzaElectromotrizFem extends StatefulWidget {
  @override
  State<FuenteDeFuerzaElectromotrizFem> createState() =>
      _FuenteDeFuerzaElectromotrizFemState();
}

class _FuenteDeFuerzaElectromotrizFemState
    extends State<FuenteDeFuerzaElectromotrizFem> {
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
              AppLocalizations.of(context)!.fuenteFuerzaElectromotriz,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .fuenteFuerzaElectromotriz,
                      widgetName: kWidgetFuenteDeFuerzaElectromotriz),
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
                                  .fuenteFuerzaElectromotriz,
                              widgetName: kWidgetFuenteDeFuerzaElectromotriz),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .fuenteFuerzaElectromotriz,
                              widgetName: kWidgetFuenteDeFuerzaElectromotriz),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.dispositivoTransformador,
                ),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .dispositivosDiferenciaDePotencial,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenFuenteDeFuerzaElectromotriz) ??
                        kUrlImagenFuenteDeFuerzaElectromotriz),
                const Latex(formulaText: r"\varepsilon \equiv V"),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.fuentesFEM,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context, kImagenFemIdealYReal) ??
                        kUrlImagenFemIdealYReal),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.femAspectosRelevantes,
                ),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.teoriaDeCircuitos,
                ),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenFemAspectosRelevantes) ??
                        kUrlImagenFemAspectosRelevantes),
                const Latex(formulaText: r"P = R_{T}i^2 = V _Ti"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"P = (r+R)i^2 = \epsilon i"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i = \frac{\epsilon}{r+R}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.femIdeal,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"i = \frac{\epsilon}{R} = \frac{V}{R}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetFuenteDeFuerzaElectromotriz,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetFuenteDeFuerzaElectromotriz,
            ),
          ],
        ),
      ),
    );
  }
}
