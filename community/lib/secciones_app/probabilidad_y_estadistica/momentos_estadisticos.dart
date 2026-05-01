import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MomentosEstadisticos extends StatefulWidget {
  @override
  _MomentosEstadisticosState createState() => _MomentosEstadisticosState();
}

class _MomentosEstadisticosState extends State<MomentosEstadisticos> {
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
                    AppLocalizations.of(context)!.momentosEstadisticos,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .momentosEstadisticos,
                            widgetName: kWidgetMomentosEstadisticos),
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
                                        .momentosEstadisticos,
                                    widgetName: kWidgetMomentosEstadisticos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .momentosEstadisticos,
                                    widgetName: kWidgetMomentosEstadisticos),
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
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .diferenciaMarcaClaseMedia,
                        ),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"Y = MC -\bar{X}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .momentoEstadisticoPrimerGrado,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"ME_1 = \frac{\sum_{i=1}^{n}f_i\cdot Y_i}{n} = 0"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .momentoEstadisticoSegundoGrado,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"ME_2 = \frac{\sum_{i=1}^{n}f_i\cdot Y_i^2}{n} = S^2"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .momentoEstadisticoTercerGrado,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"ME_3 = \frac{\sum_{i=1}^{n}f_i\cdot Y_i^3}{n}"),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"k_3 = \frac{ME_3}{S^3}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .momentoEstadisticoCuartoGrado,
                        ),
                        const SizedBox(height: 10),
                        const Latex(
                            formulaText:
                                r"ME_4 = \frac{\sum_{i=1}^{n}f_i\cdot Y_i^4}{n} = 0"),
                        const SizedBox(height: 10),
                        const Latex(formulaText: r"k_4 = \frac{ME_4}{S^4}"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMomentosEstadisticos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMomentosEstadisticos,
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
                        ZoomPersonalizado(
                          child: Column(
                            children: [
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"MC"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.marcaClase,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"\bar{X}"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.mediaAritmetica,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"ME"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .momentoEstadistico,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"f_i"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .frecuenciaIntervaloi,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"n"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.numeroTotalDatos,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"S"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .desviacionEstandar,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"Y_i"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .diferenciaMarcaClaseMedida,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"k_3"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .coeficienteAsimetria,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_3 > 0 "),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .curvaAsimetriaDerecha,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_3 = 0 "),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .curvaDistribucionSimetrica,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_3 < 0"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .curvaAsimetriaIzquierda,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              const Latex(formulaText: r"k_4 "),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!
                                    .coeficienteApuntamiento,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_4 -3 >0"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.curvaLeptocurtica,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_4 -3 =0"),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.curvaMesocurtica,
                              ),
                              const SizedBox(height: kEspacioEntreBotones),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.si,
                              ),
                              const Latex(formulaText: r"k_4 -3 <0 "),
                              TextoEcuaciones(
                                AppLocalizations.of(context)!.curvaPlatocurtica,
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
          ],
        ),
      ),
    );
  }
}
