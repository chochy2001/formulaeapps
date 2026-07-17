import 'package:flutter/material.dart';
import '../../../constantes/export_constantes.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';

class CargaProtonElectron extends StatefulWidget {
  const CargaProtonElectron({super.key});

  @override
  State<CargaProtonElectron> createState() => _CargaProtonElectronState();
}

class _CargaProtonElectronState extends State<CargaProtonElectron> {
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
              AppLocalizations.of(context)!.cargaElectricaProtonElectron,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!
                          .cargaElectricaProtonElectron,
                      widgetName: kWidgetCargaProtonyElectron),
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
                                  .cargaElectricaProtonElectron,
                              widgetName: kWidgetCargaProtonyElectron),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .cargaElectricaProtonElectron,
                              widgetName: kWidgetCargaProtonyElectron),
                        );
                      }
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20.0),
            ZoomPersonalizado(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cargaElectron,
                  ),
                  const SizedBox(height: 10.0),
                  const Latex(
                      formulaText:
                          r"q_e = -1.60218 \times 10^{-19} \space [C]"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.cargaProton,
                  ),
                  const SizedBox(height: 10.0),
                  const Latex(
                      formulaText: r"q_e = 1.60218 \times 10^{-19} \space [C]"),
                  const SizedBox(height: 20.0),
                  TextoEcuaciones(
                    AppLocalizations.of(context)!.unidadCarga,
                  ),
                  const SizedBox(height: 10.0),
                  const Latex(formulaText: r"[C] = Coulomb"),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetCargaProtonyElectron,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetCargaProtonyElectron,
            ),
          ],
        ),
      ),
    );
  }
}
