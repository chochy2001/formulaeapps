import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LimiteDerivadaIntegralFuncionesVectoriales extends StatefulWidget {
  @override
  _LimiteDerivadaIntegralFuncionesVectorialesState createState() =>
      _LimiteDerivadaIntegralFuncionesVectorialesState();
}

class _LimiteDerivadaIntegralFuncionesVectorialesState
    extends State<LimiteDerivadaIntegralFuncionesVectoriales> {
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
              AppLocalizations.of(context)!
                  .limitesDerivadasIntegralesFuncionesVectoriales,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .limitesDerivadasIntegralesFuncionesVectoriales,
                      widgetName:
                          kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
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
                                  .limitesDerivadasIntegralesFuncionesVectoriales,
                              widgetName:
                                  kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .limitesDerivadasIntegralesFuncionesVectoriales,
                              widgetName:
                                  kWidgetLimiteDerivadaIntegralFuncionesVectoriales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 40.0,
            ),
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.sea,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText: r"\vec{R}(t) = f(t)\hat{i} +g(t) \hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unaFuncionVectorial,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.limite,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\lim_{t \to t_1}\vec{R}(t) = \left[\lim_{t \to t_1} f(t)\right]\hat{i}+\left[\lim_{t \to t_1} g(t)\right]\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.derivada,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\vec{R}'(t) = \lim_{t \to 0}\frac{\vec{R}(t+\Delta t)-\vec{R}(t)}{\Delta t}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText: r"\vec{R}'(t) = f'(t)\hat{i}+g'(t)\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.integral,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\int_a^b \vec{R}(t)dt = \left[\int_a^b f(t)dt\right]\hat{i}+\left[\int_a^b g(t)dt\right]\hat{j}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLimiteDerivadaIntegralFuncionesVectoriales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLimiteDerivadaIntegralFuncionesVectoriales,
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
