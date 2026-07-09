import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class FuerzaMagneticaComoVectorSobreCargasEnMovimiento extends StatefulWidget {
  @override
  State<FuerzaMagneticaComoVectorSobreCargasEnMovimiento> createState() =>
      _FuerzaMagneticaComoVectorSobreCargasEnMovimientoState();
}

class _FuerzaMagneticaComoVectorSobreCargasEnMovimientoState
    extends State<FuerzaMagneticaComoVectorSobreCargasEnMovimiento> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(onBannerReady: () { if (mounted) setState(() {}); });
  }


  Widget get adContainer => _ads.banner;

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
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
