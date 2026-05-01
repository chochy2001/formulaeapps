import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class CampoElectricoOriginadoPorDistribucionesDeCarga extends StatefulWidget {
  @override
  State<CampoElectricoOriginadoPorDistribucionesDeCarga> createState() =>
      _CampoElectricoOriginadoPorDistribucionesDeCargaState();
}

class _CampoElectricoOriginadoPorDistribucionesDeCargaState
    extends State<CampoElectricoOriginadoPorDistribucionesDeCarga> {
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
              AppLocalizations.of(context)!.campoElectricoDistribucionesCarga,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .campoElectricoDistribucionesCarga,
                      widgetName:
                          kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga),
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
                                  .campoElectricoDistribucionesCarga,
                              widgetName:
                                  kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .campoElectricoDistribucionesCarga,
                              widgetName:
                                  kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: [
                TextoEcuaciones(
                  AppLocalizations.of(context)!.cargaPuntual,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\vec{E} = k \frac{q}{r^2}\hat{r}"),
                const ZoomImagePersonalizado(urlImagen: kUrlImagenCargaPuntual),
                const SizedBox(height: 90.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .distribucionDiscretaCargasPuntuales,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{E} = \sum_{i=1}^{n} k \frac{q_i}{r^2}\hat{r}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenDistribucionDiscretaDeCargasPuntuales),
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineaInfinita,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\vec{E} = \frac{2 k \lambda}{r}\hat{r}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenLineaInfinita),
                const SizedBox(height: 90.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.discoCargaUniforme,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{E} = \frac{\sigma}{2 \epsilon _0} \left( 1 - \frac{z}{\sqrt{z^2 + R^2}} \right) \hat{r}"),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenDiscoConCargaUniforme),
                const SizedBox(height: 90.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.superficieInfinita,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{E} = \frac{\sigma}{ 2 \epsilon _0} \hat{r}"),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenSuperficieInfinita),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.segmentoLinea,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{E} = k \frac{\lambda L}{y \sqrt{y^2 + \frac{L^2}{4}}}\hat{j}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenSegmentoDeLinea),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetCampoElectricoOriginadoPorDistribucionesDeCarga,
            ),
          ],
        ),
      ),
    );
  }
}
