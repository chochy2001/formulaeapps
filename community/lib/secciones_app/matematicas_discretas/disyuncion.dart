import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class DisyuncionMatematicasDiscretas extends StatefulWidget {
  @override
  _DisyuncionMatematicasDiscretasState createState() =>
      _DisyuncionMatematicasDiscretasState();
}

class _DisyuncionMatematicasDiscretasState
    extends State<DisyuncionMatematicasDiscretas> {
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
                    AppLocalizations.of(context)!.disyuncion,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!.disyuncion,
                            widgetName: kWidgetDisyuncion),
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
                                        .disyuncion,
                                    widgetName: kWidgetDisyuncion),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .disyuncion,
                                    widgetName: kWidgetDisyuncion),
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
                          AppLocalizations.of(context)!.conector,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        //todo poner el conector or
                        const Latex(formulaText: r"\mathsf{o}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.simbolos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\mathsf{ p\lor q}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\mathsf{ p\space \| \space  q}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.tablaVerdad,
                        ),
                      ],
                    ),
                  ),

                  ZoomImagePersonalizado(
                      urlImagen: getImageUrlById(
                              context, kImagenTablaDeVerdadDisyuncion1) ??
                          kUrlImagenTablaDeVerdadDisyuncion1),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ZoomPersonalizado(
                      child: Column(
                    children: [
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.conector,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.oExclusivo,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.simbolo,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"\mathsf{ p\oplus q}"),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.tablaVerdad,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  )),
                  ZoomImagePersonalizado(
                      urlImagen: getImageUrlById(
                              context, kImagenTablaDeVerdadDisyuncion2) ??
                          kUrlImagenTablaDeVerdadDisyuncion2),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetDisyuncion,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetDisyuncion,
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
