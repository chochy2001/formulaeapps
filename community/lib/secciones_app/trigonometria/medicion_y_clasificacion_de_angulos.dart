import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class MedicionYClasificacionDeAngulos extends StatefulWidget {
  @override
  _MedicionYClasificacionDeAngulosState createState() =>
      _MedicionYClasificacionDeAngulosState();
}

class _MedicionYClasificacionDeAngulosState
    extends State<MedicionYClasificacionDeAngulos> {
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
                        .medicionYClasificacionDeAngulos,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .medicionYClasificacionDeAngulos,
                            widgetName: kWidgetMedicionYClasificacionDeAngulos),
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
                                        .medicionYClasificacionDeAngulos,
                                    widgetName:
                                        kWidgetMedicionYClasificacionDeAngulos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .medicionYClasificacionDeAngulos,
                                    widgetName:
                                        kWidgetMedicionYClasificacionDeAngulos),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.sistema}               ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${AppLocalizations.of(context)!.sexagesimal}    ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: AppLocalizations.of(context)!.circular,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.unidad}                 ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${AppLocalizations.of(context)!.grados}              ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: AppLocalizations.of(context)!.radian,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.circunferencia}   ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                          children: const <TextSpan>[
                            TextSpan(
                                text: '360°                   ',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'πd',
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ZoomPersonalizado(
                    child: Column(
                      children: [
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.grados,
                        ),
                        Latex(
                            formulaText: r"\frac{(180^\circ " +
                                AppLocalizations.of(context)!.radianes +
                                r")}{\pi}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.radianes,
                        ),
                        Latex(
                            formulaText: r"\frac{(\pi )" +
                                AppLocalizations.of(context)!.grados +
                                r"}{180^\circ}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!
                          .clasificacionSegunMedida,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.anguloRecto,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.anguloLlano,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.anguloAgudo,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.anguloObtuso,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!
                          .clasificacionSegunValorSuma,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!
                              .angulosComplementarios,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!
                              .angulosSuplementarios,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.angulosConjugados,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetMedicionYClasificacionDeAngulos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetMedicionYClasificacionDeAngulos,
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
