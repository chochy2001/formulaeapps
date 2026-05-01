import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class EcuacionDiferencialDeRectasNoParalelas extends StatefulWidget {
  @override
  _EcuacionDiferencialDeRectasNoParalelasState createState() =>
      _EcuacionDiferencialDeRectasNoParalelasState();
}

class _EcuacionDiferencialDeRectasNoParalelasState
    extends State<EcuacionDiferencialDeRectasNoParalelas> {
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
                        .ecuacionDiferencialRectasNoParalelas,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .ecuacionDiferencialRectasNoParalelas,
                            widgetName:
                                kWidgetEcuacionDiferencialDeRectasNoParalelas),
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
                                        .ecuacionDiferencialRectasNoParalelas,
                                    widgetName:
                                        kWidgetEcuacionDiferencialDeRectasNoParalelas),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .ecuacionDiferencialRectasNoParalelas,
                                    widgetName:
                                        kWidgetEcuacionDiferencialDeRectasNoParalelas),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.puedenTenerLaForma,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(ax+by+c)dx+(fx+gy+h)dy=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"(ax^2+by^2+c)xdx+(fx^2+gy^2+h)ydy=0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.seSustituyePor,
                        ),
                        const SizedBox(height: 6),
                        const Latex(formulaText: r"x=x'+h"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"y=y'+k"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"dx=dx'"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"dy=dy'"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .tomamosDeCadaCoeficienteLosTerminosDeH,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.kYLaConstante,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.losIgualamosACero,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .posteriormenteSeResuelvePorHomogeneasYAlFinalSeRegresaASusValoresOriginales,
                        ),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .alResolverPorHomogeneasSeSustituyenLasVariablesPor,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"v = \frac{y'}{x'} \rightarrow y' = vx' \rightarrow dy' = vdx' + x'dv"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"v = \frac{x'}{y'} \rightarrow x' = vy' \rightarrow dx' = vdy' + y'dv"),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetEcuacionDiferencialDeRectasNoParalelas,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetEcuacionDiferencialDeRectasNoParalelas,
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
                        const Latex(formulaText: r"D"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .operadorQueSignificaDerivada,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .ordenDeLaEcuacionSusRaicesSeran,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"r_1,r_2,\cdots ,r_n"),
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
