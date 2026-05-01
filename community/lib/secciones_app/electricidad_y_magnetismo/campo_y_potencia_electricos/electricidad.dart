import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class Electricidad extends StatefulWidget {
  @override
  State<Electricidad> createState() => _ElectricidadState();
}

class _ElectricidadState extends State<Electricidad> {
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
              AppLocalizations.of(context)!.electricidad,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.electricidad,
                      widgetName: kWidgetElectricidad),
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
                              title: AppLocalizations.of(context)!.electricidad,
                              widgetName: kWidgetElectricidad),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!.electricidad,
                              widgetName: kWidgetElectricidad),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),

            TextoEcuaciones(
              AppLocalizations.of(context)!.electricidad,
            ),
            const SizedBox(height: 10.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.origenElectricidad,
            ),
            const SizedBox(height: 10.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.conceptoCarga,
            ),

            const SizedBox(height: 35.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.efectosAmbar,
            ),

            const SizedBox(height: 20.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.postulacionSustancia,
            ),

            const SizedBox(height: 20.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.tiposSustancia,
            ),

            const SizedBox(height: 20.0),
            TextoBotonesDelgado(
              AppLocalizations.of(context)!.descubrimientoElectron,
            ),

            const SizedBox(height: 20.0),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetElectricidad,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetElectricidad,
            ),
          ],
        ),
      ),
    );
  }
}
