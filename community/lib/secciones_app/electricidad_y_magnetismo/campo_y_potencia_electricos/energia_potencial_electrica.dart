import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class EnergiaPotencialElectrica extends StatefulWidget {
  const EnergiaPotencialElectrica({super.key});
  @override
  State<EnergiaPotencialElectrica> createState() =>
      _EnergiaPotencialElectricaState();
}

class _EnergiaPotencialElectricaState extends State<EnergiaPotencialElectrica> {
  final FormulaeAdsController _ads = FormulaeAdsController();

  @override
  void initState() {
    super.initState();
    _ads.start(
      onBannerReady: () {
        if (mounted) setState(() {});
      },
    );
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
              AppLocalizations.of(context)!.energiaPotencialElectrica,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                    title: AppLocalizations.of(
                      context,
                    )!.energiaPotencialElectrica,
                    widgetName: kWidgetEnergiaPotencialElectrica,
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
                            title: AppLocalizations.of(
                              context,
                            )!.energiaPotencialElectrica,
                            widgetName: kWidgetEnergiaPotencialElectrica,
                          ),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                            title: AppLocalizations.of(
                              context,
                            )!.energiaPotencialElectrica,
                            widgetName: kWidgetEnergiaPotencialElectrica,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            const ZoomImagePersonalizado(
              urlImagen: kUrlImagenEnergiaPotencialElectrica,
            ),

            TextoEcuaciones(AppLocalizations.of(context)!.fuerzaCampoElectrico),

            const SizedBox(height: 30.0),
            TextoEcuaciones(AppLocalizations.of(context)!.trabajoCarga),

            const SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                const Latex(
                  formulaText: r"_B W _A = \int_B^A \vec{F} \cdot d\vec{l}",
                ),
                const SizedBox(height: 40.0),
                const Latex(formulaText: r"[_B W _A]_u = [J]"),
                const SizedBox(height: 40.0),
                const Latex(
                  formulaText: r"_B W _A = -q \int_B^A \vec{E} \cdot d\vec{l}",
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.campoConservativo,
                ),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"_B W _A = U_A - U_B"),
                const SizedBox(height: 40.0),
                const Latex(formulaText: r"V_A = \frac{U_A}{q}"),
                const SizedBox(height: 40.0),
                const Latex(formulaText: r"U_A"),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.energiaPotencialElectricaTexto,
                ),
                const Latex(formulaText: r"V_A"),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.diferenciaPotencialTexto,
                ),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"V_{AB} = V_A - V_B"),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"_B W _A = q V_{AB}"),
                const SizedBox(height: 30.0),
                const Latex(
                  formulaText: r"- \int_B^A \vec{E} \cdot d\vec{l} = V_{AB}",
                ),
                const SizedBox(height: 40.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.unidadEnergiaPotencial,
                ),
                const SizedBox(height: 30.0),
                const Latex(
                  formulaText: r"[V_{AB}]_u = \left[ \frac{J}{C}\right] = [V]",
                ),
                const SizedBox(height: 30.0),
                const Latex(formulaText: r"[V] = Volt"),
              ],
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(url: kWidgetEnergiaPotencialElectrica),
            //Descargar PDF
            const DescargarPDF(url: kWidgetEnergiaPotencialElectrica),
          ],
        ),
      ),
    );
  }
}
