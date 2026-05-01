import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class IdentidadesHiperbolicasGenerales extends StatefulWidget {
  @override
  _IdentidadesHiperbolicasGeneralesState createState() =>
      _IdentidadesHiperbolicasGeneralesState();
}

class _IdentidadesHiperbolicasGeneralesState
    extends State<IdentidadesHiperbolicasGenerales> {
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
              AppLocalizations.of(context)!.identidadesHiperbolicas,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.identidadesHiperbolicas,
                      widgetName: kWidgetIdentidadesHiperbolicasGenerales),
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
                                  .identidadesHiperbolicas,
                              widgetName:
                                  kWidgetIdentidadesHiperbolicasGenerales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .identidadesHiperbolicas,
                              widgetName:
                                  kWidgetIdentidadesHiperbolicasGenerales),
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
                  Latex(
                      formulaText: r"\cosh\thinspace(-x) = \cosh\thinspace x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"1- \tanh{^2}\thinspace = sech{^2}\thinspace x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\tanh(-x) = -\tanh\thinspace  x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(formulaText: r"\sinh (-x) = -\sinh\thinspace x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\cosh\thinspace x - \sinh\thinspace x = e^{-x}"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\cosh^2 \thinspace x \thinspace -\thinspace \sinh^2\thinspace x = 1"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\sinh (2x) = 2\sinh\thinspace x \cdot \cosh\thinspace x"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\sinh (x \pm y) = \sinh\thinspace x \cdot \cosh\thinspace y \pm \cosh\thinspace x \cdot \sinh \thinspace y"),
                  SizedBox(height: kEspacioEntreBotones),
                  Latex(
                      formulaText:
                          r"\cosh (x \pm y) = \cosh\thinspace x \cdot \cosh\thinspace y \pm \sinh\thinspace x \cdot \sinh \thinspace y"),
                  SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            const SizedBox(
              height: kEspacioEntreBotones,
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetIdentidadesHiperbolicasGenerales,
            ),

            //Descargar PDF
            const DescargarPDF(
              url: kWidgetIdentidadesHiperbolicasGenerales,
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
                  const Latex(formulaText: r"\sinh "),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.senoHiperbolico,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\cosh"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cosenoHiperbolico,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\tanh"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.tangenteHiperbolica,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"sech"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.secanteHiperbolica,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"csch"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cosecanteHiperbolica,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"\coth "),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cotangenteHiperbolica,
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
    );
  }
}
