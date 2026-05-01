import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class DerivadasParciales extends StatefulWidget {
  @override
  _DerivadasParcialesState createState() => _DerivadasParcialesState();
}

class _DerivadasParcialesState extends State<DerivadasParciales> {
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
              AppLocalizations.of(context)!.derivadasParciales,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.derivadasParciales,
                      widgetName: kWidgetDerivadasParciales),
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
                                  .derivadasParciales,
                              widgetName: kWidgetDerivadasParciales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .derivadasParciales,
                              widgetName: kWidgetDerivadasParciales),
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
            ZoomPersonalizado(
              child: Column(
                children: [
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.dadaFuncionFDeXYZ,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"f_x(x,y,z) = \lim_{h \to 0}\frac{f(x+h,y,z)-f(x,y,z)}{h}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"f_y(x,y,z) = \lim_{h \to 0}\frac{f(x,y+h,z)-f(x,y,z)}{h}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"f_z(x,y,z) = \lim_{h \to 0}\frac{f(x,y,z+h)-f(x,y,z)}{h}"),
                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.notacion,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"f_{x} = \frac{\partial f(x,y,z)}{\partial x}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"f_{y} = \frac{\partial f(x,y,z)}{\partial y}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"f_{z} = \frac{\partial f(x,y,z)}{\partial z}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetDerivadasParciales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetDerivadasParciales,
            ),
            const SizedBox(
              height: 20.0,
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
                    height: kEspacioEntreBotones,
                  ),
                  Center(
                    child: TextoEcuaciones(
                      AppLocalizations.of(context)!
                          .elsubindiceindicarespectodequevariablesevaaderivar,
                    ),
                  ),
                  const SizedBox(
                    height: kEspacioEntreBotones,
                  ),
                  const CapdesisLatex(),
                  const SizedBox(
                    height: kEspacioEntreBotones,
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
