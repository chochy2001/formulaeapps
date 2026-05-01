import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LeyDeGauss extends StatefulWidget {
  @override
  State<LeyDeGauss> createState() => _LeyDeGaussState();
}

class _LeyDeGaussState extends State<LeyDeGauss> {
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
              AppLocalizations.of(context)!.leyGauss,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.leyGauss,
                      widgetName: kWidgetLeyDeGauss),
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
                              title: AppLocalizations.of(context)!.leyGauss,
                              widgetName: kWidgetLeyDeGauss),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.leyGauss,
                              widgetName: kWidgetLeyDeGauss),
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
                  AppLocalizations.of(context)!
                      .flujoCampoElectricoSuperficieGaussiana,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\phi _E = \oiint \vec{E} \cdot d\vec{A}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.superficieGaussiana,
                ),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenSuperficieGaussiana),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyGauss,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\epsilon _0 \phi _E = q_{enc}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\oiint \vec{E} \cdot d\vec{A} = \frac{q_{enc}}{\epsilon _0}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeGaussProporcional,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.notasImportantes,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.flujoCampoElectricoCero,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .flujoCampoElectricoPositivoNegativo,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .distribucionCargasSuperficieGaussiana,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unidadMedidaFlujoElectricoSI,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"[\phi_E]_u = \left[ \frac{N\cdot m^2}{C}\right]"),
                const SizedBox(height: 50.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.aplicacionesLeyGauss,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.campoElectricoCargaPuntual,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"E = \frac{q}{4 \pi \varepsilon _0 r^2} = k \frac{q}{r^2}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCampoElectricoDeUnaCargaPuntual),
                const SizedBox(height: 50.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .campoElectricoLineaInfinitaCarga,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"E = \frac{q}{2 \pi \varepsilon _0 h r} = \frac{\lambda}{2 \pi \varepsilon _0 r} = \frac{2k\lambda}{r}"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCampoElectricoDeUnaLineaInfinita),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyDeGauss,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyDeGauss,
            ),
          ],
        ),
      ),
    );
  }
}
