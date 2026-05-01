import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class CalculoDeDiferenciasDePotencial extends StatefulWidget {
  @override
  State<CalculoDeDiferenciasDePotencial> createState() =>
      _CalculoDeDiferenciasDePotencialState();
}

class _CalculoDeDiferenciasDePotencialState
    extends State<CalculoDeDiferenciasDePotencial> {
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
              AppLocalizations.of(context)!.calculoDiferenciasPotencial,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .calculoDiferenciasPotencial,
                      widgetName: kWidgetCalculoDeDiferenciasDePotencial),
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
                                  .calculoDiferenciasPotencial,
                              widgetName:
                                  kWidgetCalculoDeDiferenciasDePotencial),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .calculoDiferenciasPotencial,
                              widgetName:
                                  kWidgetCalculoDeDiferenciasDePotencial),
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
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                      formulaText:
                          r"V_{AB} = - \int_{B}^{A} \vec{E} \cdot d\vec{l}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cargaPuntual,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.campoElectrico,
                  ),
                  const Latex(
                      formulaText: r"\vec{E} = k \frac{q}{r^2} \hat{r}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                      formulaText:
                          r"V_{AB} = - \int_{rB}^{rA} k \frac{q}{r^2} \hat{r} \cdot d\vec{r}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"V_{AB} = kq\left( \frac{1}{r_A} - \frac{1}{r_B}\right)"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.lineaInfinita,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.campoElectrico,
                  ),
                  const Latex(
                      formulaText: r"\vec{E} =  \frac{2k\lambda}{r} \hat{r}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                      formulaText:
                          r"V_{AB} = - \int_{rB}^{rA} \frac{2k\lambda}{r} \hat{r} \cdot d\vec{r}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"V_{AB} = 2k\lambda \ln\left( \frac{r_B}{r_A} \right)"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.superficieInfinita,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.campoElectrico,
                  ),
                  const Latex(
                      formulaText:
                          r"\vec{E} =  \frac{\sigma}{2 \varepsilon _0 } \hat{r}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                      formulaText:
                          r"V_{AB} = - \int_{rB}^{rA} \frac{\sigma}{2\varepsilon _0} \hat{r} \cdot d\vec{r}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"V_{AB} = \frac{\sigma}{2\varepsilon _0} \left( r_B - r_A \right)"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.placasConductoras,
                  ),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.campoElectrico,
                  ),
                  const Latex(
                      formulaText:
                          r"\vec{E} =  -\frac{\sigma}{\varepsilon _0 } \hat{r}"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.diferenciaDePotencial,
                  ),
                  const Latex(
                      formulaText:
                          r"V_{AB} = - \int_{rB}^{rA} \frac{\sigma}{\varepsilon _0} \hat{r} \cdot d\vec{r}"),
                  const SizedBox(height: 20.0),
                  const Latex(
                      formulaText:
                          r"V_{AB} = \frac{\sigma}{\varepsilon _0} \left( r_A - r_B \right)"),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetCalculoDeDiferenciasDePotencial,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetCalculoDeDiferenciasDePotencial,
            ),
          ],
        ),
      ),
    );
  }
}
