import 'package:flutter/material.dart';
import 'package:formulae/ads/formulae_ads_controller.dart';
import '../../../constantes/export_constantes.dart';

class InductoresEnSerie extends StatefulWidget {
  const InductoresEnSerie({super.key});
  @override
  State<InductoresEnSerie> createState() => _InductoresEnSerieState();
}

class _InductoresEnSerieState extends State<InductoresEnSerie> {
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
              AppLocalizations.of(context)!.inductoresEnSerie,
            ),
            adContainer,
            Consumer<FavoritesNotifier>(
              builder: (context, favoritesNotifier, child) {
                bool isFavorite = favoritesNotifier.isFavorite(
                  Favorite(
                      title: AppLocalizations.of(context)!.inductoresEnSerie,
                      widgetName: kWidgetInductoresEnSerie),
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
                                  .inductoresEnSerie,
                              widgetName: kWidgetInductoresEnSerie),
                        );
                      } else {
                        favoritesNotifier.addFavorite(
                          Favorite(
                              title: AppLocalizations.of(context)!
                                  .inductoresEnSerie,
                              widgetName: kWidgetInductoresEnSerie),
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
                  AppLocalizations.of(context)!.conexionEnSerieSimbologia,
                ),
                const ZoomImagePersonalizado(
                    urlImagen: kUrlImagenConexionEnSerieInductor),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.corrienteYDiferenciaDePotencial,
                ),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"I = I_1 = I_2"),
                const SizedBox(height: 20.0),
                const Latex(formulaText: r"V_{AC} = V_{AB}+V_{BC}"),
                const SizedBox(height: 20.0),
                TextoEcuaciones(
                  AppLocalizations.of(context)!.elSegundoAlambre,
                ),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"V_{AB} = \frac{d}{dt}\Phi_B = \frac{d}{dt}(L_1I-MI)"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"V_{BC} = \frac{d}{dt}\Phi_B = \frac{d}{dt}(L_2I-MI)"),
                const SizedBox(height: 20.0),
                const Latex(
                    formulaText:
                        r"V_{AC} = V_{BC}= (L_1 + L_2 - 2M) \frac{dI}{dt}"),
                const SizedBox(height: 40.0),
              ],
            ),

            //Boton para acceder al formulario en PDF
            const VerPDF(
              url: kWidgetInductoresEnSerie,
            ),
            //Descargar PDF
            const DescargarPDF(
              url: kWidgetInductoresEnSerie,
            ),
          ],
        ),
      ),
    );
  }
}
