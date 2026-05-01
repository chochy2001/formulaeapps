import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../constantes/export_constantes.dart';

class EcuacionesDePrimerGrado extends StatefulWidget {
  @override
  _EcuacionesDePrimerGradoState createState() =>
      _EcuacionesDePrimerGradoState();
}

class _EcuacionesDePrimerGradoState extends State<EcuacionesDePrimerGrado> {
  double valorA = 0;
  double valorB = 0;
  double valorC = 0;

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TituloPersonalizado(
                    AppLocalizations.of(context)!.ecuacionesDePrimerGrado,
                  ),
                  adContainer,
                  Consumer<FavoritesNotifier>(
                    builder: (context, favoritesNotifier, child) {
                      bool isFavorite = favoritesNotifier.isFavorite(
                        Favorite(
                          title: AppLocalizations.of(context)!
                              .ecuacionesDePrimerGrado,
                          widgetName: kWidgetEcuacionesDePrimerGrado,
                        ),
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
                                      .ecuacionesDePrimerGrado,
                                  widgetName: kWidgetEcuacionesDePrimerGrado,
                                ),
                              );
                            } else {
                              favoritesNotifier.addFavorite(
                                Favorite(
                                  title: AppLocalizations.of(context)!
                                      .ecuacionesDePrimerGrado,
                                  widgetName: kWidgetEcuacionesDePrimerGrado,
                                ),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const Latex(formulaText: r"ax+ b = c"),
                  const SizedBox(height: kBordeBotones),
                  Math.tex("$valorA x+$valorB=$valorC",
                      mathStyle: MathStyle.display,
                      textStyle: kTextoLatexFormulas),
                  const SizedBox(height: 20),
                  const SizedBox(height: kBordeBotones),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "5",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'a',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            valorA = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        decoration: InputDecoration(
                          hintText: "2",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'b',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            valorB = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioInteractivo),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Colors.white,
                      inputDecorationTheme: const InputDecorationTheme(
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          interactiveHeight,
                      width:
                          MediaQuery.of(context).size.width * interactiveWidth,
                      child: TextField(
                        style: kTextoBotones,
                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        decoration: InputDecoration(
                          hintText: "10",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'c',
                        ),
                        onChanged: (valor) {
                          setState(() {
                            valorC = double.parse(valor);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: kEspacioEntreBotones + 10),
                  _solucion(valorA, valorB, valorC),
                  //Todo Agregar video explicativo de como poner la ecuación
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _solucion(valorA, valorB, valorC) {
    double valorX = (valorC - valorB) / valorA;
    double valorMultiplicacion = valorA * valorX;
    double valorSuma = valorB + valorMultiplicacion;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kColorBotones,
        border: Border.all(
          width: 10.0,
          color: kColorFondo,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Center(
              child: Text(
                "\n${AppLocalizations.of(context)!.solucion}\nX = ${implementFraction(valorX)}\n",
                style: kEstiloTextoMenus,
              ),
            ),
          ),
          Math.tex(
              "(${implementFraction(valorA)} * ${implementFraction(valorX)})",
              mathStyle: MathStyle.display,
              textStyle: kTextoLatexFormulas),
          const SizedBox(
            height: 10,
          ),
          Math.tex(
              "+ ${implementFraction(valorB)}=${implementFraction(valorC)}",
              mathStyle: MathStyle.display,
              textStyle: kTextoLatexFormulas),
          const SizedBox(height: 15),
          Math.tex(
              "${implementFraction(valorMultiplicacion)}+${implementFraction(valorB)}",
              mathStyle: MathStyle.display,
              textStyle: kTextoLatexFormulas),
          const SizedBox(
            height: 10,
          ),
          Math.tex("=${implementFraction(valorC)}",
              mathStyle: MathStyle.display, textStyle: kTextoLatexFormulas),
          const SizedBox(height: 15),
          Math.tex(
              "${implementFraction(valorSuma)}=${implementFraction(valorC)}",
              mathStyle: MathStyle.display,
              textStyle: kTextoLatexFormulas),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
