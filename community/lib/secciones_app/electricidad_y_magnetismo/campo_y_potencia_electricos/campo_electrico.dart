import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class CampoElectrico extends StatefulWidget {
  @override
  State<CampoElectrico> createState() => _CampoElectricoState();
}

class _CampoElectricoState extends State<CampoElectrico> {
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
              AppLocalizations.of(context)!.campoElectrico,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.campoElectrico,
                      widgetName: kWidgetCampoElectrico),
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
                              title:
                                  AppLocalizations.of(context)!.campoElectrico,
                              widgetName: kWidgetCampoElectrico),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title:
                                  AppLocalizations.of(context)!.campoElectrico,
                              widgetName: kWidgetCampoElectrico),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.campoElectricoFuerzaElectrostatica,
            ),
            const SizedBox(height: 20.0),
            TextoEcuaciones(
              AppLocalizations.of(context)!.campoElectricoFuerzaPorUnidadCarga,
            ),
            const SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .campoElectricoOriginadoCargaPuntual,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{E} = \frac{\vec{F}_{q_0q}}{q_0} = \frac{k\frac{q_0q}{{r_{q_0q}}^2}\hat{r}_{q_0q}}{q_0} = k\frac{q}{{r_{q_0q}}^2}\hat{r}_{q_0q}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\vec{E} = k\frac{q}{r^2}\hat{r}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unidadMedidaCampoElectrico,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"[\vec{E}]_u = \left [ \frac{\text{N}}{\text{C}} \right ]"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.principioSuperposicion,
                ),
                const Latex(
                    formulaText:
                        r"\vec{E} = k \sum_{i=1}^{n} \frac{q_i}{r_i^2}\hat{r}_i"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.esquemasCampoElectrico,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.representacionCampoElectrico,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.tangenteLineasCampo,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineasCampoPerpendiculares,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineasCampoContinuas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.lineasCampoComienzanCargas,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.magnitudCampoElectrico,
                ),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetCampoElectrico,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetCampoElectrico,
            ),
          ],
        ),
      ),
    );
  }
}
