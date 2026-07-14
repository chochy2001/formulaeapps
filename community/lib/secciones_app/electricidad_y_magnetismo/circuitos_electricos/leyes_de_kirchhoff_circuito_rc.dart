import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class LeyesDeKirchhoffCircuitoRC extends StatefulWidget {
  const LeyesDeKirchhoffCircuitoRC({super.key});
  @override
  State<LeyesDeKirchhoffCircuitoRC> createState() =>
      _LeyesDeKirchhoffCircuitoRCState();
}

class _LeyesDeKirchhoffCircuitoRCState
    extends State<LeyesDeKirchhoffCircuitoRC> {
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
              AppLocalizations.of(context)!.leyesKirchhoffCircuitoRC,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .leyesKirchhoffCircuitoRC,
                      widgetName: kWidgetLeyesDeKirchhoffCircuitoRc),
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
                                  .leyesKirchhoffCircuitoRC,
                              widgetName: kWidgetLeyesDeKirchhoffCircuitoRc),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .leyesKirchhoffCircuitoRC,
                              widgetName: kWidgetLeyesDeKirchhoffCircuitoRc),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeVoltajesDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_1 + V_2 + V_3 = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"-\epsilon + V_R + V_C = 0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeCorrientesDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_e = i_s"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_R = i_C"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .diferenciaDePotencialEnElResistor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_R(t) = Ri_R(t)"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .diferenciaDePotencialEnElCapacitor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"q(t) = CV_c(t)"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"i_C(t) = \frac{dq(t)}{dt} = C \frac{dV_C(t)}{dt}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ecuacionDiferencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\frac{dV_C(t)}{dt}+ \frac{V_C(t)}{RC} = \frac{\epsilon}{RC}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solucionALaEcucacionDiferencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"V_C = V_C,_{homogénea} + V_C,_{particular}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.enHomogenea,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\frac{dV_C}{dt}+ \frac{V_C}{RC} = 0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solucionHomogenea,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C = a_1e^{-\frac{1}{RC}t}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ecuacionDiferencialNoHomogenea,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"\frac{dV_C}{dt}+ \frac{V_C}{RC} = \frac{\epsilon}{RC}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solucionParticular,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C = a_2 = \epsilon"),
                const SizedBox(height: 20.0),
                const Divider(thickness: .2, color: kColorTextoBotones),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"V_C = a_1e^{-\frac{1}{RC}t}+ \epsilon"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.condicionALaFrontera,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C(0) = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"a_1 = -\epsilon"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .constantesDeTiempoDeCargaEnElCapacitor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"\tau = RC[s]"),
                const SizedBox(height: 40.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context,
                            kImagenDiferenciaDePotencialEnElCapacitor) ??
                        kUrlImagenDiferenciaDePotencialEnElCapacitor),
                const SizedBox(height: 40.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenCorrienteEnElCapacitor) ??
                        kUrlImagenCorrienteEnElCapacitor),
                const SizedBox(height: 40.0),
                const Divider(thickness: .2, color: kColorTextoBotones),
                const SizedBox(height: 20.0),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenLeyesDeKirchhoffCircuitoRC),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.alTiempoT0InterruptorPosicionB,
                ),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.procesoDeDescargaEnUnCapacitor,
                ),
                const SizedBox(height: 40.0),
                const Divider(thickness: .2, color: kColorTextoBotones),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeVoltajesDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_1 + V_2 = 0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_R + V_C = 0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.leyDeCorrientesDeKirchhoff,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_R(t)+i_C(t)=0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"i_R(t)= -i_C(t)"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .diferenciaDePotencialEnElResistor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_R(t)= Ri_R(t)"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .diferenciaDePotencialEnElCapacitor,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"q(t) = CV_C(t)"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"i_C(t) = \frac{dq(t)}{dt} = C \frac{dV_C(t)}{dt}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"Ri_R(t) - V_C(t) = -RC \frac{dV_C(t)}{dt}-V_C(t)=0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.ecuacionDiferencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\frac{dV_C(t)}{dt}+\frac{V_C}{RC}=0"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.solucionALaEcucacionDiferencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C = a_1e^{-\frac{1}{RC}t}"),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.condicionALaFrontera,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_C(0) = V_0"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"a_1 = V_0"),
                const SizedBox(height: 20.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(context,
                            kImagenDiferenciaDePotencialEnElCapacitor1) ??
                        kUrlImagenDiferenciaDePotencialEnElCapacitor1),
                const SizedBox(height: 40.0),
                ZoomImagePersonalizado(
                    urlImagen: getImageUrlById(
                            context, kImagenCorrienteEnElCapacitor1) ??
                        kUrlImagenCorrienteEnElCapacitor1),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetLeyesDeKirchhoffCircuitoRc,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetLeyesDeKirchhoffCircuitoRc,
            ),
          ],
        ),
      ),
    );
  }
}
