import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class CapacitorDePlacasPlanasYParalelas extends StatefulWidget {
  const CapacitorDePlacasPlanasYParalelas({super.key});
  @override
  State<CapacitorDePlacasPlanasYParalelas> createState() =>
      _CapacitorDePlacasPlanasYParalelasState();
}

class _CapacitorDePlacasPlanasYParalelasState
    extends State<CapacitorDePlacasPlanasYParalelas> {
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
              AppLocalizations.of(context)!.capacitorPlacasPlanasParalelas,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .capacitorPlacasPlanasParalelas,
                      widgetName: kWidgetCapacitorDePlacasPlanasYParalelas),
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
                                  .capacitorPlacasPlanasParalelas,
                              widgetName:
                                  kWidgetCapacitorDePlacasPlanasYParalelas),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .capacitorPlacasPlanasParalelas,
                              widgetName:
                                  kWidgetCapacitorDePlacasPlanasYParalelas),
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
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenCapacitorDePlacasPlanasYParalelas),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.diferenciaDePotencialParPlacas,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"V_{AB} = \frac{\sigma}{\varepsilon _0}(r_A - r_B)"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.conLaGeometriaDelProblema,
                ),
                const Latex(
                    formulaText:
                        r"V=\frac{\sigma}{\varepsilon _0}d = \sigma \frac{d}{\varepsilon _0} = \frac{Q}{A} \cdot \frac{d}{\varepsilon _0} = \frac{d}{\varepsilon _0 A} \cdot Q"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .deAcuerdoALaDefinicionDeCapacitancia,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V=\frac{Q}{C}"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText: r"\frac{d}{\varepsilon _0 A} = \frac{1}{C}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"C= \varepsilon _0 \frac{A}{d}"),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetCapacitorDePlacasPlanasYParalelas,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetCapacitorDePlacasPlanasYParalelas,
            ),
          ],
        ),
      ),
    );
  }
}
