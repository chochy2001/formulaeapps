import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class EnergiaYCapacitancia extends StatefulWidget {
  const EnergiaYCapacitancia({super.key});
  @override
  State<EnergiaYCapacitancia> createState() => _EnergiaYCapacitanciaState();
}

class _EnergiaYCapacitanciaState extends State<EnergiaYCapacitancia> {
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
              AppLocalizations.of(context)!.energiaCapacitancia,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.energiaCapacitancia,
                      widgetName: kWidgetEnergiaYCapacitancia),
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
                                  .energiaCapacitancia,
                              widgetName: kWidgetEnergiaYCapacitancia),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .energiaCapacitancia,
                              widgetName: kWidgetEnergiaYCapacitancia),
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
                  AppLocalizations.of(context)!.capacitancia,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"C = \frac{Q}{V}"),
                ZoomImagePersonalizado(
                    urlImagen:
                        getImageUrlById(context, kImagenEnergiaYCapacitancia) ??
                            kUrlImagenEnergiaYCapacitancia),
                TextoEcuaciones(
                  AppLocalizations.of(context)!
                      .energiaPotencialElectricaDiferenciaPotencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V = \frac{u}{q}"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"u = qV"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"du = dqV"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V = \frac{q}{C}"),
                const SizedBox(height: 20.0),
                const SizedBox(height: 40.0),
                const Latex(
                    formulaText: r"\int_o^U du  = \int_0^Q \frac{q}{C}dq"),
                const SizedBox(height: 40.0),
                const Latex(
                    formulaText:
                        r"U = \frac{1}{2} \frac{Q^2}{C} = \frac{1}{2}CV^2 = \frac{1}{2}QV"),
                const SizedBox(height: 20.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetEnergiaYCapacitancia,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetEnergiaYCapacitancia,
            ),
          ],
        ),
      ),
    );
  }
}
