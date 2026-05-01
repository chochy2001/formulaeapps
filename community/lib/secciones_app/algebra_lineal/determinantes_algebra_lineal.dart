import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class DeterminantesAlgebraLineal extends StatefulWidget {
  @override
  _DeterminantesAlgebraLinealState createState() =>
      _DeterminantesAlgebraLinealState();
}

class _DeterminantesAlgebraLinealState
    extends State<DeterminantesAlgebraLineal> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.determinantes,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.determinantes,
                            widgetName: kWidgetDeterminantesAlgebraLineal),
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
                                        .determinantes,
                                    widgetName:
                                        kWidgetDeterminantesAlgebraLineal),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .determinantes,
                                    widgetName:
                                        kWidgetDeterminantesAlgebraLineal),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A=\begin{pmatrix}a & b \\c & d \\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\det A = ad-bc"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.porCofactores,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.si,
                        ),
                        const Latex(
                            formulaText:
                                r"\mathsf{Sea}\space B=\begin{pmatrix}a & b & c\\d & e & f\\g & h & i\\\end{pmatrix}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\det B=(-1)^{1+1}a\begin{pmatrix}e & f\\h & i\\\end{pmatrix}+ (-1)^{1+2}b \begin{pmatrix}d & f\\g & i\\\end{pmatrix}+ (-1)^{1+3}c\begin{pmatrix}d & e\\g & h\\\end{pmatrix}= a(ei-fh)-b(di-fg)+c(dh-eg)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.definicionCofactor,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"C_{ij}=(-1)^{i+j}\cdot \det(M_{ij})"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"M_{ij}"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.submatriz,
                        ),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetDeterminantesAlgebraLineal,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetDeterminantesAlgebraLineal,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorBotones,
                      border: Border.all(
                        color: kColorFondo,
                        width: 8,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Notas(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Latex(formulaText: r"i,j"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.posicion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\det (M_{ij})"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.menorDeA,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
