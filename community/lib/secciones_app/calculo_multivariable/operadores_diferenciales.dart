import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class OperadoresDiferenciales extends StatefulWidget {
  @override
  _OperadoresDiferencialesState createState() =>
      _OperadoresDiferencialesState();
}

class _OperadoresDiferencialesState extends State<OperadoresDiferenciales> {
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
              AppLocalizations.of(context)!.operadoresDiferenciales,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title:
                          AppLocalizations.of(context)!.operadoresDiferenciales,
                      widgetName: kWidgetOperadoresDiferenciales),
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
                                  .operadoresDiferenciales,
                              widgetName: kWidgetOperadoresDiferenciales),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .operadoresDiferenciales,
                              widgetName: kWidgetOperadoresDiferenciales),
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
                  const Latex(formulaText: r"\vec{F}"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!
                        .funcionVectorialDeLasVariables,
                  ),
                  const Latex(formulaText: r"x,y,z"),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.divergencia,
                  ),
                  const Latex(
                      formulaText:
                          r"\nabla \cdot \vec{F} = \frac{\partial F_x}{\partial x}+\frac{\partial F_y}{\partial y}+\frac{\partial F_z}{\partial z}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"F_x,F_y,F_z"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.componentesDe,
                  ),
                  const Latex(formulaText: r"\vec{F}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.rotacional,
                  ),
                  const Latex(formulaText: r"\nabla \times \vec{F} ="),
                  const SizedBox(height: 10),
                  const Latex(
                      formulaText:
                          r"\hat{i} \begin{vmatrix}\frac{\partial}{\partial y} & \frac{\partial}{\partial z}\\F_y & F_z\\\end{vmatrix} - \hat{j} \begin{vmatrix}\frac{\partial}{\partial x} & \frac{\partial}{\partial z}\\F_x & F_z\\\end{vmatrix} + \hat{k} \begin{vmatrix}\frac{\partial}{\partial x} & \frac{\partial}{\partial y}\\F_x & F_y\\\end{vmatrix}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laplaciano,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(formulaText: r"f"),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.funcionEscalar,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\nabla ^2 f = \frac{\partial ^2 f}{\partial x^2}+\frac{\partial ^2 f}{\partial y^2}+\frac{\partial ^2 f}{\partial z^2}"),
                  const SizedBox(height: kEspacioEntreBotones),
                  const SizedBox(height: kEspacioEntreBotones),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.laplacianoDeUnCampoVectorial,
                  ),
                  const SizedBox(height: kEspacioEntreBotones),
                  const Latex(
                      formulaText:
                          r"\nabla ^2 \vec{A} = \nabla (\nabla \cdot \vec{A}) - \nabla \times(\nabla\times\vec{A})"),
                  const SizedBox(height: 10),
                  const Latex(formulaText: r"= (\nabla\cdot\nabla)\vec{A}"),
                  const SizedBox(height: kEspacioEntreBotones),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetOperadoresDiferenciales,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetOperadoresDiferenciales,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
