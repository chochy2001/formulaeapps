import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class IdentidadesVectoriales extends StatefulWidget {
  @override
  _IdentidadesVectorialesState createState() => _IdentidadesVectorialesState();
}

class _IdentidadesVectorialesState extends State<IdentidadesVectoriales> {
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
              AppLocalizations.of(context)!.identidadesVectoriales,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.identidadesVectoriales,
                      widgetName: kWidgetIdentidadesVectoriales),
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
                                  .identidadesVectoriales,
                              widgetName: kWidgetIdentidadesVectoriales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .identidadesVectoriales,
                              widgetName: kWidgetIdentidadesVectoriales),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(
              height: 20.0,
            ),
            const ZoomPersonalizado(
              child: Column(
                children: [
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla (f+g) = \nabla f+\nabla g"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla (cf) = c\nabla f"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla (fg) = g\nabla f +f\nabla g"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\nabla \cdot (\vec{F}+\vec{G}) = \nabla \cdot \vec{F}+\nabla \cdot \vec{G}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\nabla \times (\vec{F}+\vec{G}) = \nabla \times\vec{F}+\nabla \times\vec{G}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\nabla \cdot (\vec{F}+\vec{G}) = \vec{G}\cdot (\nabla \times \vec{F})-\vec{F}\cdot(\nabla \times \vec{G})"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\nabla \cdot (f\vec{F}) = f(\nabla\cdot\vec{F})+\vec{F}\cdot(\nabla f)"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla\cdot(\nabla \times \vec{F}) = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\nabla \times (f\vec{F}) = f\nabla \times \vec{F}+\nabla f \times \vec{F}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\nabla \times (\nabla \times \vec{F}) = \nabla (\nabla\cdot \vec{F})-\nabla ^2 \vec{F}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\nabla \times (\nabla f) = 0"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\nabla ^2 (fg) = f\nabla ^2 g+g\nabla ^2 f +2\nabla f \cdot \nabla g"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetIdentidadesVectoriales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetIdentidadesVectoriales,
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
