import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class InductanciaMutua extends StatefulWidget {
  @override
  State<InductanciaMutua> createState() => _InductanciaMutuaState();
}

class _InductanciaMutuaState extends State<InductanciaMutua> {
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
              AppLocalizations.of(context)!.inductanciaMutua,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.inductanciaMutua,
                      widgetName: kWidgetInductanciaMutua),
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
                                  .inductanciaMutua,
                              widgetName: kWidgetInductanciaMutua),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .inductanciaMutua,
                              widgetName: kWidgetInductanciaMutua),
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
                  AppLocalizations.of(context)!.inductorTexto,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.inductanciaMutuaTexto,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ecuacionGeneral,
                ),
                const SizedBox(height: 10.0),
                const Latex(formulaText: r"\Phi_B = MI'"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\Phi_B = LI \pm MI'"),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenInductanciaMutua),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.inductanciasMutuas,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\Phi_{12} = \lambda_{12} = M_{12}I_2"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\Phi_{21} = \lambda_{21} = M_{21}I_1"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enElCasoDeFlujoConcatenado,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"-N_1I_1\Phi_{12} = -I_1\lambda_12 = -M_{12}I_2I_1"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"-N_2I_2\Phi_{21} = -I_2\lambda_21 = -M_{21}I_1I_2"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enProductoDeFlujoTotal,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"W=-\vec{p}_m\cdot\vec{B} = -I\vec{A}\cdot \vec{B} = -I\lambda"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.porConservacionDeEnergia,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\lambda_{12}I_1 = \lambda_{21}I_2"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"M_{12} = M_{21}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"M = \frac{\lambda_{12}}{I_2} = \frac{\lambda_{21}}{I_1}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.inductanciaPropiaYMutua,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"M^2 \leq \frac{\lambda_1}{I_1}\cdot\frac{\lambda_2}{I_2}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.disminucionDeFlujoConDistancia,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"M = k \sqrt{L_1L_2}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.constanteDeAcoplamiento,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"0 \leq k \leq 1"),
                const SizedBox(height: 20.0),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetInductanciaMutua,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetInductanciaMutua,
            ),
          ],
        ),
      ),
    );
  }
}
