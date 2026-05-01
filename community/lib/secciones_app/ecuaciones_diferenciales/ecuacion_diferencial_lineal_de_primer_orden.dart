import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class EcuacionDiferencialLinealDePrimerOrden extends StatefulWidget {
  @override
  _EcuacionDiferencialLinealDePrimerOrdenState createState() =>
      _EcuacionDiferencialLinealDePrimerOrdenState();
}

class _EcuacionDiferencialLinealDePrimerOrdenState
    extends State<EcuacionDiferencialLinealDePrimerOrden> {
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
                    AppLocalizations.of(context)!
                        .ecuacionDiferencialLinealPrimerOrden,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .ecuacionDiferencialLinealPrimerOrden,
                            widgetName:
                                kWidgetEcuacionDiferencialLinealDePrimerOrden),
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
                                        .ecuacionDiferencialLinealPrimerOrden,
                                    widgetName:
                                        kWidgetEcuacionDiferencialLinealDePrimerOrden),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .ecuacionDiferencialLinealPrimerOrden,
                                    widgetName:
                                        kWidgetEcuacionDiferencialLinealDePrimerOrden),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\frac{dy}{dx}+\mathrm{P}(x)y = \mathrm{Q}(x)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"y = e^{-\int \mathrm{P}(x)dx}\left[\int e^{\int \mathrm{P}(x)dx}\mathrm{Q}(x)dx + \mathrm{C}\right]"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .ecuacionDiferencialReducibleALineal,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"\frac{dy}{dx}+\mathrm{P}(x)y = \mathrm{Q}(x)y^n"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .ecuacionDiferencialReducidaALineal,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"\frac{dz}{dx}+\mathrm{P_1}(x)z = \mathrm{Q_1}(x)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.donde,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"\mathrm{P_1}(x) = (1-n)\mathrm{P}(x)"),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"\mathrm{Q_1}(x) = (1-n)\mathrm{Q}(x)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.solucionGeneral,
                        ),
                        const SizedBox(height: 5),
                        const Latex(
                            formulaText:
                                r"z=e^{\int \mathrm{P_1}(x)dx}\left[\int e^{\int \mathrm{P_1}(x)dx}\mathrm{Q_1}(x)dx+\mathrm{C}\right]"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .seRegresanLosValoresOriginalesAZ,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialLinealDePrimerOrden,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialLinealDePrimerOrden,
                  ),
                  //Notas
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
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"P, Q "),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .funcionesDeXSePonenConSuRespectivoSigno,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.seHaceLaSustitucionDe,
                        ),
                        const SizedBox(height: 5),
                        const Latex(formulaText: r"z = y^{1-n}"),
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
