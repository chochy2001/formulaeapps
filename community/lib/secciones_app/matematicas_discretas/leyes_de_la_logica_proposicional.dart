import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class LeyesDeLaLogicaProposicional extends StatefulWidget {
  @override
  _LeyesDeLaLogicaProposicionalState createState() =>
      _LeyesDeLaLogicaProposicionalState();
}

class _LeyesDeLaLogicaProposicionalState
    extends State<LeyesDeLaLogicaProposicional> {
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
                    AppLocalizations.of(context)!.leyesDeLaLogicaProposicional,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                            title: AppLocalizations.of(context)!
                                .leyesDeLaLogicaProposicional,
                            widgetName: kWidgetLeyesDeLaLogicaProposicional),
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
                                        .leyesDeLaLogicaProposicional,
                                    widgetName:
                                        kWidgetLeyesDeLaLogicaProposicional),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                    title: AppLocalizations.of(context)!
                                        .leyesDeLaLogicaProposicional,
                                    widgetName:
                                        kWidgetLeyesDeLaLogicaProposicional),
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
                      const Latex(formulaText: r"v"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.esTautologia,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"f"),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.esContradiccion,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.dobleNegacion,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText: r"\overline{\overline{p}}\equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.deMorgan,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"\overline{p\lor q}\equiv \overline{p}\land \overline{q}"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"\overline{p\land q}\equiv \overline{p}\lor \overline{q}"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.conmutativa,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\lor q \equiv q\lor p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land q \equiv q\land p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.asociativa,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"(p\lor q)\lor r \equiv p\lor (q\lor r)"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"(p\land q)\lor r \equiv p\land (q\land r)"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.distributiva,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"p\land(q\lor r)\equiv (p\land q)\lor(p\land r)"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText:
                              r"p\lor(q\land r)\equiv (p\lor q)\land (p\lor r)"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.idempotencia,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\lor p \equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land p \equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.neutros,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\lor f \equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land v \equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.dominacion,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land f \equiv f"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\lor v \equiv v"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.inversos,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p \lor \overline{p} \equiv v"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(
                          formulaText: r"p \land \overline{p} \equiv f"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const SizedBox(height: kEspacioEntreBotones),
                      TextoEcuaciones(
                        AppLocalizations.of(context)!.absorcion,
                      ),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p \lor (p\land q)\equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                      const Latex(formulaText: r"p\land (p\lor q)\equiv p"),
                      const SizedBox(height: kEspacioEntreBotones),
                    ],
                  )),

                  //Boton para acceder al formulario en PDF
                  const VerPDF(
                    url: kWidgetLeyesDeLaLogicaProposicional,
                  ),
                  //Descargar PDF
                  const DescargarPDF(
                    url: kWidgetLeyesDeLaLogicaProposicional,
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
                        const Latex(
                            formulaText:
                                r"(\equiv) = (\leftrightarrow) = (\Leftrightarrow)"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.siysolosi,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(\land) = (\&)"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.conjuncionLogica,
                        ),
                        const SizedBox(height: kEspacioEntreBotones),
                        const Latex(formulaText: r"(\lor)"),
                        TextoEcuaciones(
                          AppLocalizations.of(context)!.disyuncionLogica,
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
