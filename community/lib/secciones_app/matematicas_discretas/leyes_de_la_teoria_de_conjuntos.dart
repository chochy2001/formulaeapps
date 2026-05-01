import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LeyesDeLaTeoriaDeConjuntos extends StatefulWidget {
  @override
  _LeyesDeLaTeoriaDeConjuntosState createState() =>
      _LeyesDeLaTeoriaDeConjuntosState();
}

class _LeyesDeLaTeoriaDeConjuntosState
    extends State<LeyesDeLaTeoriaDeConjuntos> {
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
                    AppLocalizations.of(context)!.leyesDeLaTeoriaDeConjuntos,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .leyesDeLaTeoriaDeConjuntos,
                            widgetName: kWidgetLeyesDeLaTeoriaDeConjuntos),
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
                                        .leyesDeLaTeoriaDeConjuntos,
                                    widgetName:
                                        kWidgetLeyesDeLaTeoriaDeConjuntos),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .leyesDeLaTeoriaDeConjuntos,
                                    widgetName:
                                        kWidgetLeyesDeLaTeoriaDeConjuntos),
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
                        const Latex(formulaText: r"X"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.esConjuntoY,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A,B,C"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.sonSubconjuntosDe,
                        ),
                        const Latex(formulaText: r"X"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.dobleComplemento,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"\overline{\overline{A}} = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.deMorgan,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{A\cup B}\equiv \overline{A}\cap\overline{B}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"\overline{A\cap B}\equiv \overline{A}\cup\overline{B}"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conmutativa,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cup B = B\cup A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cap B = B\cap A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.asociativa,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(A \cup B)\cup C = A\cup (B\cup C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"(A \cap B)\cap C = A\cap (B\cap C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.distributiva,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A\cap (B\cup C) = (A\cap B)\cup(A\cap C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText:
                                r"A\cup (B\cap C) = (A\cup B)\cap (A\cup C)"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.idempotencia,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cup A = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cap A = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.neutros,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cup \varnothing = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cap X = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.absorbentes,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cup X = X"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"A \cap \varnothing = \varnothing"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.inversos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cup \overline{A} = X"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(
                            formulaText: r"A\cap \overline{A} = \varnothing"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const SizedBox(height: kEspacioEntreBotones),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.absorcion,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A\cup (A\cap B) = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"A \cap (A\cup B) = A"),
                        const SizedBox(height: kEspacioEntreBotones),
                      ],
                    ),
                  ),
                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetLeyesDeLaTeoriaDeConjuntos,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetLeyesDeLaTeoriaDeConjuntos,
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
                        const Latex(formulaText: r"\cup"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.unionConjuntos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\cap"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.interseccionConjuntos,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"\varnothing "),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conjuntoVacio,
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
