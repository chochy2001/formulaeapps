import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LeyDeAmpereEnFormaDiferencial extends StatefulWidget {
  @override
  State<LeyDeAmpereEnFormaDiferencial> createState() =>
      _LeyDeAmpereEnFormaDiferencialState();
}

class _LeyDeAmpereEnFormaDiferencialState
    extends State<LeyDeAmpereEnFormaDiferencial> {
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
              AppLocalizations.of(context)!.leyDeAmpereEnFormaDiferencial,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .leyDeAmpereEnFormaDiferencial,
                      widgetName: kWidgetLeyDeAmpereEnFormaDiferencial),
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
                                  .leyDeAmpereEnFormaDiferencial,
                              widgetName: kWidgetLeyDeAmpereEnFormaDiferencial),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyDeAmpereEnFormaDiferencial,
                              widgetName: kWidgetLeyDeAmpereEnFormaDiferencial),
                        );
                      }
                    });
                  },
                );
              },
            ),

            ZoomPersonalizado(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .definicionDeCorrienteElectrica,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(formulaText: r"i= \iint \vec{J}\cdot d\vec{A}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeAmperePalabra,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText: r"\oint \vec{B}\cdot d\vec{l} = \mu _0 i"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\oint \vec{B} \cdot d \vec{l} = \mu _0 \iint \vec{J} \cdot d\vec{A}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.deAcuerdoConElTeoremaDeStokes,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\iint(\nabla \times \vec{F})\cdot d\vec{S} = \oint \vec{F}\cdot d\vec{l}"),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText:
                          r"\iint(\nabla \times \vec{B})\cdot d\vec{A} = \mu_0 \iint \vec{J}\cdot d\vec{A}"),
                  const SizedBox(height: 30.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.leyDeAmpereEnFormaDiferencial,
                  ),
                  const SizedBox(height: 30.0),
                  const Latex(
                      formulaText: r"\nabla \times \vec{B} = \mu_0 \vec{J}"),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyDeAmpereEnFormaDiferencial,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyDeAmpereEnFormaDiferencial,
            ),
          ],
        ),
      ),
    );
  }
}
