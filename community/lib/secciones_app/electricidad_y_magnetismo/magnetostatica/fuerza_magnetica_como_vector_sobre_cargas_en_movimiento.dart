import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../constantes/export_constantes.dart';

class FuerzaMagneticaComoVectorSobreCargasEnMovimiento extends StatefulWidget {
  @override
  State<FuerzaMagneticaComoVectorSobreCargasEnMovimiento> createState() =>
      _FuerzaMagneticaComoVectorSobreCargasEnMovimientoState();
}

class _FuerzaMagneticaComoVectorSobreCargasEnMovimientoState
    extends State<FuerzaMagneticaComoVectorSobreCargasEnMovimiento> {
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
              AppLocalizations.of(context)!
                  .fuerzaMagneticaComoVectorSobreCargasEnMovimiento,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .fuerzaMagneticaComoVectorSobreCargasEnMovimiento,
                      widgetName:
                          kWidgetFuerzaMagneticaComoVectorSobreCargasEnMovimiento),
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
                                  .fuerzaMagneticaComoVectorSobreCargasEnMovimiento,
                              widgetName:
                                  kWidgetFuerzaMagneticaComoVectorSobreCargasEnMovimiento),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .fuerzaMagneticaComoVectorSobreCargasEnMovimiento,
                              widgetName:
                                  kWidgetFuerzaMagneticaComoVectorSobreCargasEnMovimiento),
                        );
                      }
                    });
                  },
                );
              },
            ),

            Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.analogiaConCampoElectrico,
                ),
                const SizedBox(height: 40.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenAnalogiaConCampoElectrico1),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elEfectoDeUnCampoElectrico,
                ),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenAnalogiaConCampoElectrico2),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elEfectoDeUnCampoMagnetico,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unImanEsUnObjetoTexto,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\vec{F}_{em} = \vec{F}_e + \vec{F}_m"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.fuerzaDeLorentz,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{F}_{em} = q \vec{E} + q\vec{v} \times \vec{B}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.fuerzaMagnetica,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\vec{F}_m = q \vec{v} \times \vec{B}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"B=\frac{F_m}{qv\sin{\theta}}"),
                const SizedBox(height: 30.0),
                const Latex(
                    formulaText:
                        r"[B]_u=\left[\frac{N}{C\cdot\frac{m}{s}}\right]= [ T ]"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.magnitudDeLaFuerzaMagnetica,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"F_m = q v B \sin{\theta}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.direccionDeLaFuerzaMagnetica,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\vec{v}\times\vec{B} =\begin{Vmatrix}\vec{i} & \vec{j} & \vec{k}\\v_x & v_y & v_z\\B_x & B_y & B_z\end{Vmatrix}"),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen:
                        getImageUrlById(context, kImagenReglaDeLaManoDerecha) ??
                            kUrlImagenReglaDeLaManoDerecha),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .laFuerzaMagneticaEsSiemprePerpendicular,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .laFuerzaMagneticaNoRealizaTrabajo,
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .laDireccionDeLaFuerzaDependeDelSigno,
                ),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetFuerzaMagneticaComoVectorSobreCargasEnMovimiento,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetFuerzaMagneticaComoVectorSobreCargasEnMovimiento,
            ),
          ],
        ),
      ),
    );
  }
}
