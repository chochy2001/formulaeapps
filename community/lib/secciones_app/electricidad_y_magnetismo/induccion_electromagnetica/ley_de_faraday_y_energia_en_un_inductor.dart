import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LeyDeInduccionDeFaradayEnergiaEnUnInductor extends StatefulWidget {
  @override
  State<LeyDeInduccionDeFaradayEnergiaEnUnInductor> createState() =>
      _LeyDeInduccionDeFaradayEnergiaEnUnInductorState();
}

class _LeyDeInduccionDeFaradayEnergiaEnUnInductorState
    extends State<LeyDeInduccionDeFaradayEnergiaEnUnInductor> {
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
              AppLocalizations.of(context)!
                  .leyDeInduccionDeFaradayYEnergisEnUnInductor,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .leyDeInduccionDeFaradayYEnergisEnUnInductor,
                      widgetName: kWidgetLeyDeFaradayYEnergiaEnUnInductor),
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
                                  .leyDeInduccionDeFaradayYEnergisEnUnInductor,
                              widgetName:
                                  kWidgetLeyDeFaradayYEnergiaEnUnInductor),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyDeInduccionDeFaradayYEnergisEnUnInductor,
                              widgetName:
                                  kWidgetLeyDeFaradayYEnergiaEnUnInductor),
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
                    AppLocalizations.of(context)!.unInductorAlmacena,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.deAcuerdoConLaLeyDeInduccion,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText: r"\varepsilon_i = -\frac{d}{dt}\lambda"),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"\varepsilon_i = -L\frac{d}{dt}I"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laCorrienteAsociadaALaFEM,
                  ),
                  const SizedBox(height: 20.0),
                  const Latex(formulaText: r"_BW_A = qV_{AB}"),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"dw = \varepsilon_i dq"),
                  const SizedBox(height: 10.0),
                  const Latex(
                      formulaText:
                          r"=L\frac{dl}{dt}dq=L\frac{dq}{dt}dI = LIdI"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"U = W = \frac{1}{2}LI^2 = \frac{1}{2}LI^2\frac{1}{2}\lambda I"),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"[U]_u = [J]"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyDeFaradayYEnergiaEnUnInductor,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyDeFaradayYEnergiaEnUnInductor,
            ),
          ],
        ),
      ),
    );
  }
}
