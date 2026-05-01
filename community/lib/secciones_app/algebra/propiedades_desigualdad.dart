import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';
import '../../../constantes/export_constantes.dart';

class PropiedadesDesigualdad extends StatefulWidget {
  @override
  _PropiedadesDesigualdadState createState() => _PropiedadesDesigualdadState();
}

class _PropiedadesDesigualdadState extends State<PropiedadesDesigualdad> {
  bool seleccionadoMostrar = false;
  double catetoOpuesto = 0.0, catetoAdyacente = 0.0, hipotenusa = 0.0;

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
                    AppLocalizations.of(context)!.propiedadesDesigualdades,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .propiedadesDesigualdades,
                            widgetName: kWidgetPropiedadesDesigualdad),
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
                                        .propiedadesDesigualdades,
                                    widgetName: kWidgetPropiedadesDesigualdad),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .propiedadesDesigualdades,
                                    widgetName: kWidgetPropiedadesDesigualdad),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        //Principal
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.desigualdadSumaResta,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a>b\rightarrow a+c>b+c\rightarrow a-c>b-c"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //sentido desigualdad
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .desigualdadMultiplicaDivide,
                        ),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a>b\rightarrow ac< bc \rightarrow\frac{a}{c}<\frac{b}{c}"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Exponentes
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.exponentes,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a>b\rightarrow a^c>b^c"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a^{(-c)} < b^{(-c)}"),

                        const SizedBox(
                          height: kEspacioEntreBotones,
                        ),
                        //Propiedad Transitiva
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.propiedadTransitiva,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a>b\space y \space b>c\rightarrow a>c"),

                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"a< b\space y \space b< c\rightarrow a< c"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Propiedad de la no negatividad
                        TextoEcuaciones(
                          AppLocalizations.of(context)!
                              .propiedadDeLaNoNegatividad,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"a^2\geq 0"),

                        const SizedBox(height: kEspacioEntreBotones),
                        //Propiedad del recíproco
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.propiedadDelReciproco,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"a>0 \rightarrow \frac{1}{a}>0"),

                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetPropiedadesDesigualdad,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetPropiedadesDesigualdad,
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
