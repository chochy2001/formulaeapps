import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class InteresCompuesto extends StatefulWidget {
  @override
  _InteresCompuestoState createState() => _InteresCompuestoState();
}

class _InteresCompuestoState extends State<InteresCompuesto> {
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
                    AppLocalizations.of(context)!.interesCompuesto,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title:
                                AppLocalizations.of(context)!.interesCompuesto,
                            widgetName: kWidgetInteresCompuesto),
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
                                        .interesCompuesto,
                                    widgetName: kWidgetInteresCompuesto),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .interesCompuesto,
                                    widgetName: kWidgetInteresCompuesto),
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
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.interesCompuesto,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"M=C\left(1+\frac{i}{p}\right)^{np}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetInteresCompuesto,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetInteresCompuesto,
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .frecuenciaCapitalizacionDefinicion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"M"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.montoAcumulado,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"i"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.tasaInteresAnual,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"n"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.periodoAnos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"p"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .frecuenciaCapitalizacion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"C"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.capital,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const CapdesisLatex(),
                        const SizedBox(height: kEspacioEntreBotones),
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
